import 'package:jais/entities/episode.dart';
import 'package:jais/entities/episodetype.dart';
import 'package:jais/entities/langtype.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/country_mapper.dart';

class Dictionary {
  static String getSeason() {
    switch (CountryMapper.selectedCountry?.tag) {
      case 'fr':
        return 'Saison';
      default:
        break;
    }

    return '??';
  }

  static String getEpisodeType(EpisodeType episodeType) {
    switch (CountryMapper.selectedCountry?.tag) {
      case 'fr':
        if (episodeType.name == 'EPISODE') {
          return 'Épisode';
        }

        if (episodeType.name == 'SPECIAL') {
          return 'Spécial';
        }

        break;
      default:
        break;
    }

    return '??';
  }

  static String getLangType(LangType langType) {
    switch (CountryMapper.selectedCountry?.tag) {
      case 'fr':
        if (langType.name == 'SUBTITLES') {
          return 'VOSTFR';
        }

        if (langType.name == 'VOICE') {
          return 'VF';
        }

        break;
      default:
        break;
    }

    return '??';
  }

  static String getNaturalSeason(Simulcast simulcast) {
    switch (CountryMapper.selectedCountry?.tag) {
      case 'fr':
        if (simulcast.season == 'WINTER') {
          return 'Hivers';
        }

        if (simulcast.season == 'SPRING') {
          return 'Printemps';
        }

        if (simulcast.season == 'SUMMER') {
          return 'Été';
        }

        if (simulcast.season == 'AUTUMN') {
          return 'Automne';
        }

        break;
      default:
        break;
    }

    return '??';
  }

  static String getEpisodeDetails(Episode episode) {
    // Saison 1 • Épisode 5 VOSTFR
    return '${getSeason()} ${episode.season} • ${getEpisodeType(episode.episodeType)} ${episode.number} ${getLangType(episode.langType)}';
  }
}
