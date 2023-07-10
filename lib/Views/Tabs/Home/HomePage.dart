import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/GoingController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoingController _controller = Get.put(GoingController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      body: Obx(
        () => _controller.openmodal.value == false
            ? Stack(fit: StackFit.expand, children: [
                Positioned.fill(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ImageClass(
                    url: "/assets/images/mapbg.png",
                    type: false,
                    boxfit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 20,
                    width: width - 40,
                    child: Container(
                      width: width - 40,
                      height: width / 2.3,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.symmetric(vertical: 8),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Devider(size: 3),
                          StaticText(
                            color: darkcolor,
                            size: buttontextSize,
                            align: TextAlign.left,
                            weight: FontWeight.w600,
                            text: "wheredoyougo".tr,
                          ),
                          Devider(size: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 44,
                                height: 90,
                                child: ImageClass(
                                    url: "assets/images/destinationicon.png",
                                    type: false),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () => _controller.openmodal.value = true,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width: width - 125,
                                        child: StaticText(
                                          color: iconcolor,
                                          size: normaltextSize,
                                          text: "from".tr,
                                          weight: FontWeight.w400,
                                          align: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: width - 125,
                                        child: StaticText(
                                          color: iconcolor,
                                          size: normaltextSize,
                                          text: "to".tr,
                                          weight: FontWeight.w400,
                                          align: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Devider(size: 3),
                        ],
                      ),
                    )),
              ])
            : Container(
                width: width,
                height: height,
                color: whitecolor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: whitecolor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: iconcolor,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: IconButtonElement(
                              icon: FeatherIcons.chevronLeft,
                              color: Colors.black,
                              size: buttontextSize,
                              onPressed: () =>
                                  _controller.openmodal.value = false),
                        )
                      ],
                    ),
                    Devider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 47,
                          height: 110,
                          child: ImageClass(
                              url: "assets/images/destinationicon.png",
                              type: false),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Center(
                              child: SizedBox(
                                width: width - 100,
                                child: InputElement(
                                  accentColor: iconcolor,
                                  controller: _controller.fromcontroller,
                                  placeholder: "from".tr,
                                  textColor: iconcolor,
                                  cornerradius: BorderRadius.circular(40),
                                  inputType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: SizedBox(
                                width: width - 100,
                                child: InputElement(
                                  accentColor: iconcolor,
                                  controller: _controller.tocontroller,
                                  placeholder: "to".tr,
                                  textColor: iconcolor,
                                  cornerradius: BorderRadius.circular(40),
                                  inputType: TextInputType.text,
                                ),
                              ),
                            ),
                            Devider(),
                            Center(
                              child: SizedBox(
                                width: width - 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => print("Hi"),
                                      child: Container(
                                        width: 40,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: whitecolor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: iconcolor,
                                              style: BorderStyle.solid,
                                              width: 1),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FeatherIcons.home,
                                              color: primarycolor,
                                              size: normaltextSize,
                                            ),
                                            Column(
                                              children: [
                                                StaticText(
                                                    color: darkcolor,
                                                    size: normaltextSize,
                                                    weight: FontWeight.w500,
                                                    align: TextAlign.center,
                                                    text: "myhome".tr),
                                                StaticText(
                                                    color: iconcolor,
                                                    size: smalltextSize,
                                                    weight: FontWeight.w400,
                                                    align: TextAlign.center,
                                                    text: "Xırdalan şəh."),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
