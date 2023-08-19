import 'package:flutter/material.dart';

import '../Theme/ThemeService.dart';
import 'StaticText.dart';

class ButtonElement extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final BorderRadius borderRadius;
  final double width;
  final double fontsize;
  final double height;
  final Function onPressed;

  const ButtonElement({
    required this.text,
    this.bgColor = primarycolor,
    this.textColor = whitecolor,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    required this.width,
    this.fontsize = normaltextSize,
    this.height = 30,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          primary: bgColor, // Arkaplan rengi
          onPrimary: textColor, // Yazı rengi
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: StaticText(
            text: text,
            weight: FontWeight.w400,
            size: fontsize,
            color: textColor),
      ),
    );
  }
}
