import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jais/firebase_options.dart';
import 'package:jais/mappers/country_mapper.dart';
import 'package:jais/mappers/device_mapper.dart';

class InitializationModel {
  bool inProgress = true;
  bool hasInternet = false;
}

class InitializationMapper extends ChangeNotifier {
  final InitializationModel _model = InitializationModel();

  InitializationMapper() {
    initialize();
  }

  InitializationModel get model => _model;

  Future<bool> _hasInternet() async {
    return InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 3),
      checkInterval: const Duration(seconds: 3),
    ).hasConnection;
  }

  Future<void> initialize() async {
    _model.inProgress = true;
    notifyListeners();

    final hasInternet = await _hasInternet();

    if (!hasInternet) {
      _model.hasInternet = false;
      _model.inProgress = false;
      notifyListeners();
      return;
    }

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.subscribeToTopic('all');

    await DeviceMapper.instance.animeWatchlistData.init();
    await CountryMapper.instance.update();

    _model.hasInternet = true;
    _model.inProgress = false;
    notifyListeners();
  }
}
