import 'dart:math';

import 'package:flutter/material.dart';

class Const {
  static final Const instance = Const();
  static const double platformImageWith = 20;
  static const double platformImageHeight = 20;
  static const double episodeImageHeight = 200;
  static const double animeImageWith = 75;
  static const double animeImageHeight = 100;
  static const double missingAnimeImageWith = 64;
  static const double missingAnimeImageHeight = 64;

  static const String serverUrl = "beta-api.ziedelth.fr";
  static const String selectedCountry = 'fr';

  // static const String serverUrl = "alpha-api.ziedelth.fr";
  // static const String serverUrl = "192.168.1.20:8080";

  String get serverUrlWithHttpProtocol => 'https://$serverUrl';

  String get serverUrlWithSocketProtocol => 'wss://$serverUrl';
}

class Utils {
  static final Utils instance = Utils();

  String printDuration(Duration duration) {
    if (duration.isNegative) {
      return '??:??';
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String twoDigitHours = twoDigits(duration.inHours);
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if ((int.tryParse(twoDigitHours) ?? 0) > 0) {
      return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
    } else {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
  }

  String printDurationWithLetters(Duration duration) {
    if (duration.isNegative) {
      return '??:??';
    }

    final int inDays = duration.inDays;
    final int inHours = duration.inHours.remainder(24);
    final int inMinutes = duration.inMinutes.remainder(60);
    final int inSeconds = duration.inSeconds.remainder(60);

    String finalString = '';

    if (inDays > 0) {
      finalString += '${inDays}j ';
    }

    if (inHours > 0) {
      finalString += '${inHours}h ';
    }

    if (inMinutes > 0) {
      finalString += '${inMinutes}min ';
    }

    if (inSeconds > 0) {
      finalString += '${inSeconds}s ';
    }

    return finalString.trim();
  }

  String printTimeSince(DateTime dateTime) {
    final double seconds = (DateTime.now().millisecondsSinceEpoch -
            dateTime.millisecondsSinceEpoch) /
        1000;
    double interval = seconds / 31536000;

    if (interval > 1) {
      return '${interval.floor()} an${interval >= 2 ? 's' : ''}';
    }

    interval = seconds / 2592000;

    if (interval > 1) {
      return '${interval.floor()} mois';
    }

    interval = seconds / 86400;

    if (interval > 1) {
      return '${interval.floor()} jour${interval >= 2 ? 's' : ''}';
    }

    interval = seconds / 3600;

    if (interval > 1) {
      return '${interval.floor()} heure${interval >= 2 ? 's' : ''}';
    }

    interval = seconds / 60;

    if (interval > 1) {
      return '${interval.floor()} minute${interval >= 2 ? 's' : ''}';
    }

    return "à l'instant";
  }

  List<Widget> separate(List<Widget> children, {int rowCol = 3}) {
    final List<Widget> list = <Widget>[];

    for (int i = 0; i < children.length; i += rowCol) {
      final int minV = min(i + rowCol, children.length);
      final int length = minV - i;

      final List<Widget> sublist = children.sublist(i, minV);
      sublist.addAll(List<Widget>.filled(rowCol - length, Container()));

      list.add(
        Row(
          children: <Widget>[
            ...sublist.map<Widget>((Widget e) => Expanded(child: e)),
          ],
        ),
      );
    }

    return list;
  }

  BoxDecoration buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
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
