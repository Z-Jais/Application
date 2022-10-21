import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/country_mapper.dart';

class UrlConst {
  static const String domain = 'https://beta-api.ziedelth.fr/';
  static const String countries = '${domain}countries';
  static const String episodes = '${domain}episodes/';
  static const String simulcasts = '${domain}simulcasts';
  static const String animes = '${domain}animes/';
  static const String mangas = '${domain}mangas/';
  static const String platforms = '${domain}platforms/';
  static const String devices = '${domain}devices/';
  static const String devicesEpisodeRedirection =
      '${devices}redirection/episode';
  static const String devicesMangaRedirection = '${devices}redirection/manga';
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

  static String getMangasPage(int page, int limit) {
    return '${mangas}country/${CountryMapper.selectedCountry?.tag}/page/$page/limit/$limit';
  }

  static String getMangaSearch(String ean) {
    return '${mangas}country/${CountryMapper.selectedCountry?.tag}/search/ean/$ean';
  }

  static String getSimulcasts() {
    return '${simulcasts}country/${CountryMapper.selectedCountry?.tag}';
  }

  static String getAnimesPage(Simulcast simulcast, int page, int limit) {
    return '${animes}country/${CountryMapper.selectedCountry?.tag}/simulcast/${simulcast.uuid}/page/$page/limit/$limit';
  }

  static String getAnimesSearch(String query) {
    return '${animes}country/${CountryMapper.selectedCountry?.tag}/search/name/$query';
  }
}
