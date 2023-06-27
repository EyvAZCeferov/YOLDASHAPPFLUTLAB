import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backbutton;
  final String? title;
  final bool changeprof;
  final bool titlebg;

  const BaseAppBar(
      {this.backbutton = true,
      this.title = null,
      this.changeprof = false,
      this.titlebg = false});

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
      // forceMaterialTransparency: true,
      foregroundColor: Colors.white,
      leadingWidth: backbutton ? 25 : 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      toolbarOpacity: 1,
      leading: backbutton
          ? IconButtonElement(
              icon: FeatherIcons.chevronLeft,
              color: Colors.black,
              size: buttontextSize,
              onPressed: () => Get.back())
          : null,
    );
  }
}
