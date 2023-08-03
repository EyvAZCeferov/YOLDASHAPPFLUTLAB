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
  runApp(ChangeNotifierProvider<ProviderContext>(
      create: (BuildContext context) => ProviderContext(), child: Yoldash()));
}

class Yoldash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yoldash',
      debugShowCheckedModeBanner: false,
      getPages: Routes,
      initialRoute: '/splash',
      translations: TranslationAdditionals(),
      locale: Locale(
          Provider.of<ProviderContext>(context, listen: false).language,
          Provider.of<ProviderContext>(context, listen: false)
              .language
              .toUpperCase()),
      fallbackLocale: Locale(
          Provider.of<ProviderContext>(context, listen: false).language,
          Provider.of<ProviderContext>(context, listen: false)
              .language
              .toUpperCase()),
      enableLog: true,
      defaultTransition: Transition.cupertino,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Duration(milliseconds: 1000),
    );
  }
}
