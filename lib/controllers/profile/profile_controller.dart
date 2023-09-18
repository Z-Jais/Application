import 'dart:convert';

import 'package:jais/controllers/abstract_filter.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';

class ProfileController extends AbstractFilter {
  static final ProfileController instance = ProfileController();

  int lastTotalDuration = 0;

  Future<void> setTotalDuration() async {
    if (AppController.seen.data.isEmpty) {
      lastTotalDuration = 0;
      return;
    }

    lastTotalDuration = await URLController()
        .post(
          '${Const.instance.serverUrlWithHttpProtocol}/profile/total-duration',
          toGzip(),
        )
        .ifOk(
          (p0) => (jsonDecode(p0.body)
              as Map<String, dynamic>)['total-duration'] as int,
        );
  }
}
