import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../Constants/Devider.dart';
import '../../../Constants/StaticText.dart';
import '../../../Theme/ThemeService.dart';
import 'list_items.dart';

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
              () => Get.toNamed('/history')),
          list_items(
              Icon(
                FeatherIcons.globe,
                color: iconcolor,
                size: subHeadingSize,
              ),
              "changelanguage".tr,
              () => Get.toNamed('/language')),
            list_items(
                Icon(
                  FeatherIcons.phone,
                  color: iconcolor,
                  size: subHeadingSize,
                ),
                "contact".tr,
                () => Get.toNamed('/contactus'))
          
        ],
      ),
    ),
  );
}
