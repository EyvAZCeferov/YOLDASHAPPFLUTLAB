import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TextButton.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/Views/Tabs/Profile/build_menu_items.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String authtype = "driver";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: false,
        title: "myaccount".tr,
        changeprof: true,
        titlebg: false,
        authtype: authtype,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.ltr,
          verticalDirection: VerticalDirection.down,
          children: [
            Center(
              child: Container(
                height: Get.width / 3,
                width: Get.width - 40,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: whitecolor,
                    borderRadius: BorderRadius.circular(10),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: primarycolor,
                      foregroundColor: whitecolor,
                      radius: 45,
                      backgroundImage: NetworkImage(
                          "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StaticText(
                                text: "Eyvaz Cəfərov",
                                weight: FontWeight.bold,
                                size: buttontextSize,
                                color: darkcolor),
                            IconButtonElement(
                                color: secondarycolor,
                                size: buttontextSize,
                                icon: FeatherIcons.edit2,
                                onPressed: () => print("Edit"))
                          ],
                        ),
                        StaticText(
                            text: "eyvaz.ceferov@gmail.com",
                            weight: FontWeight.w500,
                            size: smalltextSize,
                            color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FeatherIcons.phone,
                              color: secondarycolor,
                              size: normaltextSize,
                            ),
                            StaticText(
                                text: " +994516543290",
                                weight: FontWeight.w400,
                                size: smalltextSize,
                                color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Devider(
              size: 10,
            ),
            authtype == "driver"
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Devider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width / 2 - 30,
                            alignment: Alignment.center,
                            height: 80,
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurStyle: BlurStyle.solid,
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StaticText(
                                  color: darkcolor,
                                  size: buttontextSize,
                                  weight: FontWeight.w600,
                                  align: TextAlign.center,
                                  text: "320 AZN",
                                ),
                                StaticText(
                                  color: darkcolor,
                                  size: smalltextSize,
                                  weight: FontWeight.w400,
                                  align: TextAlign.center,
                                  text: "Aylıq balans",
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width / 2 - 30,
                            alignment: Alignment.center,
                            height: 80,
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurStyle: BlurStyle.solid,
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StaticText(
                                  color: darkcolor,
                                  size: buttontextSize,
                                  weight: FontWeight.w600,
                                  align: TextAlign.center,
                                  text: "15 AZN",
                                ),
                                StaticText(
                                  color: darkcolor,
                                  size: smalltextSize,
                                  weight: FontWeight.w400,
                                  align: TextAlign.center,
                                  text: "Bugünki balans",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Devider(),
                      Center(
                        child: Container(
                          width: width - 40,
                          height: width / 2,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: whitecolor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurStyle: BlurStyle.solid,
                                color: Colors.black38,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StaticText(
                                      text: "bank_account_and_cards".tr,
                                      color: darkcolor,
                                      size: normaltextSize,
                                      weight: FontWeight.w500,
                                      align: TextAlign.left,
                                    ),
                                    IconButtonElement(
                                      icon: FeatherIcons.edit2,
                                      onPressed: () => print("Print"),
                                      color: secondarycolor,
                                      size: normaltextSize,
                                    ),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 80,
                                      height: 70,
                                      margin: EdgeInsets.only(right: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF4F5F6),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                          FontAwesomeIcons.buildingColumns,
                                          color: secondarycolor,
                                          size: headingSize)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          width: 100,
                                          text: "remove".tr,
                                          fontsize: smalltextSize,
                                          bgColor: whitecolor,
                                          textColor: errorcolor,
                                          onPressed: () => print("remove"))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Devider(),
                    ],
                  )
                : Container(),
            Devider(),
            build_menu_items(authtype),
            Devider(),
            Positioned(
                bottom: 0,
                width: width,
                height: 60,
                child: Center(
                  child: ButtonElement(
                    text: "logout".tr,
                    width: width - 40,
                    bgColor: primarycolor,
                    borderRadius: BorderRadius.circular(25),
                    fontsize: normaltextSize,
                    height: 50,
                    textColor: whitecolor,
                    onPressed: () => print("Logout"),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
