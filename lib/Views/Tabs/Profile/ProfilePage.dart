import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/AddableWidget.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/AuthController.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/Views/Tabs/Profile/build_menu_items.dart';

class ProfilePage extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
          backgroundColor: bodycolor,
          appBar: BaseAppBar(
              backbutton: false,
              title: "myaccount".tr,
              changeprof: true,
              titlebg: false,
              authtype: _controller.authType.value,
              changeprofpage: () => _controller.changeprofpage()),
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
                    height: width / 3,
                    width: width - 40,
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
                                    onPressed: () =>
                                        Get.toNamed("/profileinformation"))
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
                _controller.authType.value == "driver"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Devider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Get.toNamed('/balance/add'),
                                child: Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed('/balance/add'),
                                child: Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              ),
                            ],
                          ),
                          Devider(size: 20),
                          Center(
                            child: Container(
                              width: width - 40,
                              height: width / 1.8,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
                              child: AddableWidget(type: 'cards'),
                            ),
                          ),
                          Devider(size: 20),
                          Center(
                            child: Container(
                              width: width - 40,
                              height: width / 1.8,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
                              child: AddableWidget(type: 'automobils'),
                            ),
                          ),
                          Devider(),
                        ],
                      )
                    : Container(),
                Devider(),
                build_menu_items(_controller.authType.value),
                Devider(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ButtonElement(
                  text: "logout".tr,
                  height: 50,
                  width: width - 100,
                  borderRadius: BorderRadius.circular(45),
                  onPressed: () => print("Logout")),
            ),
          )),
    );
  }
}
