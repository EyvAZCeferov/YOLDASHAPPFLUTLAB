import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Constants/LineLoaderWidget.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/AuthController.dart';
import 'package:yoldash/Controllers/GoingController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class Logistics extends StatefulWidget {
  @override
  State<Logistics> createState() => _LogisticsState();
}

class _LogisticsState extends State<Logistics> {
  late GoingController _controller = Get.put(GoingController());
  late AuthController _authcontroller = Get.put(AuthController());

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
            : SingleChildScrollView(
                controller: ScrollController(),
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 47,
                          height: 120,
                          child: ImageClass(
                              boxfit: BoxFit.contain,
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
                                width: width - 110,
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width - 110,
                                    child: InputElement(
                                      accentColor: iconcolor,
                                      controller: _controller.tocontroller,
                                      placeholder: "to".tr,
                                      textColor: iconcolor,
                                      cornerradius: BorderRadius.circular(40),
                                      inputType: TextInputType.text,
                                    ),
                                  ),
                                  IconButtonElement(
                                    icon: _controller.addedsectionshow.value ==
                                            false
                                        ? FeatherIcons.plus
                                        : FeatherIcons.minus,
                                    onPressed: () => _controller.addsections(),
                                    bgColor: Colors.transparent,
                                    color: secondarycolor,
                                    size: buttontextSize,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: SizedBox(
                                width: width - 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => print("Hi"),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FeatherIcons.home,
                                            color: primarycolor,
                                            size: subHeadingSize,
                                          ),
                                          SizedBox(width: 7),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                    SizedBox(width: 7),
                                    GestureDetector(
                                      onTap: () => print("Hi"),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FeatherIcons.briefcase,
                                            color: primarycolor,
                                            size: subHeadingSize,
                                          ),
                                          SizedBox(width: 7),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StaticText(
                                                  color: darkcolor,
                                                  size: normaltextSize,
                                                  weight: FontWeight.w500,
                                                  align: TextAlign.center,
                                                  text: "mywork".tr),
                                              StaticText(
                                                  color: iconcolor,
                                                  size: smalltextSize,
                                                  weight: FontWeight.w400,
                                                  align: TextAlign.center,
                                                  text: "Yasamal ray."),
                                            ],
                                          ),
                                        ],
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
                    Devider(),
                    _controller.addedsectionshow.value == true
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Devider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Icon(
                                    FeatherIcons.briefcase,
                                    color: secondarycolor,
                                    size: subHeadingSize,
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: width - 110,
                                    child: InputElement(
                                      accentColor: iconcolor,
                                      controller: _controller.weightcontroller,
                                      placeholder: "weight".tr,
                                      textColor: iconcolor,
                                      cornerradius: BorderRadius.circular(40),
                                      inputType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              Devider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Icon(
                                    FeatherIcons.clock,
                                    color: secondarycolor,
                                    size: subHeadingSize,
                                  ),
                                  SizedBox(width: 20),
                                  Center(
                                    child: SizedBox(
                                      width: width - 70,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                _controller.changeindex(1),
                                            child: Container(
                                              width: 90,
                                              height: 35,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: primarycolor,
                                                      style: BorderStyle.solid,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  color: _controller
                                                                  .selectedindex
                                                                  .value !=
                                                              null &&
                                                          _controller
                                                                  .selectedindex
                                                                  .value ==
                                                              1
                                                      ? primarycolor
                                                      : whitecolor),
                                              child: StaticText(
                                                  color: _controller
                                                                  .selectedindex
                                                                  .value !=
                                                              null &&
                                                          _controller
                                                                  .selectedindex
                                                                  .value ==
                                                              1
                                                      ? whitecolor
                                                      : darkcolor,
                                                  size: normaltextSize,
                                                  weight: FontWeight.w500,
                                                  align: TextAlign.center,
                                                  text: "today".tr),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () =>
                                                _controller.changeindex(2),
                                            child: Container(
                                              width: 90,
                                              height: 35,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: primarycolor,
                                                      style: BorderStyle.solid,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  color: _controller
                                                                  .selectedindex
                                                                  .value !=
                                                              null &&
                                                          _controller
                                                                  .selectedindex
                                                                  .value ==
                                                              2
                                                      ? primarycolor
                                                      : whitecolor),
                                              child: StaticText(
                                                  color: _controller
                                                                  .selectedindex
                                                                  .value !=
                                                              null &&
                                                          _controller
                                                                  .selectedindex
                                                                  .value ==
                                                              2
                                                      ? whitecolor
                                                      : darkcolor,
                                                  size: normaltextSize,
                                                  weight: FontWeight.w500,
                                                  align: TextAlign.center,
                                                  text: "tomorrow".tr),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Devider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => _controller.selectplace(1),
                                    child: Container(
                                      width: 110,
                                      height: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: primarycolor,
                                              style: BorderStyle.solid,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color:
                                              _controller.selectedplace.value !=
                                                          null &&
                                                      _controller.selectedplace
                                                              .value ==
                                                          1
                                                  ? primarycolor
                                                  : whitecolor),
                                      child: StaticText(
                                          color:
                                              _controller.selectedplace.value !=
                                                          null &&
                                                      _controller.selectedplace
                                                              .value ==
                                                          1
                                                  ? whitecolor
                                                  : darkcolor,
                                          size: normaltextSize,
                                          weight: FontWeight.w500,
                                          align: TextAlign.center,
                                          text: "choiseplace".tr),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _controller.selectplace(2),
                                    child: Container(
                                      width: 150,
                                      height: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: primarycolor,
                                              style: BorderStyle.solid,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color:
                                              _controller.selectedplace.value !=
                                                          null &&
                                                      _controller.selectedplace
                                                              .value ==
                                                          2
                                                  ? primarycolor
                                                  : whitecolor),
                                      child: StaticText(
                                          color:
                                              _controller.selectedplace.value !=
                                                          null &&
                                                      _controller.selectedplace
                                                              .value ==
                                                          2
                                                  ? whitecolor
                                                  : darkcolor,
                                          size: normaltextSize,
                                          weight: FontWeight.w500,
                                          align: TextAlign.center,
                                          text: "fullreservation".tr),
                                    ),
                                  ),
                                ],
                              ),
                              Devider(),
                            ],
                          )
                        : SizedBox(),
                    Devider(),
                    _controller.data.length > 0
                        ? Center(
                            child: SizedBox(
                            width: width - 40,
                            height: width,
                            child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Get.toNamed('/roadinfo/$index',
                                      arguments: index),
                                  child: Center(
                                      child: Container(
                                    width: width - 40,
                                    height: 75,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: iconcolor,
                                                style: BorderStyle.solid,
                                                width: 1))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.car,
                                              color: secondarycolor,
                                              size: subHeadingSize,
                                            ),
                                            SizedBox(width: 11),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                StaticText(
                                                    text: "Bakı - Yevlax",
                                                    weight: FontWeight.w500,
                                                    size: normaltextSize,
                                                    color: darkcolor,
                                                    align: TextAlign.left),
                                                StaticText(
                                                    text: "minimum 3AZN",
                                                    weight: FontWeight.w500,
                                                    size: smalltextSize,
                                                    color: iconcolor,
                                                    align: TextAlign.left),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: ButtonElement(
                                            text: "more".tr,
                                            width: 110,
                                            height: 40,
                                            bgColor: primarycolor,
                                            textColor: whitecolor,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            fontsize: normaltextSize,
                                            onPressed: () => _controller
                                                .lookmore(index, context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                );
                              },
                            ),
                          ))
                        : _controller.loading.value == true
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width - 40,
                                      height: width / 2,
                                      child: ImageClass(
                                        type: false,
                                        boxfit: BoxFit.contain,
                                        url: "/assets/images/searchingcar.png",
                                      ),
                                    ),
                                    Devider(),
                                    Center(
                                      child: SizedBox(
                                        width: width - 40,
                                        child: LineLoaderWidget(
                                          function: () =>
                                              _controller.fetchdata(),
                                          color: primarycolor,
                                          duration:
                                              Duration(milliseconds: 2500),
                                          width: width - 40,
                                          height: 10,
                                        ),
                                      ),
                                    ),
                                    Devider(),
                                    StaticText(
                                      align: TextAlign.center,
                                      color: darkcolor,
                                      weight: FontWeight.w400,
                                      size: normaltextSize,
                                      text: "searchingcar".tr,
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: SizedBox(
                                  width: width - 40,
                                  height: width / 1.6,
                                  child: ImageClass(
                                      type: false,
                                      boxfit: BoxFit.contain,
                                      url: "assets/images/findcar.png"),
                                ),
                              ),
                    Devider(),
                    Center(
                      child: _controller.data.length > 0
                          ? SizedBox()
                          : ButtonElement(
                              bgColor: primarycolor,
                              borderRadius: BorderRadius.circular(30),
                              height: 40,
                              fontsize: normaltextSize,
                              textColor: whitecolor,
                              text: _controller.loading.value == true
                                  ? "stopsearching".tr
                                  : _authcontroller.authType == 'rider'
                                      ? "search".tr
                                      : "reservation".tr,
                              width: width - 70,
                              onPressed: () => _controller.togglesearch()),
                    ),
                    Devider(),
                  ],
                ),
              ),
      ),
    );
  }
}
