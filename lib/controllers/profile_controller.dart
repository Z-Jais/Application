import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/datas/collection_data_controller.dart';
import 'package:jais/controllers/datas/string_data_controller.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/controllers/notification_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/models/profile.dart';
import 'package:jais/utils.dart';

class ProfileController {
  static final ProfileController instance = ProfileController();

  final baseUrl = '${Const.instance.serverUrlWithHttpProtocol}/profile';
  final StringDataController _registeredDevice =
      StringDataController('registeredDevice');

  Profile? _profile;

  String get registeredDevice => _registeredDevice.data;
  Profile? get profile => _profile;
  List<String> get animesInWatchlist => _profile?.animes ?? [];
  List<String> get episodesInWatchlist => _profile?.episodes ?? [];

  String _jsonEncodeGzip(Map<String, dynamic> data) {
    return base64Encode(gzip.encode(utf8.encode(jsonEncode(data))));
  }

  Future<void> setTokenUuid(String tokenUuid) async {
    _registeredDevice.data = tokenUuid;
    await _registeredDevice.save();
  }

  Future<bool> _registerDevice() async {
    final CollectionDataController watchlist =
        CollectionDataController('animeWatchlist');
    final CollectionDataController seen =
        CollectionDataController('episodesSeen');

    await watchlist.init();
    await seen.init();

    final String gzipData = (watchlist.data.isNotEmpty || seen.data.isNotEmpty)
        ? _jsonEncodeGzip({'animes': watchlist.data, 'episodes': seen.data})
        : '';

    final Response? response = await URLController.instance.post(
      '$baseUrl/register',
      gzipData,
    );

    if (!response.isOk) {
      warning(
        'ProfileController',
        'Cannot register device, response: $response',
      );

      return false;
    }

    final String registeredDevice = jsonDecode(response!.body)['tokenUuid'];
    await setTokenUuid(registeredDevice);

    // Reset old data only if registered correctly
    await watchlist.reset();
    await seen.reset();

    return true;
  }

  Future<void> init() async {
    await _registeredDevice.init();

    // REGISTER PART
    if (_registeredDevice.firstInit && !await _registerDevice()) {
      return;
    }

    // LOGIN PART
    debug('ProfileController', 'Registered device: ${_registeredDevice.data}');

    final Response? response = await URLController.instance.post(
      '$baseUrl/login',
      _registeredDevice.data,
    );

    if (!response.isOk) {
      if (response!.statusCode == HttpStatus.notFound) {
        if (!await _registerDevice()) {
          return;
        }

        return await init();
      }

      warning(
        'ProfileController',
        'Cannot login device, response: $response',
      );

      return;
    }

    _profile = Profile.fromJson(jsonDecode(response!.body));
    debug('ProfileController', 'Profile: ${_profile?.uuid}');
  }

  Future<void> delete() async {
    final Response? response = await URLController.instance.delete(
      baseUrl,
      token: profile?.token,
    );

    if (!response.isOk) {
      warning(
        'ProfileController',
        'Cannot delete profile, response: $response',
      );

      return;
    }

    _profile = null;
    await _registeredDevice.reset();
    await FilterController.instance.reset();
    await NotificationController.instance.delete();
    await AppController.instance.reset();
  }

  Future<Response?> getMissingAnimes(int page, int limit) async {
    final String episodeTypes =
        FilterController.instance.watchlistEpisodeTypeFilter.data.join(',');
    final String langTypes =
        FilterController.instance.watchlistLangTypeFilter.data.join(',');

    return URLController.instance.get(
      '$baseUrl/watchlist/animes/missing/page/$page/limit/$limit?episodeTypes=$episodeTypes&langTypes=$langTypes',
      token: profile?.token,
    );
  }

  Future<Response?> getAnimes(int page, int limit) async {
    return URLController.instance.get(
      '$baseUrl/watchlist/animes/page/$page/limit/$limit',
      token: profile?.token,
    );
  }

  Future<Response?> getEpisodes(int page, int limit) async {
    return URLController.instance.get(
      '$baseUrl/watchlist/episodes/page/$page/limit/$limit',
      token: profile?.token,
    );
  }

  bool isAnimeInWatchlist(Anime anime) {
    return animesInWatchlist.contains(anime.uuid);
  }

  Future<void> addAnimeToWatchlist(Anime anime) async {
    if (isAnimeInWatchlist(anime)) {
      return;
    }

    animesInWatchlist.add(anime.uuid);
    anime.notify();

    final Response? response = await URLController.instance.put(
      '$baseUrl/watchlist?anime=${anime.uuid}',
      token: profile?.token,
    );

    if (!response.isOk) {
      warning(
        'ProfileController',
        'Cannot add anime to watchlist, response: $response',
      );

      animesInWatchlist.remove(anime.uuid);
      anime.notify();
      return;
    }
  }

  Future<void> removeAnimeFromWatchlist(Anime anime) async {
    if (!isAnimeInWatchlist(anime)) {
      return;
    }

    animesInWatchlist.remove(anime.uuid);
    anime.notify();

    final Response? response = await URLController.instance.delete(
      '$baseUrl/watchlist?anime=${anime.uuid}',
      token: profile?.token,
    );

    if (!response.isOk) {
      warning(
        'ProfileController',
        'Cannot remove anime from watchlist, response: $response',
      );

      animesInWatchlist.add(anime.uuid);
      anime.notify();
      return;
    }
  }

  Future<void> toggleAnimeInWatchlist(Anime anime) async {
    if (isAnimeInWatchlist(anime)) {
      await removeAnimeFromWatchlist(anime);
    } else {
      await addAnimeToWatchlist(anime);
    }

    if (await NotificationController.instance.isWatchlist) {
      NotificationController.instance.subscribeToWatchlist();
    }
  }

  bool isEpisodeInWatchlist(Episode episode) {
    return episodesInWatchlist.contains(episode.uuid);
  }

  Future<void> addEpisodeToWatchlist(Episode episode) async {
    if (isEpisodeInWatchlist(episode)) {
      return;
    }

    episodesInWatchlist.add(episode.uuid);
    profile?.totalDurationSeen += episode.duration;
    episode.notify();

    final Response? response = await URLController.instance.put(
      '$baseUrl/watchlist?episode=${episode.uuid}',
      token: profile?.token,
    );

    if (!response.isOk) {
      warning(
        'ProfileController',
        'Cannot add episode to watchlist, response: $response',
      );

      episodesInWatchlist.remove(episode.uuid);
      profile?.totalDurationSeen -= episode.duration;
      episode.notify();
      return;
    }
  }

  Future<void> removeEpisodeFromWatchlist(Episode episode) async {
    if (!isEpisodeInWatchlist(episode)) {
      return;
    }

    episodesInWatchlist.remove(episode.uuid);
    profile?.totalDurationSeen -= episode.duration;
    episode.notify();

    final Response? response = await URLController.instance.delete(
      '$baseUrl/watchlist?episode=${episode.uuid}',
      token: profile?.token,
    );

    if (!response.isOk) {
      warning(
        'ProfileController',
        'Cannot remove episode from watchlist, response: $response',
      );

      episodesInWatchlist.add(episode.uuid);
      profile?.totalDurationSeen += episode.duration;
      episode.notify();
      return;
    }
  }

  Future<void> toggleEpisodeInWatchlist(Episode episode) async {
    if (isEpisodeInWatchlist(episode)) {
      await removeEpisodeFromWatchlist(episode);
    } else {
      await addEpisodeToWatchlist(episode);
    }
  }
}
