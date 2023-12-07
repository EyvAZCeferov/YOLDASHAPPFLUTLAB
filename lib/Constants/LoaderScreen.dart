import 'package:flutter/material.dart';

import '../Theme/ThemeService.dart';

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
