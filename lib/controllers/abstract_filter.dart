import 'dart:convert';
import 'dart:io';

import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/controllers/logger.dart';

mixin class AbstractFilter {
  List<String> _episodes(bool sendSeen, {List<String>? remove}) {
    debug(
      'AbstractFilter',
      '_episodes() - Data: ${AppController.seen.data.length}',
    );
    debug('AbstractFilter', '_episodes() - Remove: $remove');

    final data = AppController.seen.data
        .where((element) => remove?.contains(element) != true)
        .toList();

    debug('AbstractFilter', '_episodes() - Data: ${data.length}');

    if (sendSeen) {
      return data;
    }

    return FilterController.instance.episodeWatchedFilter.data == 0 ? data : [];
  }

  String jsonEncodeGzip(Map<String, dynamic> data) {
    return base64Encode(gzip.encode(utf8.encode(jsonEncode(data))));
  }

  Map<String, dynamic> buildData({
    bool sendSeen = false,
    List<String>? remove,
  }) {
    return {
      'animes': AppController.watchlist.data,
      'episodes': _episodes(sendSeen, remove: remove),
      'episodeTypes': FilterController.instance.watchlistEpisodeTypeFilter.data,
      'langTypes': FilterController.instance.watchlistLangTypeFilter.data,
    };
  }

  String toGzip({bool sendSeen = false, List<String>? remove}) {
    Map<String, dynamic> data = buildData(sendSeen: sendSeen, remove: remove);
    return jsonEncodeGzip(data);
  }
}
