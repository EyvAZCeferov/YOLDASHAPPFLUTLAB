import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoldash/Functions/CacheManager.dart';
import 'package:yoldash/Functions/ProviderContext.dart';
import 'package:yoldash/Theme/Routes.dart';
import 'package:yoldash/Theme/TranslationAdditionals.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.createSharedPref();
  var language =
      await CacheManager.getvaluefromsharedprefences("language") ?? 'az';
  runApp(Yoldash(language: language));
}

class Yoldash extends StatelessWidget {
  final String language;
  const Yoldash({required this.language});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yoldash',
      debugShowCheckedModeBanner: false,
      getPages: Routes,
      initialRoute: '/splash',
      translations: TranslationAdditionals(),
      locale: Locale(language, language.toUpperCase()),
      fallbackLocale: Locale(language, language.toUpperCase()),
      enableLog: true,
      defaultTransition: Transition.cupertino,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Duration(milliseconds: 1000),
    );
  }
}
