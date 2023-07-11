import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class LanguagePage extends StatelessWidget {
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
              Get.updateLocale(Locale('az', 'AZ'));
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
                      color: darkcolor),
                ]),
          ),
          Devider(size: 20),
          GestureDetector(
            onTap: () {
              Get.updateLocale(Locale('ru', 'RU'));
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
                      color: darkcolor),
                ]),
          ),
          Devider(size: 20),
          GestureDetector(
            onTap: () {
              Get.updateLocale(Locale('en', 'EN'));
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
                      color: darkcolor),
                ]),
          ),
          Devider(size: 20),
          GestureDetector(
            onTap: () {
              Get.updateLocale(Locale('tr', 'TR'));
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
                      color: darkcolor),
                ]),
          )
        ],
      ),
    );
  }
}
