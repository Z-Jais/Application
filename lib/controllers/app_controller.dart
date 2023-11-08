import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jais/controllers/ad_controller.dart';
import 'package:jais/controllers/datas/collection_data_controller.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/controllers/notification_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';

class AppController with ChangeNotifier {
  static final AppController instance = AppController();
  static final CollectionDataController watchlist =
      CollectionDataController('animeWatchlist');
  static final CollectionDataController seen =
      CollectionDataController('episodesSeen');

  bool _inProgress = true;
  bool _hasInternet = false;

  bool _initializing = false;

  bool get inProgress => _inProgress;

  bool get hasInternet => _hasInternet;

  Future<void> checkInternetConnection() async {
    _inProgress = true;
    notifyListeners();

    final Response? response =
        await URLController().get(Const.instance.serverUrlWithHttpProtocol);
    _hasInternet = response != null && response.statusCode < 500;

    _inProgress = false;
    notifyListeners();
  }

  Future<void> initialize(BuildContext context) async {
    info('AppController', 'initialize');

    if (_initializing) return;
    _initializing = true;

    await watchlist.init();
    await seen.init();
    await FilterController.instance.init();

    NotificationController.instance.init();
    AdController.instance.loadAd();

    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  static Future<void> reset() async {
    await watchlist.reset();
    await seen.reset();
    await FilterController.instance.reset();
  }
}
