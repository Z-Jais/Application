import 'package:app_settings/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/datas/string_data_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

enum NotificationType {
  all('all'),
  watchlist('watchlist'),
  disabled('disabled'),
  ;

  final String value;

  const NotificationType(this.value);

  factory NotificationType.fromValue(String value) {
    return NotificationType.values.firstWhere((p0) => p0.value == value);
  }
}

class NotificationController with ChangeNotifier {
  static final NotificationController instance = NotificationController();
  final StringDataController _notificationTypeController = StringDataController(
    'notificationType',
    defaultValue: NotificationType.all.value,
  );
  bool isRunning = false;

  Future<void> init() async {
    await _notificationTypeController.init();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (_notificationTypeController.firstInit) {
      await FirebaseMessaging.instance.requestPermission();
      _subscribeToAll();
    }
  }

  Future<bool> get isNotificationEnabled async {
    return Permission.notification.isGranted;
  }

  Future<bool> get isAll async {
    return _notificationTypeController.data == NotificationType.all.value &&
        await isNotificationEnabled;
  }

  Future<bool> get isWatchlist async {
    return _notificationTypeController.data ==
            NotificationType.watchlist.value &&
        await isNotificationEnabled;
  }

  Future<bool> get isDisabled async {
    return _notificationTypeController.data ==
            NotificationType.disabled.value ||
        !await isNotificationEnabled;
  }

  Future<void> _unsubscribeFromAll() async {
    final start = DateTime.now();
    await FirebaseMessaging.instance.unsubscribeFromTopic('all');

    debug(
      'NotificationController',
      'Unsubscribed from all in ${DateTime.now().difference(start).inMilliseconds}ms',
    );
  }

  Future<void> _unsubscribeFromWatchlist() async {
    final start = DateTime.now();

    await Future.wait([
      for (final anime in AppController.watchlist.data)
        FirebaseMessaging.instance.unsubscribeFromTopic(anime),
    ]);

    debug(
      'NotificationController',
      'Unsubscribed from watchlist in ${DateTime.now().difference(start).inMilliseconds}ms',
    );
  }

  Future<void> _subscribeToAll() async {
    final start = DateTime.now();
    await FirebaseMessaging.instance.subscribeToTopic('all');

    debug(
      'NotificationController',
      'Subscribed to all in ${DateTime.now().difference(start).inMilliseconds}ms',
    );
  }

  Future<void> subscribeToWatchlist() async {
    final start = DateTime.now();

    await Future.wait([
      for (final anime in AppController.watchlist.data.reversed)
        FirebaseMessaging.instance.subscribeToTopic(anime),
    ]);

    debug(
      'NotificationController',
      'Subscribed to watchlist in ${DateTime.now().difference(start).inMilliseconds}ms',
    );
  }

  Future<void> _openNotificationSettings() async {
    if (!await isNotificationEnabled) {
      debug('NotificationController', 'Notification is not enabled');
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
      // Wait for the user to enable notifications
      while (!await isNotificationEnabled) {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  Future<void> setNotificationType(NotificationType type) async {
    if (isRunning) {
      debug(
        'NotificationController',
        'Notification type already doing something',
      );

      return;
    }

    final oldType =
        NotificationType.fromValue(_notificationTypeController.data);

    if (type == oldType) {
      debug(
        'NotificationController',
        'Notification type is already set to ${type.value}',
      );

      return;
    }

    info(
      'NotificationController',
      'Notification type from $oldType to ${type.value}',
    );
    _notificationTypeController.data = type.value;
    await _notificationTypeController.save();
    isRunning = true;

    if (type == NotificationType.all) {
      await _openNotificationSettings();

      Future.wait([
        if (oldType == NotificationType.watchlist) _unsubscribeFromWatchlist(),
        _subscribeToAll(),
      ]).then((value) {
        isRunning = false;
        notifyListeners();

        debug(
          'NotificationController',
          'Init completed (all)',
        );
      });
    } else if (type == NotificationType.watchlist) {
      await _openNotificationSettings();

      Future.wait([
        if (oldType == NotificationType.all) _unsubscribeFromAll(),
        subscribeToWatchlist(),
      ]).then((value) {
        isRunning = false;
        notifyListeners();

        debug(
          'NotificationController',
          'Init completed (watchlist)',
        );
      });
    } else {
      Future.wait([
        if (oldType == NotificationType.all) _unsubscribeFromAll(),
        if (oldType == NotificationType.watchlist) _unsubscribeFromWatchlist(),
      ]).then((value) {
        isRunning = false;
        notifyListeners();

        debug(
          'NotificationController',
          'Init completed (disabled)',
        );
      });
    }

    notifyListeners();
  }
}
