import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Const {
  static final Const instance = Const();
  static const double platformImageWith = 20;
  static const double platformImageHeight = 20;
  static const double episodeImageHeight = 200;
  static const double animeImageWith = 75;
  static const double animeImageHeight = 100;
  static const double missingAnimeImageWith = 64;
  static const double missingAnimeImageHeight = 64;
  static const double profileEpisodeImageWidth = 250;
  static const double profileEpisodeImageHeight = 125;
  static const double profileAnimeImageWidth = 100;
  static const double profileAnimeImageHeight = 125;

  static const String selectedCountry = 'fr';

  static const double defaultRadius = 16;

  static const String serverUrl = "beta-api.ziedelth.fr";
  // static const String serverUrl = "alpha-api.ziedelth.fr";
  // static const String serverUrl = "192.168.1.71:8080";

  String get serverUrlWithHttpProtocol => 'https://$serverUrl';
}

class Utils {
  static final Utils instance = Utils();

  String formatDuration(Duration duration) {
    if (duration.isNegative) return '??:??';

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    String formattedDuration = '$twoDigitMinutes:$twoDigitSeconds';

    final int hours = duration.inHours;

    if (hours > 0) {
      String twoDigitHours = twoDigits(hours);
      formattedDuration = '$twoDigitHours:$formattedDuration';
    }

    return formattedDuration;
  }

  String fullFormatDuration(Duration duration) {
    if (duration.isNegative || duration.inSeconds == 0) {
      return '0s';
    }

    Map<String, int> timeParts = {
      'j': duration.inDays,
      'h': duration.inHours.remainder(24),
      'min': duration.inMinutes.remainder(60),
      's': duration.inSeconds.remainder(60)
    };

    return timeParts.entries
        .where((entry) => entry.value > 0)
        .map((entry) => '${entry.value}${entry.key}')
        .join(' ')
        .trim();
  }

  String printTimeSince(BuildContext context, String releaseDate) {
    final double seconds = (DateTime.now().millisecondsSinceEpoch -
            DateTime.parse(releaseDate).millisecondsSinceEpoch) /
        1000;

    Map<int, String Function(int)> timeUnits = {
      31536000: (x) => AppLocalizations.of(context)!.year(x),
      2592000: (x) => AppLocalizations.of(context)!.month(x),
      86400: (x) => AppLocalizations.of(context)!.day(x),
      3600: (x) => AppLocalizations.of(context)!.hour(x),
      60: (x) => AppLocalizations.of(context)!.minute(x),
    };

    for (var timeUnit in timeUnits.entries) {
      String? formatted = _formatTime(seconds, timeUnit.key, timeUnit.value);
      if (formatted != null) return formatted;
    }

    return AppLocalizations.of(context)!.now;
  }

  String toDateTimeString(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String? _formatTime(double seconds, int value, String Function(int) text) {
    final double interval = seconds / value;

    if (interval > 1) {
      return text.call(interval.floor());
    }

    return null;
  }

  List<Widget> separate(List<Widget> children, {int rowCol = 3}) {
    return [
      for (int i = 0; i < children.length; i += rowCol)
        _buildRow(children, i, rowCol),
    ];
  }

  Widget _buildRow(List<Widget> children, int start, int rowCol) {
    final end = min(start + rowCol, children.length);
    final sublist = children.sublist(start, end);

    return Row(
      children: [
        for (final widget in sublist) Expanded(child: widget),
        for (int i = sublist.length; i < rowCol; i++)
          Expanded(child: Container()),
      ],
    );
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius:
          const BorderRadius.all(Radius.circular(Const.defaultRadius)),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(4, 4),
        ),
      ],
    );
  }
}

extension StringExt on String? {
  String ifEmptyOrNull(String replacement) =>
      (this == null || this?.isEmpty == true) ? replacement : this!;
}

extension ScrollControllerExt on ScrollController {
  Future<void> scrollTo(
    double position, {
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    try {
      animateTo(
        position,
        duration: duration,
        curve: Curves.easeInOut,
      );
    } catch (_) {}
  }

  Future<void> scrollToEnd() async {
    scrollTo(position.maxScrollExtent);
  }
}

extension BuildContextExt on BuildContext {
  bool get isOnMobile {
    return MediaQuery.of(this).size.width < 768;
  }

  Color get mainBackgroundColor {
    return Theme.of(this).scaffoldBackgroundColor;
  }
}

extension ListWidgetExt on List<Widget> {
  Iterable<Widget> joinWidget(Widget separator) sync* {
    if (isEmpty) {
      return;
    }

    yield this[0];

    for (int i = 1; i < length; i++) {
      yield separator;
      yield this[i];
    }
  }
}
