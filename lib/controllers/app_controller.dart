import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jais/controllers/datas/collection_data_controller.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/controllers/notification_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';

class AppController with ChangeNotifier {
  static final CollectionDataController watchlist =
      CollectionDataController('animeWatchlist');
  static final CollectionDataController seen =
      CollectionDataController('episodesSeen');

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
    await FilterController.instance.init();
    await NotificationController.instance.init();
  }

  Future<void> reset() async {
    await watchlist.reset();
    await seen.reset();
    await FilterController.instance.reset();
  }
}
