import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:workmanager/workmanager.dart';

Future<void> _show({
  required int id,
  required String channelId,
  required String channelName,
  String? image,
  String? title,
  String? body,
  bool requestPermission = false,
}) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(image ?? 'ic_stat_notifications');

  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(android: initializationSettingsAndroid),
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
void onBackgroundAlarm() {
  Workmanager().executeTask((String task, __) async {
    WidgetsFlutterBinding.ensureInitialized();
    final NotificationsMapper notificationsMapper = NotificationsMapper();
    final List<String> checkedUuids = await notificationsMapper.getCheckedUuids();
    final String lastCheck = await notificationsMapper.getLastCheck();

    final WebSocketChannel channel = WebSocketChannel.connect(
      Uri.parse('wss://beta-api.ziedelth.fr/notifications'),
    );
    channel.sink.add('fr;$lastCheck');
    final String response = await channel.stream.first;
    await channel.sink.close();

    final List<Map<String, dynamic>> data =
    List<Map<String, dynamic>>.from(jsonDecode(response));

    final List<String> uuids = data
        .map((Map<String, dynamic> element) => element['uuid'] as String)
        .toList();
    final String animes = data
        .where(
          (Map<String, dynamic> element) =>
      !checkedUuids.contains(element['uuid']),
    )
        .map((Map<String, dynamic> element) => element['name'])
        .join(', ');

    if (animes.isNotEmpty && task != 'notifications_once') {
      try {
        await _show(
            id: 0,
            channelId: 'notifications',
            channelName: 'Notifications',
            body: animes,
        );
      } catch (_) {}
    }

    await notificationsMapper.setLastCheck();
    await notificationsMapper.setCheckedUuids(uuids);
    return Future<bool>.value(true);
  });
}

class NotificationsMapper {
  final String _lastCheckKey = 'lastCheck';

  String getCurrentTime() {
    final String currentTime = DateTime.now().toUtc().toIso8601String();

    if (!currentTime.contains('.')) {
      return currentTime;
    }

    return '${currentTime.split('.')[0]}Z';
  }

  Future<List<String>> getCheckedUuids() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return List<String>.from(prefs.getStringList('checkedUuids') ?? <String>[]);
  }

  Future<void> setCheckedUuids(List<String> uuids) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('checkedUuids', uuids);
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
    final Workmanager workmanager = Workmanager();
    const String taskName = 'notifications';

    await workmanager.initialize(
      onBackgroundAlarm,
      isInDebugMode: true,
    );
    await workmanager.cancelByUniqueName(taskName);
    await workmanager.registerOneOffTask('${taskName}_once', '${taskName}_once');
    await workmanager.registerPeriodicTask(
      taskName,
      taskName,
      frequency: const Duration(minutes: 15),
      initialDelay: const Duration(seconds: 30),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );
  }
}
