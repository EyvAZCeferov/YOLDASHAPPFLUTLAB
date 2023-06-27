import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TextButton.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backbutton;
  final String? title;
  final bool changeprof;
  final bool titlebg;
  final String? authtype;

  const BaseAppBar({
    this.backbutton = true,
    this.title = null,
    this.changeprof = false,
    this.titlebg = false,
    this.authtype,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.transparent,
      bottomOpacity: 0,
      brightness: Brightness.light,
      centerTitle: true,
      elevation: 0,
      leadingWidth: backbutton ? 25 : 0,
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
                  onPressed: () => Get.toNamed('/verificationcode')),
            ]
          : null,
      leading: backbutton
          ? IconButtonElement(
              icon: FeatherIcons.chevronLeft,
              color: Colors.black,
              size: buttontextSize,
              onPressed: () => Get.back())
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
