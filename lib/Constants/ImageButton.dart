import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final ImageProvider image;
  final Color bgColor;
  final BorderRadius borderRadius;
  final double width;
  final EdgeInsets padding;
  final Function onPressed;

  const ImageButton({
    required this.image,
    this.bgColor = Colors.transparent,
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
        child: Image(image: image),
      ),
    );
  }
}
