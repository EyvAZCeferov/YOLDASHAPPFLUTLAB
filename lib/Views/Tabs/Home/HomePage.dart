import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoldashapp/Constants/SearchedLocationItems.dart';

import '../../../Constants/ButtonElement.dart';
import '../../../Constants/Devider.dart';
import '../../../Constants/IconButtonElement.dart';
import '../../../Constants/ImageClass.dart';
import '../../../Constants/InputElement.dart';
import '../../../Constants/LineLoaderWidget.dart';
import '../../../Constants/LoaderScreen.dart';
import '../../../Constants/StaticText.dart';
import '../../../Controllers/AuthController.dart';
import '../../../Controllers/GoingController.dart';
import '../../../Theme/ThemeService.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoingController _controller = Get.put(GoingController());
  late AuthController _authcontroller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // _controller.fetchlocations(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Obx(
        () => _controller.refreshpage.value == true
            ? LoaderScreen()
            : _controller.openmodal.value == false
                ? Stack(fit: StackFit.expand, children: [
                    Positioned.fill(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: GoogleMap(
                          padding: EdgeInsets.only(bottom: width / 2, top: 45),
                          mapType: MapType.terrain,
                          myLocationButtonEnabled: true,
                          initialCameraPosition: _controller.kGooglePlex,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          mapToolbarEnabled: true,
                          myLocationEnabled: true,
                          polylines: _controller.polyline.isNotEmpty
                              ? Set<Polyline>.from(_controller.polyline)
                              : {},
                          markers: _controller.markers.isNotEmpty
                              ? Set<Marker>.from(_controller.markers)
                              : {},
                          circles: _controller.circles.isNotEmpty
                              ? Set<Circle>.from(_controller.circles)
                              : {},
                          onMapCreated: (GoogleMapController controller) {
                            _controller.googlemapcontroller
                                .complete(controller);
                            _controller.newgooglemapcontroller.value =
                                controller;
                            _controller.getcurrentposition(context);
                          },
                        )),
                    _controller.markers.isNotEmpty &&
                            _controller.markers.length > 1
                        ? Positioned(
                            bottom: 0,
                            left: 20,
                            width: width - 40,
                            child: Container(
                              width: width - 40,
                              height: width / 1.5,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButtonElement(
                                        icon: FeatherIcons.arrowLeft,
                                        onPressed: () {
                                          _controller.refreshpage.value = false;
                                          _controller.markers.value = {};
                                          _controller.searchinglocations.value =
                                              [];
                                          _controller.tocontroller.value.text =
                                              "";
                                          _controller
                                              .weightcontroller.value.text = "";
                                          _controller
                                              .minimumpriceofwaycontroller
                                              .value
                                              .text = "";
                                          _controller.priceofwaycontroller.value
                                              .text = "";
                                          _controller..openmodal.value = true;
                                          _controller.data.value = [];
                                          _controller.loading.value = false;
                                          _controller.goinglocations.value = [];
                                          _controller.directiondetails.value =
                                              null;
                                          _controller.latlngs.value = [];
                                          _controller.polyline.value = {};
                                          _controller.circles.value = {};
                                        },
                                        bgColor: whitecolor,
                                        color: errorcolor,
                                        size: normaltextSize,
                                      ),
                                      StaticText(
                                        text: "informationforride".tr,
                                        weight: FontWeight.w500,
                                        size: normaltextSize,
                                        color: darkcolor,
                                        align: TextAlign.center,
                                        textOverflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: StaticText(
                                          color: darkcolor,
                                          size: buttontextSize,
                                          weight: FontWeight.w600,
                                          align: TextAlign.center,
                                          textOverflow: TextOverflow.ellipsis,
                                          text: _controller.directiondetails
                                              .value!.distanceText!,
                                        ),
                                      ),
                                      Center(
                                        child: StaticText(
                                          color: darkcolor,
                                          size: buttontextSize,
                                          weight: FontWeight.w600,
                                          align: TextAlign.center,
                                          textOverflow: TextOverflow.ellipsis,
                                          text: "inMinutes".trParams({
                                            'timevar': ((_controller
                                                            .directiondetails
                                                            .value!
                                                            .durationValue! /
                                                        60) *
                                                    2)
                                                .toString()
                                                .substring(0, 2)
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Devider(size: 15),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () =>
                                          _controller.changemethod(context),
                                      child: Container(
                                        width: Get.width - 40,
                                        height: 50,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffECECEC),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                blurStyle: BlurStyle.solid,
                                                color: Colors.black38,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                                spreadRadius: 0,
                                              )
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 15),
                                            Container(
                                              width: 70,
                                              height: 40,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 0),
                                              decoration: BoxDecoration(
                                                  color: whitecolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Icon(
                                                FontAwesomeIcons.moneyBill,
                                                color: primarycolor,
                                                size: headingSize,
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                StaticText(
                                                  color: darkcolor,
                                                  size: normaltextSize,
                                                  align: TextAlign.left,
                                                  weight: FontWeight.w500,
                                                  text: "nagd".tr,
                                                ),
                                                StaticText(
                                                  color: iconcolor,
                                                  size: smalltextSize,
                                                  align: TextAlign.left,
                                                  weight: FontWeight.w400,
                                                  text:
                                                      "changepaymentmethod".tr,
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 15),
                                            Icon(FeatherIcons.chevronRight,
                                                color: iconcolor,
                                                size: buttontextSize),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Devider(
                                    size: 15,
                                  ),
                                  Center(
                                    child: ButtonElement(
                                        bgColor: primarycolor,
                                        borderRadius: BorderRadius.circular(30),
                                        height: 40,
                                        fontsize: normaltextSize,
                                        textColor: whitecolor,
                                        text: _controller.loading.value == true
                                            ? "stopsearching".tr
                                            : _authcontroller.authType ==
                                                    'rider'
                                                ? "search".tr
                                                : "reservation".tr,
                                        width: width - 70,
                                        onPressed: () => _controller
                                            .togglesearch("onmap", context)),
                                  ),
                                ],
                              ),
                            ))
                        : Positioned(
                            bottom: 0,
                            left: 20,
                            width: width - 40,
                            child: Container(
                                width: width - 40,
                                height: width / 2.3,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
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
                                child: GestureDetector(
                                  onTap: () =>
                                      _controller.openmodal.value = true,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 44,
                                            height: 90,
                                            child: ImageClass(
                                                url:
                                                    "./assets/images/destinationicon.png",
                                                type: false),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  width: width - 125,
                                                  child: StaticText(
                                                    color: iconcolor,
                                                    size: normaltextSize,
                                                    text: _controller
                                                                    .fromcontroller
                                                                    .value
                                                                    .text !=
                                                                null &&
                                                            _controller
                                                                    .fromcontroller
                                                                    .value
                                                                    .text
                                                                    .toString()
                                                                    .length >
                                                                0
                                                        ? _controller
                                                            .fromcontroller
                                                            .value
                                                            .text
                                                            .toString()
                                                        : "from".tr,
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
                                                    text: _controller
                                                                    .tocontroller
                                                                    .value
                                                                    .text !=
                                                                null &&
                                                            _controller
                                                                    .tocontroller
                                                                    .value
                                                                    .text
                                                                    .toString()
                                                                    .length >
                                                                0
                                                        ? _controller
                                                            .tocontroller
                                                            .value
                                                            .text
                                                            .toString()
                                                        : "to".tr,
                                                    weight: FontWeight.w400,
                                                    align: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Devider(size: 3),
                                    ],
                                  ),
                                )),
                          ),
                  ])
                : SingleChildScrollView(
                    controller: ScrollController(),
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Devider(size: 50),
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
                        Devider(
                          size: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 47,
                              height: 120,
                              child: ImageClass(
                                  boxfit: BoxFit.contain,
                                  url: "./assets/images/destinationicon.png",
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
                                      controller:
                                          _controller.fromcontroller.value,
                                      placeholder:
                                          _controller.fromcontroller.value
                                                          .text !=
                                                      null &&
                                                  _controller.fromcontroller
                                                          .value.text
                                                          .toString()
                                                          .length >
                                                      0
                                              ? _controller
                                                  .fromcontroller.value.text
                                                  .toString()
                                              : "from".tr,
                                      textColor: iconcolor,
                                      cornerradius: BorderRadius.circular(40),
                                      inputType: TextInputType.text,
                                      onchanged: (val) =>
                                          _controller.findplaces(
                                              val,
                                              _controller.fromcontroller.value,
                                              'from',
                                              context),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width - 110,
                                        child: InputElement(
                                          accentColor: iconcolor,
                                          controller:
                                              _controller.tocontroller.value,
                                          placeholder: "to".tr,
                                          textColor: iconcolor,
                                          cornerradius:
                                              BorderRadius.circular(40),
                                          inputType: TextInputType.text,
                                          onchanged: (val) =>
                                              _controller.findplaces(
                                                  val,
                                                  _controller
                                                      .tocontroller.value,
                                                  'to',
                                                  context),
                                        ),
                                      ),
                                      IconButtonElement(
                                        icon: _controller
                                                    .addedsectionshow.value ==
                                                false
                                            ? FeatherIcons.plus
                                            : FeatherIcons.minus,
                                        onPressed: () =>
                                            _controller.addsections(),
                                        bgColor: Colors.transparent,
                                        color: secondarycolor,
                                        size: buttontextSize,
                                      )
                                    ],
                                  ),
                                ),
                                Devider(size: 5, type: false),
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
                                          onTap: () => _controller
                                              .createorselectlocation('home'),
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
                                                      text: _controller
                                                                  .gettypeoflocationaddress(
                                                                      'home') !=
                                                              null
                                                          ? _controller
                                                                  .gettypeoflocationaddress(
                                                                      'home')
                                                                  .toString()
                                                                  .substring(
                                                                      0, 8) +
                                                              '...'
                                                          : 'add'.tr),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 7),
                                        GestureDetector(
                                          onTap: () => _controller
                                              .createorselectlocation('work'),
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
                                                      text: _controller
                                                                  .gettypeoflocationaddress(
                                                                      'work') !=
                                                              null
                                                          ? _controller
                                                                  .gettypeoflocationaddress(
                                                                      'work')
                                                                  .toString()
                                                                  .substring(
                                                                      0, 8) +
                                                              '...'
                                                          : 'add'.tr),
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
                        Devider(
                          size: 5,
                        ),
                        _controller.addedsectionshow.value == true
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Devider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          controller: _controller
                                              .weightcontroller.value,
                                          placeholder: "weight".tr,
                                          textColor: iconcolor,
                                          cornerradius:
                                              BorderRadius.circular(40),
                                          inputType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Devider(),
                                  _authcontroller.authType == "driver"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 10),
                                            Icon(
                                              FontAwesomeIcons.road,
                                              color: secondarycolor,
                                              size: subHeadingSize,
                                            ),
                                            SizedBox(width: 20),
                                            SizedBox(
                                              width: width - 110,
                                              child: InputElement(
                                                accentColor: iconcolor,
                                                controller: _controller
                                                    .minimumpriceofwaycontroller
                                                    .value,
                                                placeholder:
                                                    "minumumwayofprice".tr,
                                                textColor: iconcolor,
                                                cornerradius:
                                                    BorderRadius.circular(40),
                                                inputType: TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  Devider(),
                                  _authcontroller.authType == "driver"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 10),
                                            Icon(
                                              FontAwesomeIcons.car,
                                              color: secondarycolor,
                                              size: subHeadingSize,
                                            ),
                                            SizedBox(width: 20),
                                            SizedBox(
                                              width: width - 110,
                                              child: InputElement(
                                                accentColor: iconcolor,
                                                controller: _controller
                                                    .priceofwaycontroller.value,
                                                placeholder: "wayofprice".tr,
                                                textColor: iconcolor,
                                                cornerradius:
                                                    BorderRadius.circular(40),
                                                inputType: TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  Devider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35),
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
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35),
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
                                  _authcontroller.authType == "driver"
                                      ? SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  _controller.selectplace(1),
                                              child: Container(
                                                width: 110,
                                                height: 35,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: primarycolor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                    color: _controller
                                                                    .selectedplace
                                                                    .value !=
                                                                null &&
                                                            _controller
                                                                    .selectedplace
                                                                    .value ==
                                                                1
                                                        ? primarycolor
                                                        : whitecolor),
                                                child: StaticText(
                                                    color: _controller
                                                                    .selectedplace
                                                                    .value !=
                                                                null &&
                                                            _controller
                                                                    .selectedplace
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
                                              onTap: () =>
                                                  _controller.selectplace(2),
                                              child: Container(
                                                width: 150,
                                                height: 35,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: primarycolor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                    color: _controller
                                                                    .selectedplace
                                                                    .value !=
                                                                null &&
                                                            _controller
                                                                    .selectedplace
                                                                    .value ==
                                                                2
                                                        ? primarycolor
                                                        : whitecolor),
                                                child: StaticText(
                                                    color: _controller
                                                                    .selectedplace
                                                                    .value !=
                                                                null &&
                                                            _controller
                                                                    .selectedplace
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
                                  _authcontroller.authType == "driver"
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  _controller.selectplacing(),
                                              child: Container(
                                                width: width / 1.5,
                                                height: 35,
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 40,
                                                      child: ImageClass(
                                                        type: false,
                                                        boxfit: BoxFit.contain,
                                                        url:
                                                            "/assets/images/yersayi.png",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    StaticText(
                                                        color: darkcolor,
                                                        size: normaltextSize,
                                                        weight: FontWeight.w500,
                                                        align: TextAlign.center,
                                                        text:
                                                            "Yer sayı 3 nəfər boş"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Devider(),
                                            GestureDetector(
                                              onTap: () =>
                                                  _controller.selectplacing(),
                                              child: Container(
                                                width: width / 1.5,
                                                height: 35,
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(FeatherIcons.briefcase,
                                                        color: primarycolor,
                                                        size: subHeadingSize),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    StaticText(
                                                        color: darkcolor,
                                                        size: normaltextSize,
                                                        weight: FontWeight.w500,
                                                        align: TextAlign.center,
                                                        text: "Yük 3/1 boş"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  Devider(),
                                ],
                              )
                            : SizedBox(),
                        _controller.searchinglocations.value.length > 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 16),
                                child: SizedBox(
                                  height: 200,
                                  child: Expanded(
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Devider(
                                              size: 5,
                                            ),
                                        itemBuilder: (context, index) {
                                          var searchedlocationitem = _controller
                                              .searchinglocations.value[index];
                                          return SearchedLocationItems(
                                              searchedlocation:
                                                  searchedlocationitem);
                                        },
                                        itemCount: _controller
                                            .searchinglocations.value.length),
                                  ),
                                ),
                              )
                            : Container(),
                        _controller.loading.value == true
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
                                        url: "./assets/images/searchingcar.png",
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
                            : _controller.data.length > 0
                                ? Center(
                                    child: SizedBox(
                                    width: width - 40,
                                    height: width,
                                    child: ListView.builder(
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => Get.toNamed(
                                              '/roadinfo/$index',
                                              arguments: index),
                                          child: Center(
                                              child: Container(
                                            width: width - 40,
                                            height: 75,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: iconcolor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        StaticText(
                                                            text:
                                                                "Bakı - Yevlax",
                                                            weight:
                                                                FontWeight.w500,
                                                            size:
                                                                normaltextSize,
                                                            color: darkcolor,
                                                            align:
                                                                TextAlign.left),
                                                        StaticText(
                                                            text:
                                                                "minimum 3AZN",
                                                            weight:
                                                                FontWeight.w500,
                                                            size: smalltextSize,
                                                            color: iconcolor,
                                                            align:
                                                                TextAlign.left),
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
                                                        BorderRadius.circular(
                                                            30),
                                                    fontsize: normaltextSize,
                                                    onPressed: () =>
                                                        _controller.lookmore(
                                                            index, context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                        );
                                      },
                                    ),
                                  ))
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
                        Devider(size: 5),
                        Center(
                          child: ButtonElement(
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
                              onPressed: () => _controller.togglesearch(
                                  "onsearch", context)),
                        ),
                        Devider(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
