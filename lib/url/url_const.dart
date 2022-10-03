import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/country_mapper.dart';

class UrlConst {
  static const String domain = 'https://beta-api.ziedelth.fr/';
  static const String countries = '${domain}countries';
  static const String episodes = '${domain}episodes/';
  static const String simulcasts = '${domain}simulcasts';
  static const String animes = '${domain}animes/';
  static const String episodeAttachment = '${episodes}attachment/';
  static const String platformImage = 'https://ziedelth.fr/images/platforms/';

  static String getEpisodesPage(int page, int limit) {
    return '${episodes}country/${CountryMapper.selectedCountry?.tag}/page/$page/limit/$limit';
  }

  static String getAnimesPage(Simulcast simulcast, int page, int limit) {
    return '${animes}country/${CountryMapper.selectedCountry?.tag}/simulcast/${simulcast.uuid}/page/$page/limit/$limit';
  }
}
