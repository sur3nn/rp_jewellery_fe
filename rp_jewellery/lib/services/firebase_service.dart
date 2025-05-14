import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseConfig {
  final firebaseMsg = FirebaseMessaging.instance;
  final localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initPushnotification() {
    firebaseMsg.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    if (Platform.isIOS) {
      firebaseMsg.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
    var initSettingIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var settings =
        InitializationSettings(android: android, iOS: initSettingIOS);

    localNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: (details) {});
    FirebaseMessaging.onMessage.listen((msg) async {
      final notification = msg.notification;

      if (notification == null) return;

      if (Platform.isAndroid) {
        await localNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
                android: AndroidNotificationDetails(
                    "pushnotification", "pushnotificationchannel",
                    // usesChronometer: true,
                    importance: Importance.high,
                    icon: '@mipmap/ic_launcher',
                    // color: Color.fromRGBO(67, 09, 95, 1),
                    priority: Priority.high)),
            payload: jsonEncode(msg.toMap()));
      }
    });
  }

  Future<String?> getToken() async {
    return await firebaseMsg.getToken();
  }

  void initNotification() async {
    await firebaseMsg.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    initPushnotification();
    // final s = await firebaseMsg.getToken();
    // log(s.toString());
  }
}
