import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../Theme/ThemeService.dart';
import 'IconButtonElement.dart';
import 'StaticText.dart';
import 'TextButton.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backbutton;
  final String? title;
  final bool changeprof;
  final bool titlebg;
  final String? authtype;
  final Color? bgcolorheader;
  final Function? changeprofpage;

  const BaseAppBar(
      {this.backbutton = true,
      this.title = null,
      this.changeprof = false,
      this.titlebg = false,
      this.authtype,
      this.bgcolorheader = Colors.transparent,
      this.changeprofpage});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: bgcolorheader,
      bottomOpacity: 0,
      centerTitle: true,
      elevation: 0,
      leadingWidth: backbutton ? 45 : 0,
      toolbarHeight: 50,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      toolbarOpacity: 1,
      actions: changeprof == true
          ? [
              TextButtonElement(
                  text: this.authtype == 'driver'
                      ? "gotorider".tr
                      : 'gotodriver'.tr,
                  fontsize: 12,
                  textColor: primarycolor,
                  width: Get.width / 3,
                  borderRadius: BorderRadius.circular(Get.width / 3),
                  onPressed: () => changeprofpage!()),
            ]
          : null,
      leading: backbutton
          ? Container(
              width: 40,
              height: buttontextSize,
              decoration: BoxDecoration(
                  color: whitecolor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: iconcolor, width: 1, style: BorderStyle.solid)),
              child: IconButtonElement(
                  icon: FeatherIcons.chevronLeft,
                  color: Colors.black,
                  size: buttontextSize,
                  onPressed: () => Get.back()),
            )
          : null,
      title: titlebg == true
          ? title != null
              ? Container(
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                      color: whitecolor,
                      borderRadius: BorderRadius.circular(5)),
                  child: StaticText(
                      align: TextAlign.center,
                      color: darkcolor,
                      size: buttontextSize,
                      text: title.toString(),
                      weight: FontWeight.w400),
                )
              : null
          : title != null
              ? StaticText(
                  align: TextAlign.center,
                  color: darkcolor,
                  size: buttontextSize,
                  text: title.toString(),
                  weight: FontWeight.w400)
              : null,
    );
  }
}
