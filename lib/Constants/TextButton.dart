import 'package:flutter/material.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class TextButtonElement extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color bgColor;
  final Color textColor;
  final BorderRadius borderRadius;
  final double width;
  final EdgeInsets padding;
  final Function onPressed;

  const TextButtonElement({
    required this.text,
    this.fontsize = smalltextSize,
    this.bgColor = Colors.transparent,
    this.textColor = Colors.black,
    this.borderRadius = BorderRadius.zero,
    required this.width,
    this.padding = const EdgeInsets.all(10),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextButton(
        onPressed: onPressed as void Function()?,
        style: TextButton.styleFrom(
          padding: padding,
          backgroundColor: bgColor,
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
