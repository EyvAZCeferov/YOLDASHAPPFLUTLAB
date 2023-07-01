import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TextButton.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class AddableWidget extends StatelessWidget {
  final String type;

  const AddableWidget({
    this.type = "cards",
  });

  @override
  Widget build(BuildContext content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StaticText(
                text: type == "cards"
                    ? "bank_account_and_cards".tr
                    : "automobils".tr,
                color: darkcolor,
                size: normaltextSize,
                weight: FontWeight.w500,
                align: TextAlign.left,
              ),
              IconButtonElement(
                icon: FeatherIcons.edit2,
                onPressed: () => Get.toNamed('/' + type),
                color: secondarycolor,
                size: normaltextSize,
              ),
            ]),
        _buildbankorauto(type),
        GestureDetector(
          onTap: () {
            Get.toNamed('/' + type + '/add');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  height: 40,
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffF4F5F6),
                    border: Border.all(
                        style: BorderStyle.solid,
                        width: 1,
                        color: secondarycolor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(FontAwesomeIcons.plus,
                      color: secondarycolor, size: subHeadingSize)),
              StaticText(
                color: iconcolor,
                size: normaltextSize,
                text: type == "cards"
                    ? "add_bank_account".tr
                    : "add_automobil".tr,
                weight: FontWeight.w500,
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildbankorauto(type) {
  return type == "cards"
      ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 80,
                height: 60,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF4F5F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(FontAwesomeIcons.buildingColumns,
                    color: secondarycolor, size: headingSize)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaticText(
                  text: "ABB",
                  color: darkcolor,
                  size: buttontextSize,
                  weight: FontWeight.w500,
                  align: TextAlign.left,
                ),
                StaticText(
                  text: "mainaccount".tr,
                  color: Colors.grey,
                  size: smalltextSize,
                  weight: FontWeight.w400,
                  align: TextAlign.left,
                ),
                TextButtonElement(
                    width: 40,
                    text: "remove".tr,
                    fontsize: smalltextSize,
                    bgColor: whitecolor,
                    textColor: errorcolor,
                    onPressed: () => print("remove"))
              ],
            )
          ],
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 80,
                height: 60,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF4F5F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(FontAwesomeIcons.carSide,
                    color: secondarycolor, size: headingSize)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaticText(
                  text: "Wolkswagen-CC",
                  color: darkcolor,
                  size: buttontextSize,
                  weight: FontWeight.w500,
                  align: TextAlign.left,
                ),
                StaticText(
                  text: "90-DT-190",
                  color: Colors.grey,
                  size: smalltextSize,
                  weight: FontWeight.w400,
                  align: TextAlign.left,
                ),
                TextButtonElement(
                    width: 40,
                    text: "remove".tr,
                    fontsize: smalltextSize,
                    bgColor: whitecolor,
                    textColor: errorcolor,
                    onPressed: () => print("remove"))
              ],
            )
          ],
        );
}
