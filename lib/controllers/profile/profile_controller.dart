import 'dart:convert';

import 'package:jais/controllers/abstract_filter.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';

class ProfileController extends AbstractFilter {
  static final ProfileController instance = ProfileController();

  Future<int> getTotalDuration() async {
    if (AppController.seen.data.isEmpty) {
      return 0;
    }

    return URLController()
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
