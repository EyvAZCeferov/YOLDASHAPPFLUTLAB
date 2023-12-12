import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Controllers/NotificationsController.dart';
import 'package:yoldashapp/Functions/helpers.dart';
import 'Controllers/MainController.dart';
import 'Functions/CacheManager.dart';
import 'Theme/Routes.dart';
import 'Theme/TranslationAdditionals.dart';

bool initialized =
    false; // Initialize a boolean to track if Firebase has been initialized

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!initialized) {
    await initializeFirebase();
    initialized = true;
  }
  await CacheManager.createSharedPref();
  NotificationsController notificationsController = NotificationsController();
  await notificationsController.init().then((_) {
    runApp(Yoldash());
  });
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     appId: '1:121697903403:android:f4a40a34c9118fb48f9b6e',
  //     apiKey: 'AIzaSyDYvxG0cjlXGJ9LAXIowgE7kxnGucQ_BsU',
  //     messagingSenderId: '121697903403',
  //     projectId: 'yoldash-783a4',
  //   ),
  // );
}

class Yoldash extends StatelessWidget {
  final MainController _maincontroller = Get.put(MainController());
  String selectedlang = 'az';
  var navigatorKey = GlobalKey<NavigatorState>();

  Yoldash() {
    // ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
    _loadLanguage();
    
  }

  _loadLanguage() async {
    String language = await _maincontroller.getstoragedat('language');
    if (language != null &&
        language.isNotEmpty &&
        language != '' &&
        language != ' ') {
      selectedlang = language;
      Get.updateLocale(Locale(selectedlang, ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessageCall(null);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      firebaseMessagingBackgroundHandler(message);
    });
    return GetMaterialApp(
      title: 'Yoldash',
      debugShowCheckedModeBanner: false,
      getPages: Routes,
      initialRoute: '/splash',
      translations: TranslationAdditionals(),
      locale: Locale(selectedlang, ''),
      fallbackLocale: Locale('az', ''),
      enableLog: true,
      defaultTransition: Transition.cupertino,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Duration(milliseconds: 1000),
      navigatorKey: navigatorKey,
    );
  }
}
