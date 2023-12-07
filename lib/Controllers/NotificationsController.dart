import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yoldashapp/Theme/ThemeService.dart';

class NotificationsController {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  Future<void> init() async {
    try {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('mipmap/launcher_icon');
      flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      const DarwinInitializationSettings darwinInitializationSettings =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestProvisionalPermission: true,
        requestBadgePermission: true,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: darwinInitializationSettings);

      await flutterLocalNotificationsPlugin?.initialize(initializationSettings);
    } catch (e) {
      print(
          "--------------------INit Function Error-------------------------${e.toString()}");
    }
  }

  NotificationsController() {
    init();
  }

  Future<void> showMessageNotify(
      dynamic id, String title, String body, String? onpress) async {
    try {
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        "yoldash-${id}",
        "YOLDASH",
        playSound: true,
        sound: RawResourceAndroidNotificationSound('messageget'),
        importance: Importance.high,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        enableVibration: true,
        color: primarycolor,
        category: AndroidNotificationCategory.message,
        audioAttributesUsage: AudioAttributesUsage.notification,
      );

      DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
        sound: "messageget",
        presentSound: true,
        interruptionLevel: InterruptionLevel.active,
      );

      var not = NotificationDetails(
          android: androidNotificationDetails, iOS: darwinNotificationDetails);

      await flutterLocalNotificationsPlugin?.show(id, title, body, not);
    } catch (e) {
      print(
          "----------------------ShowMessageNotify Error--------------${e.toString()}");
    }
  }
}
