import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jais/controllers/datas/data_collection_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/firebase_options.dart';

class AppController with ChangeNotifier {
  static final DataCollectionController watchlist =
      DataCollectionController('animeWatchlist');
  static final DataCollectionController seen =
      DataCollectionController('episodesSeen');

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
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await watchlist.init();
    await seen.init();
    await AdController.instance.init();
  }
}
