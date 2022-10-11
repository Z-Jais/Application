import 'dart:math';

import 'package:flutter/material.dart';

class Utils {
  static void clearImagesCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  static String printDuration(Duration duration) {
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

  static String printTimeSince(DateTime? dateTime) {
    if (dateTime == null) {
      return 'erreur';
    }

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

  static String printTimeSinceDays(DateTime? dateTime) {
    if (dateTime == null) {
      return 'erreur';
    }

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

    return "à l'instant";
  }

  static List<Widget> separate(List<Widget> children, {int rowCol = 3}) {
    final List<Widget> list = <Widget>[];

    for (int i = 0; i < children.length; i += rowCol) {
      final int minV = min(i + rowCol, children.length);
      final int length = minV - i;

      List<Widget> sublist = children.sublist(i, minV);
      sublist.addAll(List<Widget>.filled(rowCol - length, Container()));
      sublist = sublist.map<Widget>((Widget e) => Expanded(child: e)).toList();

      list.add(Row(children: sublist));
    }

    return list;
  }
}

extension StringExt on String? {
  String ifEmptyOrNull(String replacement) =>
      (this == null || this?.isEmpty == true) ? replacement : this!;
}
