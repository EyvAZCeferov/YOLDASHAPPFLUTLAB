import 'package:flutter/material.dart';
import 'package:yoldash/Theme/Routes.dart';
import 'package:yoldash/Theme/TranslationAdditionals.dart';
import 'package:yoldash/Views/Auth/Login.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Yoldash());
}

class Yoldash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yoldash',
      debugShowCheckedModeBanner: false,
      getPages: Routes,
      initialRoute: '/homepage',
      translations: TranslationAdditionals(),
      locale: Locale('az', 'AZ'),
      fallbackLocale: Locale('az', 'AZ'),
      enableLog: true,
      defaultTransition: Transition.cupertino,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Duration(milliseconds: 1000),
    );
  }
}
