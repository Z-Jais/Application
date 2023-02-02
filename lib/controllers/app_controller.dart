import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jais/controllers/ad_controller.dart';
import 'package:jais/controllers/datas/collection_data_controller.dart';
import 'package:jais/firebase_options.dart';

class AppController with ChangeNotifier {
  static final CollectionDataController watchlist =
      CollectionDataController('animeWatchlist');
  static final CollectionDataController seen =
      CollectionDataController('episodesSeen');

  static bool get isAndroidOrIOS =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

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

    _hasInternet = await InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 3),
      checkInterval: const Duration(seconds: 3),
    ).hasConnection;

    _inProgress = false;
    notifyListeners();
  }

  Future<void> initialize() async {
    if (isAndroidOrIOS) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await FirebaseMessaging.instance.requestPermission();
      await FirebaseMessaging.instance.subscribeToTopic('all');

      await AdController.instance.init();
    }

    await watchlist.init();
    await seen.init();
  }
}
