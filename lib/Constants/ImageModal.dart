import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class ImageModal extends StatefulWidget {
  final String image;
  final Function close;

  const ImageModal({required this.image, required this.close});

  @override
  _ImageModalState createState() => _ImageModalState();
}

class _ImageModalState extends State<ImageModal> {
  bool expanding = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButtonElement(
            icon: FeatherIcons.x,
            onPressed: () => widget.close(),
            bgColor: whitecolor,
            color: secondarycolor,
            size: buttontextSize,
          ),
          Devider(
            size: 10,
          ),
          SizedBox(
            width: Get.width,
            height: Get.width - 100,
            child: ImageClass(
              type: true,
              url: widget.image,
              boxfit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
