import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController with ChangeNotifier {
  bool _inProgress = true;
  bool _hasInternet = false;

  bool get inProgress => _inProgress;
  bool get hasInternet => _hasInternet;

  NetworkController() {
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
}
