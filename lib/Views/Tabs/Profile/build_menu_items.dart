import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/Views/Tabs/Profile/list_items.dart';
import 'package:line_icons/line_icons.dart';

Widget build_menu_items(String authtype) {
  return Center(
    child: Container(
      width: Get.width - 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Devider(),
          StaticText(
            color: darkcolor,
            size: normaltextSize,
            text: "other".tr,
            weight: FontWeight.w400,
            align: TextAlign.left,
          ),
          Devider(),
          list_items(
              Icon(
                FeatherIcons.clock,
                color: iconcolor,
                size: subHeadingSize,
              ),
              "history".tr,
              () => print("A")),
          list_items(
              Icon(
                FeatherIcons.globe,
                color: iconcolor,
                size: subHeadingSize,
              ),
              "changelanguage".tr,
              () => print("A")),
          if (authtype == "driver")
            list_items(
                Icon(
                  LineIcons.wallet,
                  color: iconcolor,
                  size: subHeadingSize,
                ),
                "mywallet".tr,
                () => print("A"))
          else
            Container()
        ],
      ),
    ),
  );
}
