import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsMapper {
  final String _lastCheckKey = 'lastCheck';

  String getCurrentTime() {
    final String currentTime = DateTime.now().toUtc().toIso8601String();

    if (!currentTime.contains('.')) {
      return currentTime;
    }

    return '${currentTime.split('.')[0]}Z';
  }

  Future<String> getLastCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastCheckKey) ?? getCurrentTime();
  }

  Future<void> setLastCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastCheckKey, getCurrentTime());
  }

  Future<void> setAlarm() async {
    final bool response = await AndroidAlarmManager.initialize();

    if (!response) {
      return;
    }

    await AndroidAlarmManager.periodic(
      const Duration(minutes: 5),
      0,
      _onBackgroundAlarm,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  @pragma('vm:entry-point')
  Future<void> show({
    required int id,
    required String channelId,
    required String channelName,
    String? title,
    String? body,
    bool requestPermission = false,
  }) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_notifications');

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
    );

    if (requestPermission) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
        ),
      ),
    );
  }

  @pragma('vm:entry-point')
  Future<void> _onBackgroundAlarm() async {
    // TODO: Implement background alarm
  }
}
