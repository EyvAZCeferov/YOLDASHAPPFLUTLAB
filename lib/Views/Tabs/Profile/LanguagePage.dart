import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/MainController.dart';
import 'package:yoldash/Functions/CacheManager.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class LanguagePage extends StatelessWidget {
  final MainController _controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        title: "changelanguage".tr,
        changeprof: false,
        titlebg: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Devider(),
          GestureDetector(
            onTap: () {
              Get.updateLocale(Locale('az', 'az'));
              CacheManager.setvaluetoprefences('language', 'az');
              showToastMSG(primarycolor, "changedlang".tr, context);
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
                      color: _controller.getstoragedat('language').toString() ==
                              'az'
                          ? primarycolor
                          : darkcolor),
                ]),
          ),
          Devider(size: 20),
          GestureDetector(
            onTap: () {
              Get.updateLocale(Locale('ru', 'RU'));
              CacheManager.setvaluetoprefences('language', 'ru');
              showToastMSG(primarycolor, "changedlang".tr, context);
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
                      color: _controller.getstoragedat('language').toString() ==
                              'ru'
                          ? primarycolor
                          : darkcolor),
                ]),
          ),
          Devider(size: 20),
          GestureDetector(
            onTap: () {
              Get.updateLocale(Locale('en', 'EN'));
              CacheManager.setvaluetoprefences('language', 'en');
              showToastMSG(primarycolor, "changedlang".tr, context);
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
                      color: _controller.getstoragedat('language').toString() ==
                              'en'
                          ? primarycolor
                          : darkcolor),
                ]),
          ),
          Devider(size: 20),
          GestureDetector(
            onTap: () {
              Get.updateLocale(Locale('tr', 'TR'));
              CacheManager.setvaluetoprefences('language', 'tr');
              showToastMSG(primarycolor, "changedlang".tr, context);
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
                      color: _controller.getstoragedat('language').toString() ==
                              'tr'
                          ? primarycolor
                          : darkcolor),
                ]),
          )
        ],
      ),
    );
  }
}
