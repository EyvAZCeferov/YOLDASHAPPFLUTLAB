import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../Theme/ThemeService.dart';
import 'StaticText.dart';

class DocumentRow extends StatelessWidget {
  final String type;
  final String title;
  final String? subtitle;
  final bool completed;
  final Function? onPressed;

  const DocumentRow({
    this.type = "file",
    required this.title,
    this.subtitle,
    this.completed = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext content) {
    return Center(
      child: Container(
        width: Get.width - 40,
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: whitecolor,
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurStyle: BlurStyle.solid,
                color: Colors.black38,
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaticText(
                    text: title,
                    weight: FontWeight.w500,
                    align: TextAlign.left,
                    size: normaltextSize,
                    color: darkcolor),
                subtitle != null
                    ? StaticText(
                        text: subtitle!,
                        weight: FontWeight.w400,
                        align: TextAlign.left,
                        size: smalltextSize,
                        color: iconcolor)
                    : SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ],
            ),
            Container(
              width: 50,
              height: 100,
              alignment: Alignment.center,
              child: completed == true
                  ? Icon(
                      FeatherIcons.check,
                      color: secondarycolor,
                      size: buttontextSize,
                    )
                  : ElevatedButton(
                      onPressed: onPressed != null ? () => onPressed!() : null,
                      style: ElevatedButton.styleFrom(
                        primary: secondarycolor,
                        onPrimary: whitecolor,
                        alignment: Alignment.center,
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: secondarycolor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ).merge(ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 55)),
                      )),
                      child: Icon(
                        FeatherIcons.upload,
                        color: whitecolor,
                        size: normaltextSize,
                      )),
            )
          ],
        ),
      ),
    );
  }
}
