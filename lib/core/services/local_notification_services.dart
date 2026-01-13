import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _plugin.initialize(settings);
    await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  static Future<void> show(
      {required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
        'pomodoro_channel', 'Pomodoro Timer',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true);

        const notificationDetail = NotificationDetails(android: androidDetails);

        await _plugin.show(DateTime.now().millisecondsSinceEpoch ~/ 1000, title, body, notificationDetail);


  }
}
