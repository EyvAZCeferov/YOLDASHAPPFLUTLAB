import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class IconButtonElement extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final Function onPressed;

  const IconButtonElement({
    required this.icon,
    this.color = Colors.black,
    this.size = 24.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: size,
      padding: EdgeInsets.all(8),
      tooltip: "back".tr,
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        backgroundColor: MaterialStateProperty.all<Color>(whitecolor),
        elevation: MaterialStateProperty.all<double>(0),
        foregroundColor: MaterialStateProperty.all<Color>(darkcolor),
        overlayColor: MaterialStateProperty.all<Color>(whitecolor),
        padding:
            MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(8)),
        side: MaterialStateProperty.all<BorderSide>(BorderSide(
          color: bodycolor,
          style: BorderStyle.solid,
          width: 1,
        )),
        animationDuration: const Duration(milliseconds: 1000),
        iconColor: MaterialStateProperty.all<Color>(darkcolor),
      ),
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
      onPressed: onPressed as void Function()?,
    );
  }
}
