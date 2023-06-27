import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Theme/ThemeService.dart';

Widget list_items(Icon icon, String title, Function onpressed) {
  return Center(
    child: Column(
      children: [
        Container(
          width: Get.width - 50,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: 50,
          decoration: BoxDecoration(
            color: whitecolor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurStyle: BlurStyle.solid,
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              StaticText(
                  color: iconcolor,
                  size: normaltextSize,
                  text: title,
                  weight: FontWeight.w400,
                  align: TextAlign.left),
              Icon(
                FeatherIcons.chevronRight,
                color: secondarycolor,
                size: subHeadingSize,
              )
            ],
          ),
        ),
        Devider(),
      ],
    ),
  );
}
