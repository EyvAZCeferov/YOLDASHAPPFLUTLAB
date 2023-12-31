import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/BaseAppBar.dart';
import '../../../Constants/Devider.dart';
import '../../../Constants/LoaderScreen.dart';
import '../../../Constants/StaticText.dart';
import '../../../Controllers/MainController.dart';
import '../../../Functions/CacheManager.dart';
import '../../../Functions/helpers.dart';
import '../../../Theme/ThemeService.dart';

class LanguagePage extends StatelessWidget {
  final MainController _controller = Get.put(MainController());
  void changelang(lang, context) async{
    _controller.refreshpage.value = true;
    CacheManager.setvaluetoprefences('language', lang);
    _controller.currentlang.value=lang;
    Get.updateLocale(Locale(lang,''));
    showToastMSG(primarycolor, "changedlang".tr, context);
    getCCD();
    _controller.refreshpage.value = false;
    Get.back();
  }

  Future<String> getCCD() async {
    var data = await _controller.getstoragedat('language');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getCCD(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoaderScreen();
        } else if (snapshot.hasData) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: bodycolor,
            appBar: BaseAppBar(
              backbutton: true,
              title: "changelanguage".tr,
              changeprof: false,
              titlebg: false,
            ),
            body: Obx(
              () => _controller.refreshpage.value == true
                  ? LoaderScreen()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Devider(),
                        GestureDetector(
                          onTap: () {
                            changelang('az', context);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: 32,
                                    height: 30,
                                    child: CountryFlag(
                                      country: Country.az,
                                      height: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                StaticText(
                                    text: "Azərbaycan",
                                    weight: FontWeight.w600,
                                    size: buttontextSize,
                                    color: snapshot.data == 'az'
                                        ? primarycolor
                                        : darkcolor),
                              ]),
                        ),
                        Devider(size: 20),
                        GestureDetector(
                          onTap: () {
                            changelang('ru', context);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: 32,
                                    height: 30,
                                    child: CountryFlag(
                                      country: Country.ru,
                                      height: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                StaticText(
                                    text: "Rus",
                                    weight: FontWeight.w600,
                                    size: buttontextSize,
                                    color: snapshot.data == 'ru'
                                        ? primarycolor
                                        : darkcolor),
                              ]),
                        ),
                        Devider(size: 20),
                        GestureDetector(
                          onTap: () {
                            changelang('en', context);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: 32,
                                    height: 30,
                                    child: CountryFlag(
                                      country: Country.gb,
                                      height: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                StaticText(
                                    text: "İngilis",
                                    weight: FontWeight.w600,
                                    size: buttontextSize,
                                    color: snapshot.data == 'en'
                                        ? primarycolor
                                        : darkcolor),
                              ]),
                        ),
                        Devider(size: 20),
                        GestureDetector(
                          onTap: () {
                            changelang('tr', context);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: 32,
                                    height: 30,
                                    child: CountryFlag(
                                      country: Country.tr,
                                      height: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                StaticText(
                                    text: "Türk",
                                    weight: FontWeight.w600,
                                    size: buttontextSize,
                                    color: snapshot.data == 'tr'
                                        ? primarycolor
                                        : darkcolor),
                              ]),
                        )
                      ],
                    ),
            ),
          );
        } else if (snapshot.hasError) {
          return LoaderScreen();
        } else {
          return LoaderScreen();
        }
      },
    );
  }
}
