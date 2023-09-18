import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jais/controllers/datas/collection_data_controller.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/controllers/notification_controller.dart';
import 'package:jais/controllers/profile/profile_controller.dart';
import 'package:jais/controllers/review/advanced_in_app_review.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';

class AppController with ChangeNotifier {
  static final CollectionDataController watchlist =
      CollectionDataController('animeWatchlist');
  static final CollectionDataController seen =
      CollectionDataController('episodesSeen');

  static final CollectionDataController logs =
      CollectionDataController('logs', limit: 100);

  bool _inProgress = true;
  bool _hasInternet = false;

  bool get inProgress => _inProgress;

  bool get hasInternet => _hasInternet;

  AppController() {
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    _inProgress = true;
    notifyListeners();

    final Response? response = await URLController()
        .get("${Const.instance.serverUrlWithHttpProtocol}/");
    _hasInternet = response != null && response.statusCode < 500;

    _inProgress = false;
    notifyListeners();
  }

  Future<void> initialize() async {
    await watchlist.init();
    await seen.init();
    await logs.init();
    await FilterController.instance.init();
    await NotificationController.instance.init();
    await ProfileController.instance.setTotalDuration();

    AdvancedInAppReview()
        .setMinDaysBeforeRemind(7)
        .setMinDaysAfterInstall(2)
        .setMinLaunchTimes(2)
        .setMinSecondsBeforeShowDialog(4)
        .monitor();
  }

  Future<void> reset() async {
    await watchlist.reset();
    await seen.reset();
    await logs.reset();
    await FilterController.instance.reset();
    ProfileController.instance.lastTotalDuration = 0;
  }
}
