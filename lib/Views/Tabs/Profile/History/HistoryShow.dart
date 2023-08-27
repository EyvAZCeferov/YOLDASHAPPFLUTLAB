import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoldashapp/models/rides.dart';

import '../../../../Constants/BaseAppBar.dart';
import '../../../../Constants/ButtonElement.dart';
import '../../../../Constants/Devider.dart';
import '../../../../Constants/ImageClass.dart';
import '../../../../Constants/ImageModal.dart';
import '../../../../Constants/LoaderScreen.dart';
import '../../../../Constants/StaticText.dart';
import '../../../../Controllers/GoingController.dart';
import '../../../../Controllers/HistoryController.dart';
import '../../../../Controllers/MessagesController.dart';
import '../../../../Functions/helpers.dart';
import '../../../../Theme/ThemeService.dart';
import '../../../../models/automobils.dart';

class HistoryShow extends StatelessWidget {
  final HistoryController _controller = Get.find<HistoryController>();
  final GoingController _goingcontroller = Get.find<GoingController>();
  final MessagesController _messagesController = Get.find<MessagesController>();

  List<Widget> addressWidgets = [];

  void getaddress() {
    if (_controller.selectedRide.value?.coordinates != null) {
      for (var address in _controller.selectedRide.value!.coordinates!) {
        addressWidgets.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StaticText(
                color: secondarycolor,
                size: smalltextSize,
                text: address.address as String,
                weight: FontWeight.bold,
              ),
              Devider(),
            ],
          ),
        );
      }
    }
  }

  HistoryShow() {
    getaddress();
  }

  @override
  Widget build(BuildContext context) {
    _controller.getridedata(context, _controller.selectedRide.value!.id!);
    final width = MediaQuery.of(context).size.width;
    _controller.getridecoordsandmarks(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        changeprof: false,
        title: "historydetail".tr,
        titlebg: false,
      ),
      body: Obx(
        () => _controller.refreshpage.value == true
            ? LoaderScreen()
            : _controller.openmodalval.value == true
                ? ImageModal(
                    image: _controller.image.value,
                    close: () => _controller.openModal(null))
                : Stack(fit: StackFit.expand, children: [
                    Positioned.fill(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: Get.width - 100,
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
                            _controller.getridecoordsandmarks(context);
                          },
                        )),
                    _controller.selectedRide.value?.coordinates != null
                        ? Positioned(
                            top: 80,
                            left: 20,
                            width: width - 40,
                            child: Container(
                              width: width - 40,
                              height: width / 3.5,
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
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Devider(size: 3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 44,
                                        height: 77,
                                        child: ImageClass(
                                          url:
                                              "assets/images/destinationicon.png",
                                          type: false,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: addressWidgets,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Devider(size: 3),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                    Positioned.fill(
                        top: Get.width - 100,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          margin: EdgeInsets.symmetric(vertical: 0),
                          decoration: BoxDecoration(
                              color: whitecolor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(42),
                                  topRight: Radius.circular(42)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurStyle: BlurStyle.solid,
                                  color: Colors.black38,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ]),
                          width: Get.width - 100,
                          child: Container(
                            child: _rendercontent(context),
                          ),
                        ))
                  ]),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: whitecolor,
        margin: EdgeInsets.only(bottom: 15),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ButtonElement(
              text: _controller.authtype.value == "rider"
                  ? "contact".tr
                  : "startride".tr,
              height: 50,
              width: width - 100,
              borderRadius: BorderRadius.circular(45),
              onPressed: () => _controller.bottombutton(context)),
        ),
      ),
    );
  }

  Widget _rendercontent(context) {
    if (_controller.authtype.value == "rider") {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Devider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StaticText(
                color: darkcolor,
                size: subHeadingSize,
                text: "customers".tr,
                weight: FontWeight.bold,
                align: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
              ),
              ButtonElement(
                  text: "add".tr,
                  height: 50,
                  width: Get.width / 3,
                  borderRadius: BorderRadius.circular(45),
                  onPressed: () => _controller.lookmore(
                      _controller.selectedRide.value!, context)),
            ],
          ),
          Devider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StaticText(
                color: darkcolor,
                size: normaltextSize,
                text: "total_price".tr,
                weight: FontWeight.bold,
                align: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
              ),
              StaticText(
                color: darkcolor,
                size: normaltextSize,
                text: _controller.selectedRide.value!.priceOfWay.toString() +
                    "/${calculatequeryprices()} AZN",
                weight: FontWeight.bold,
                align: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Devider(),
          _controller.selectedRide.value!.queries != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _controller.selectedRide.value?.queries
                            ?.where((element) {
                          if (element.userId != element.driverId &&
                              (element.status == "accepted" ||
                                  element.status == "arrivedoncustomer" ||
                                  element.status == "changed" ||
                                  element.status == "waiting")) {
                            return true;
                          }
                          return false;
                        }).length ??
                        0,
                    itemBuilder: (context, index) {
                      var query = _controller.selectedRide.value!.queries!
                          .where((element) =>
                              (element.status == "accepted" ||
                                  element.status == "arrivedoncustomer" ||
                                  element.status == "changed" ||
                                  element.status == "waiting") &&
                              element.userId != element.driverId)
                          .toList()[index];
                      String addressText = '';
                      if (query?.coordinates != null) {
                        query!.coordinates!
                            .where(
                                (element) => element.type != "currentposition")
                            .map((element) => element.address ?? '')
                            .toList();
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width - 40,
                            height: 145,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: whitecolor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurStyle: BlurStyle.solid,
                                    color: Colors.black38,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ]),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: getimageurl("user", 'users',
                                        query.rider?.additionalinfo?.image),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      backgroundColor: primarycolor,
                                      foregroundColor: whitecolor,
                                      radius: 35,
                                      backgroundImage: imageProvider,
                                    ),
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StaticText(
                                          color: darkcolor,
                                          size: normaltextSize,
                                          weight: FontWeight.w500,
                                          align: TextAlign.left,
                                          text: query?.rider?.nameSurname ?? '',
                                        ),
                                        query?.place != null
                                            ? StaticText(
                                                color: iconcolor,
                                                size: smalltextSize,
                                                weight: FontWeight.w400,
                                                align: TextAlign.left,
                                                text: getLocalizedValue(
                                                        query!.place!.name
                                                            as Name,
                                                        'name')
                                                    .toString(),
                                              )
                                            : SizedBox(),
                                        query?.weight != null &&
                                                query?.weight != 0 &&
                                                query?.weight != 0.00 &&
                                                query?.weight != '0.00' &&
                                                query?.weight != '0'
                                            ? Row(
                                                children: [
                                                  Icon(
                                                    FeatherIcons.briefcase,
                                                    color: primarycolor,
                                                    size: normaltextSize,
                                                  ),
                                                  StaticText(
                                                    color: iconcolor,
                                                    size: smalltextSize,
                                                    weight: FontWeight.w400,
                                                    align: TextAlign.left,
                                                    text:
                                                        " ${query!.weight} kg",
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                        StaticText(
                                          color: iconcolor,
                                          size: smalltextSize,
                                          text: addressText,
                                          weight: FontWeight.w500,
                                          align: TextAlign.left,
                                          maxline: 5,
                                        ),
                                        StaticText(
                                          color: darkcolor,
                                          size: normaltextSize,
                                          weight: FontWeight.w600,
                                          align: TextAlign.left,
                                          text: "${query!.price} AZN",
                                        ),
                                      ]),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _messagesController
                                            .createandredirectchat(
                                                query?.userId,
                                                query?.driverId,
                                                context),
                                        style: ElevatedButton.styleFrom(
                                          primary: primarycolor,
                                          onPrimary: whitecolor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(FeatherIcons.messageCircle,
                                                color: whitecolor,
                                                size: normaltextSize),
                                            StaticText(
                                                text: " " + "chat".tr,
                                                weight: FontWeight.w400,
                                                size: normaltextSize,
                                                color: whitecolor),
                                          ],
                                        ),
                                      ),
                                      query?.status == "waiting"
                                          ? ElevatedButton(
                                              onPressed: () =>
                                                  _controller.settypequery(
                                                      query?.id,
                                                      "accept",
                                                      context),
                                              style: ElevatedButton.styleFrom(
                                                primary: primarycolor,
                                                onPrimary: whitecolor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(FeatherIcons.check,
                                                      color: whitecolor,
                                                      size: normaltextSize),
                                                  StaticText(
                                                      text: " " + "accept".tr,
                                                      weight: FontWeight.w400,
                                                      size: normaltextSize,
                                                      color: whitecolor),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      query?.status == "waiting"
                                          ? ElevatedButton(
                                              onPressed: () =>
                                                  _controller.settypequery(
                                                      query?.id,
                                                      "notaccepted",
                                                      context),
                                              style: ElevatedButton.styleFrom(
                                                primary: errorcolor,
                                                onPrimary: whitecolor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(FeatherIcons.x,
                                                      color: whitecolor,
                                                      size: normaltextSize),
                                                  StaticText(
                                                      text: " " + "cancel".tr,
                                                      weight: FontWeight.w400,
                                                      size: normaltextSize,
                                                      color: whitecolor),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      query?.status == "accepted" ||
                                              query?.status ==
                                                  "arrivedoncustomer"
                                          ? ElevatedButton(
                                              onPressed: () => print("asd"),
                                              style: ElevatedButton.styleFrom(
                                                primary: secondarycolor,
                                                onPrimary: whitecolor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(FeatherIcons.eye,
                                                      color: whitecolor,
                                                      size: normaltextSize),
                                                  StaticText(
                                                      text: " " + "more".tr,
                                                      weight: FontWeight.w400,
                                                      size: normaltextSize,
                                                      color: whitecolor),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ]),
                          ),
                          Devider(),
                        ],
                      );
                    },
                  ),
                )
              : SizedBox(),
        ],
      );
    }
  }

  String calculatequeryprices() {
    List<Queries>? queries = _controller.selectedRide.value!.queries;
    var totalPrice = 0.0;
    if (queries != null && queries.length != 0) {
      queries.forEach((element) {
        if ((element.price != null && element.price != "null") &&
            (element.status == "accepted" ||
                element.status == "arrivedoncustomer" ||
                element.status == "changed")) {
          if (element.userId != element.driverId) {
            double parsedPrice = double.tryParse(element!.price!) ?? 0.0;
            totalPrice += parsedPrice;
          }
        }
      });
    }
    return totalPrice.toStringAsFixed(2);
  }
}
