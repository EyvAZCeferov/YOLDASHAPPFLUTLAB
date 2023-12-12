import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yoldashapp/Theme/ThemeService.dart';

class NotificationsController {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print(id);
    print(title ?? 'No title');
    print(body ?? 'No body');
    print(payload ?? 'No payload');
  }

  Future<void> init() async {
    try {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('mipmap/launcher_icon');
      flutterLocalNotificationsPlugin
          ?.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      final darwinInitializationSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestProvisionalPermission: true,
        requestBadgePermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      );

      await flutterLocalNotificationsPlugin?.initialize(
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: darwinInitializationSettings,
        ),
      );
    } catch (e) {
      print(
          "--------------------INit Function Error-------------------------${e.toString()}");
    }
  }

  Future<void> initController() async {
    await init();
  }

  NotificationsController() {
    initController();
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
