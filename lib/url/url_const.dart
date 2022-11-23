import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/country_mapper.dart';

class UrlConst {
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

  static String getEpisodesPage(int page, int limit) {
    return '${episodes}country/${CountryMapper.selectedCountry?.tag}/page/$page/limit/$limit';
  }

  static String getEpisodesAnimePage(String uuid, int page, int limit) {
    return '${episodes}anime/$uuid/page/$page/limit/$limit';
  }

  static String getEpisodesWatchlistPage(int page, int limit) {
    return '${episodes}watchlist/page/$page/limit/$limit';
  }

  static String getMangasPage(int page, int limit) {
    return '${mangas}country/${CountryMapper.selectedCountry?.tag}/page/$page/limit/$limit';
  }

  static String getMangaSearch(String ean) {
    return '${mangas}country/${CountryMapper.selectedCountry?.tag}/search/ean/$ean';
  }

  static String getMangasWatchlistPage(int page, int limit) {
    return '${mangas}watchlist/page/$page/limit/$limit';
  }

  static String getSimulcasts() {
    return '${simulcasts}country/${CountryMapper.selectedCountry?.tag}';
  }

  static String getAnimesPage(Simulcast simulcast, int page, int limit) {
    return '${animes}country/${CountryMapper.selectedCountry?.tag}/simulcast/${simulcast.uuid}/page/$page/limit/$limit';
  }

  static String getAnimesWatchlistPage(int page, int limit) {
    return '${animes}watchlist/page/$page/limit/$limit';
  }

  static String getAnimesSearch(String query) {
    return '${animes}country/${CountryMapper.selectedCountry?.tag}/search/name/$query';
  }

  static String getAnimesDiary(int day) {
    return '${animes}diary/country/${CountryMapper.selectedCountry?.tag}/day/$day';
  }
}
