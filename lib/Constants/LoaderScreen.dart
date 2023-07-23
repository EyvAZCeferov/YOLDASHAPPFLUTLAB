import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TextButton.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext content) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.transparent,
        ),
        Positioned.fill(
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: bodycolor,
              color: secondarycolor,
              strokeWidth: 2,
              key: GlobalKey(),
            ),
          ),
        ),
      ],
    );
  }
}
