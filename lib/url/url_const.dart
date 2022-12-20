import 'package:jais/mappers/country_mapper.dart';
import 'package:jais/models/simulcast.dart';

class UrlConst {
  static final UrlConst instance = UrlConst();

  static const String domain = 'beta-api.ziedelth.fr';
  static const String baseUrl = 'https://$domain/';
  static const String countries = '${baseUrl}countries';
  static const String episodes = '${baseUrl}episodes/';
  static const String simulcasts = '${baseUrl}simulcasts/';
  static const String animes = '${baseUrl}animes/';
  static const String mangas = '${baseUrl}mangas/';
  static const String platforms = '${baseUrl}platforms/';
  static const String devices = '${baseUrl}devices';
  static const String episodeAttachment = '${episodes}attachment/';
  static const String animeAttachment = '${animes}attachment/';
  static const String mangasAttachment = '${mangas}attachment/';
  static const String platformAttachment = '${platforms}attachment/';

  String getEpisodesPage(int page, int limit) {
    return '${episodes}country/${CountryMapper.selectedCountry?.tag}/page/$page/limit/$limit';
  }

  String getEpisodesAnimePage(String uuid, int page, int limit) {
    return '${episodes}anime/$uuid/page/$page/limit/$limit';
  }

  String getEpisodesWatchlistPage(int page, int limit) {
    return '${episodes}watchlist/page/$page/limit/$limit';
  }

  String getMangasPage(int page, int limit) {
    return '${mangas}country/${CountryMapper.selectedCountry?.tag}/page/$page/limit/$limit';
  }

  String getMangaSearch(String ean) {
    return '${mangas}country/${CountryMapper.selectedCountry?.tag}/search/ean/$ean';
  }

  String getMangasWatchlistPage(int page, int limit) {
    return '${mangas}watchlist/page/$page/limit/$limit';
  }

  String getSimulcasts() {
    return '${simulcasts}country/${CountryMapper.selectedCountry?.tag}';
  }

  String getAnimesPage(Simulcast simulcast, int page, int limit) {
    return '${animes}country/${CountryMapper.selectedCountry?.tag}/simulcast/${simulcast.uuid}/page/$page/limit/$limit';
  }

  String getAnimesWatchlistPage(int page, int limit) {
    return '${animes}watchlist/page/$page/limit/$limit';
  }

  String getAnimesSearch(String query) {
    return '${animes}country/${CountryMapper.selectedCountry?.tag}/search/name/$query';
  }

  String getAnimesDiary(int day) {
    return '${animes}diary/country/${CountryMapper.selectedCountry?.tag}/day/$day';
  }
}
