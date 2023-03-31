import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jais/controllers/datas/collection_data_controller.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/firebase_options.dart';
import 'package:jais/models/notification.dart';
import 'package:jais/utils.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AppController with ChangeNotifier {
  static final CollectionDataController watchlist =
      CollectionDataController('animeWatchlist');
  static final CollectionDataController seen =
      CollectionDataController('episodesSeen');

  static bool get isAndroidOrIOS =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

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
        ).hasConnection &&
        (await URLController().get("https://${Const.serverUrl}/"))!.statusCode <
            500;

    _inProgress = false;
    notifyListeners();
  }

  Future<void> initialize() async {
    await watchlist.init();
    await seen.init();
    await FilterController.instance.init();

    if (isAndroidOrIOS) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await FirebaseMessaging.instance.requestPermission();
      await FirebaseMessaging.instance.subscribeToTopic('all');
    }

    if (isWindows) {
      try {
        final WebSocketChannel webSocketChannel =
            WebSocketChannel.connect(Uri.parse('wss://${Const.serverUrl}/'));

        webSocketChannel.stream.listen((message) async {
          final Notification notification = Notification.fromJson(
            jsonDecode(message as String) as Map<String, dynamic>,
          );

          await LocalNotification(
            title: notification.title ?? 'Jaïs',
            body: notification.body,
          ).show();
        });
      } catch (e) {
        log('Could not connect to WebSocket server: $e');
      }
    }
  }
}
