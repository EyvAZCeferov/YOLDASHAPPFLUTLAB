import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controllers/MainController.dart';
import 'Functions/CacheManager.dart';
import 'Theme/Routes.dart';
import 'Theme/TranslationAdditionals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.createSharedPref();

  runApp(Yoldash());
}

class Yoldash extends StatelessWidget {
  final MainController _maincontroller = Get.put(MainController());
  String selectedlang = 'az';

  Yoldash() {
    _loadLanguage();
  }

  _loadLanguage() async {
    String language = await _maincontroller.getstoragedat('language');
    if (language != null &&
        language.isNotEmpty &&
        language != '' &&
        language != ' ') {
      selectedlang = language;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yoldash',
      debugShowCheckedModeBanner: false,
      getPages: Routes,
      initialRoute: '/splash',
      translations: TranslationAdditionals(),
      locale: Locale(selectedlang, selectedlang.toUpperCase()),
      fallbackLocale: Locale(selectedlang, selectedlang.toUpperCase()),
      enableLog: true,
      defaultTransition: Transition.cupertino,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Duration(milliseconds: 1000),
    );
  }
}
