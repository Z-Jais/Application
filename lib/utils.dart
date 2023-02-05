import 'dart:math';

import 'package:flutter/material.dart';

class Const {
  static const double platformImageWith = 20;
  static const double platformImageHeight = 20;
  static const double episodeImageHeight = 200;
  static const double animeImageWith = 75;
  static const double animeImageHeight = 100;
  static const double mangaImageWith = 75;
  static const double mangaImageHeight = 100;
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

  String printTimeSinceDays(DateTime? dateTime) {
    if (dateTime == null) {
      return 'erreur';
    }

    final double seconds = (DateTime.now().millisecondsSinceEpoch -
            dateTime.millisecondsSinceEpoch) /
        1000;
    double interval = seconds / 31536000;

    if (interval > 1) {
      return 'Il y a ${interval.floor()} an${interval >= 2 ? 's' : ''}';
    }

    interval = seconds / 2592000;

    if (interval > 1) {
      return 'Il y a ${interval.floor()} mois';
    }

    interval = seconds / 86400;

    if (interval > 1) {
      return 'Il y a ${interval.floor()} jour${interval >= 2 ? 's' : ''}';
    }

    return "Aujourd'hui";
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
            ...sublist.map<Widget>((Widget e) => Expanded(child: e))
          ],
        ),
      );
    }

    return list;
  }
}

extension StringExt on String? {
  String ifEmptyOrNull(String replacement) =>
      (this == null || this?.isEmpty == true) ? replacement : this!;
}

extension ScrollControllerExt on ScrollController {
  Future<void> scrollToEnd() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));

    try {
      animateTo(
        position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } catch (_) {}
  }
}

extension BuildContextExt on BuildContext {
  bool get isOnMobile {
    return MediaQuery.of(this).size.width < 768;
  }
}
