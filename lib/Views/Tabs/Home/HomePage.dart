import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoldashapp/Constants/SearchedLocationItems.dart';
import 'package:yoldashapp/Controllers/HistoryController.dart';
import 'package:yoldashapp/Functions/helpers.dart';
import 'package:yoldashapp/models/searchionglocations.dart';

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
import '../../../models/rides.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoingController _controller = Get.put(GoingController());
  late AuthController _authcontroller = Get.put(AuthController());
  late HistoryController _historycontroller = Get.put(HistoryController());

  String? getrideofferprice(Rides ride, type) {
    if (type == "rider") {
      List queries = ride.queries ?? [];
      Queries? query;
      if (queries != null && queries.length > 0) {
        for (var i = 0; i < queries.length; i++) {
          Queries q = queries[i];
          if (q != null && q.userId == _controller.auth_id.value) {
            query = q;
          }
        }
        return query?.priceEndirim.toString() ?? '0';
      } else {
        return '0';
      }
    } else {
      return ride.priceOfWay ?? '0';
    }
  }

  Widget getmyroutes(context) {
    if (_controller.currentrides.value.length > 0 &&
        _controller.currentrides.value != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controller.currentrides.value.length,
              itemBuilder: (context, index) {
                Rides ride = _controller.currentrides.value[index];
                String addressText = '';
                if (ride.coordinates != null) {
                  addressText = ride.coordinates!
                      .map((element) => element.address ?? '')
                      .join(', ');
                }
                return GestureDetector(
                  onTap: () {
                    _historycontroller.selectedRide.value = ride;
                    _historycontroller.getRides(context, ride.id, false);
                    Get.toNamed('/history/${ride.id}');
                  },
                  child: Center(
                    child: Container(
                      width: Get.width - 40,
                      height: addressText.length > 45 ? 125 : 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: whitecolor,
                        border: Border(
                            bottom: BorderSide(
                                color: iconcolor,
                                style: BorderStyle.solid,
                                width: 1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            child: CachedNetworkImage(
                              imageUrl: getimageurl(
                                  "models",
                                  'automobils/types',
                                  ride.automobil?.autotype?.icon),
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
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 11),
                          SizedBox(
                            width: Get.width / 1.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StaticText(
                                  maxline: 5,
                                  textOverflow: TextOverflow.clip,
                                  text: addressText,
                                  weight: FontWeight.w500,
                                  size: normaltextSize,
                                  color: darkcolor,
                                  align: TextAlign.left,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FeatherIcons.clock,
                                      color: iconcolor,
                                      size: normaltextSize,
                                    ),
                                    SizedBox(width: 4),
                                    StaticText(
                                      text: "${convertfromintToTime(ride.startTime)}",
                                      weight: FontWeight.w500,
                                      size: smalltextSize,
                                      color: iconcolor,
                                      align: TextAlign.left,
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      FeatherIcons.user,
                                      color: iconcolor,
                                      size: normaltextSize,
                                    ),
                                    SizedBox(width: 4),
                                    StaticText(
                                      text:
                                          "${ride.automobil?.autotype?.places}",
                                      weight: FontWeight.w500,
                                      size: smalltextSize,
                                      color: iconcolor,
                                      align: TextAlign.left,
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      FontAwesomeIcons.moneyBill,
                                      color: iconcolor,
                                      size: normaltextSize,
                                    ),
                                    SizedBox(width: 4),
                                    StaticText(
                                      text:
                                          " ${getrideofferprice(ride as Rides, _controller.authtype.value)} AZN",
                                      weight: FontWeight.w500,
                                      size: smalltextSize,
                                      color: iconcolor,
                                      align: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                          _controller.refreshpage.value = true;
                                          _controller.searchinglocations.value =
                                              [];
                                          _controller.refreshpage.value = false;
                                          _controller..openmodal.value = true;
                                          _controller.loading.value = false;
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
                                            text: _controller.directiondetails
                                                .value!.durationText!
                                                .toString()),
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
                                        child:
                                            _controller
                                                            .cardscontroller
                                                            .selectedCards
                                                            .value !=
                                                        null &&
                                                    _controller
                                                            .cardscontroller
                                                            .selectedCards
                                                            .value
                                                            ?.id !=
                                                        null &&
                                                    _controller
                                                            .cardscontroller
                                                            .selectedCards
                                                            .value
                                                            ?.id !=
                                                        '' &&
                                                    _controller
                                                            .cardscontroller
                                                            .selectedCards
                                                            .value
                                                            ?.id !=
                                                        ' ' &&
                                                    _controller
                                                            .cardscontroller
                                                            .selectedCards
                                                            .value
                                                            ?.cardholdername !=
                                                        null &&
                                                    _controller
                                                            .cardscontroller
                                                            .selectedCards
                                                            .value
                                                            ?.cardholdername !=
                                                        '' &&
                                                    _controller
                                                            .cardscontroller
                                                            .selectedCards
                                                            .value
                                                            ?.cardholdername !=
                                                        ' '
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(width: 15),
                                                      Container(
                                                        width: 70,
                                                        height: 40,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 0),
                                                        decoration: BoxDecoration(
                                                            color: whitecolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Icon(
                                                          fontawesome(_controller
                                                                  .cardscontroller
                                                                  .selectedCards
                                                                  .value
                                                                  ?.cardtype
                                                              as String),
                                                          color: primarycolor,
                                                          size: headingSize,
                                                        ),
                                                      ),
                                                      SizedBox(width: 15),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          StaticText(
                                                            color: darkcolor,
                                                            size:
                                                                normaltextSize,
                                                            align:
                                                                TextAlign.left,
                                                            weight:
                                                                FontWeight.w500,
                                                            text: _controller
                                                                    .cardscontroller
                                                                    .selectedCards
                                                                    .value!
                                                                    .cardholdername
                                                                as String,
                                                          ),
                                                          StaticText(
                                                            color: iconcolor,
                                                            size: smalltextSize,
                                                            align:
                                                                TextAlign.left,
                                                            weight:
                                                                FontWeight.w400,
                                                            text:
                                                                "changepaymentmethod"
                                                                    .tr,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 15),
                                                      Icon(
                                                          FeatherIcons
                                                              .chevronRight,
                                                          color: iconcolor,
                                                          size: buttontextSize),
                                                    ],
                                                  )
                                                : SizedBox(),
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
                                                ? "reservation".tr
                                                : "addroute".tr,
                                        width: width - 70,
                                        onPressed: () {
                                          _controller.togglesearch(
                                              "onmap", context);
                                        }),
                                  ),
                                ],
                              ),
                            ))
                        : Positioned(
                            bottom: 0,
                            left: 20,
                            width: width - 30,
                            child: Container(
                                height: width - 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _controller.currentrides.value.length > 0 &&
                                            _controller.currentrides.value
                                                    .length !=
                                                null
                                        ? Container(
                                            height: 130,
                                            child: getmyroutes(context),
                                          )
                                        : SizedBox(),
                                    Container(
                                      width: width - 40,
                                      height: 140,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                          color: whitecolor,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Center(
                                                      child: SizedBox(
                                                        width: width - 125,
                                                        child: StaticText(
                                                          color: iconcolor,
                                                          size: normaltextSize,
                                                          text: _controller.addresscontrollers
                                                                              .value[
                                                                          'position_0'] !=
                                                                      null &&
                                                                  _controller
                                                                          .addresscontrollers
                                                                          .value[
                                                                              'position_0']
                                                                          .text
                                                                          .toString()
                                                                          .length >
                                                                      0
                                                              ? _controller
                                                                  .addresscontrollers
                                                                  .value[
                                                                      'position_0']
                                                                  .text
                                                                  .toString()
                                                              : "from".tr,
                                                          weight:
                                                              FontWeight.w400,
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
                                                          text: _controller.addresscontrollers
                                                                              .value[
                                                                          'position_1'] !=
                                                                      null &&
                                                                  _controller
                                                                          .addresscontrollers
                                                                          .value[
                                                                              'position_1']
                                                                          .text
                                                                          .toString()
                                                                          .length >
                                                                      0
                                                              ? _controller
                                                                  .addresscontrollers
                                                                  .value[
                                                                      'position_1']
                                                                  .text
                                                                  .toString()
                                                              : "to".tr,
                                                          weight:
                                                              FontWeight.w400,
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
                                      ),
                                    ),
                                  ],
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
                              margin: EdgeInsets.only(left: 10),
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
                              height: 100,
                              child: ImageClass(
                                  boxfit: BoxFit.contain,
                                  url: "./assets/images/destinationicon.png",
                                  type: false),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 100,
                              width: width - 67,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: _controller
                                          .addresscontrollers.value.length,
                                      itemBuilder: (context, index) {
                                        TextEditingController? controllernow =
                                            _controller.addresscontrollers
                                                .value['position_$index'];

                                        if (controllernow != null) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 3),
                                                height: 45,
                                                width: width - 120,
                                                child: InputElement(
                                                  accentColor: iconcolor,
                                                  controller: controllernow,
                                                  placeholder: controllernow
                                                                  .text !=
                                                              null &&
                                                          controllernow
                                                                  .text.length >
                                                              0
                                                      ? controllernow.text
                                                          .toString()
                                                      : index == 0
                                                          ? "from".tr
                                                          : "to".tr,
                                                  textColor: iconcolor,
                                                  cornerradius:
                                                      BorderRadius.circular(40),
                                                  inputType: TextInputType.text,
                                                  onchanged: (val) =>
                                                      _controller.findplaces(
                                                    val,
                                                    controllernow,
                                                    'position_${index}',
                                                    context,
                                                  ),
                                                ),
                                              ),
                                              index != 0
                                                  ? _controller.addresscontrollers[
                                                              'position_${index + 1}'] ==
                                                          null
                                                      ? IconButton(
                                                          onPressed: () {
                                                            _controller
                                                                .refreshpage
                                                                .value = true;
                                                            _controller
                                                                .addorremoveeditingcontroller(
                                                                    index + 1,
                                                                    'add');
                                                            _controller
                                                                .refreshpage
                                                                .value = false;
                                                          },
                                                          icon: Icon(
                                                            FeatherIcons.plus,
                                                            color: primarycolor,
                                                            size:
                                                                normaltextSize,
                                                          ))
                                                      : IconButton(
                                                          onPressed: () {
                                                            _controller
                                                                .addorremoveeditingcontroller(
                                                                    index,
                                                                    'delete');
                                                          },
                                                          icon: Icon(
                                                            FeatherIcons.minus,
                                                            color: errorcolor,
                                                            size:
                                                                normaltextSize,
                                                          ))
                                                  : SizedBox(),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Devider(
                          size: 3,
                        ),
                        _controller.searchinglocations.value.length > 0
                            ? SizedBox(
                                height: 360,
                                child: ListView.builder(
                                  padding:EdgeInsets.zero,
                                  itemCount: _controller
                                      .searchinglocations.value.length,
                                  itemBuilder: (context, index) {
                                    SearchingLocations searchedlocationitem =
                                        _controller
                                            .searchinglocations.value[index];
                                    if (searchedlocationitem != null) {
                                      return Column(
                                        children: [
                                          SearchedLocationItems(
                                            searchedlocation:
                                                searchedlocationitem,
                                          ),
                                          Divider(
                                            height: 5,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container(); // Null değerler için boş bir Container döndürün
                                    }
                                  },
                                ),
                              )
                            : Container(),
                        Devider(
                          size:3
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Devider(size:5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  FeatherIcons.briefcase,
                                  color: primarycolor,
                                  size:buttontextSize,
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: width - 110,
                                  height:45,
                                  child: InputElement(
                                    accentColor: iconcolor,
                                    controller:
                                        _controller.weightcontroller.value,
                                    placeholder: "weight".tr + ", kg",
                                    textColor: iconcolor,
                                    cornerradius: BorderRadius.circular(40),
                                    inputType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            Devider(size:5),
                            _authcontroller.authType == "driver"
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Icon(
                                        FontAwesomeIcons.road,
                                        color: primarycolor,
                                        size:buttontextSize,
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: width - 110,
                                        height:45,
                                        child: InputElement(
                                          accentColor: iconcolor,
                                          controller: _controller
                                              .minimumpriceofwaycontroller
                                              .value,
                                          placeholder: "minumumwayofprice".tr,
                                          textColor: iconcolor,
                                          cornerradius:
                                              BorderRadius.circular(40),
                                          inputType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            Devider(size:5),
                            _authcontroller.authType == "driver"
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10),
                                      Icon(
                                        FontAwesomeIcons.car,
                                        color: primarycolor,
                                        size:buttontextSize,
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: width - 110,
                                        height:45,
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
                            Devider(size:5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  FeatherIcons.clock,
                                  color: primarycolor,
                                  size:buttontextSize,
                                ),
                                SizedBox(width: 20),
                                Center(
                                  child: SizedBox(
                                    width: width - 70,
                                    height: 30,
                                    child: GestureDetector(
                                      onTap: () =>
                                          _controller.changeindex(1, context),
                                      child: Container(
                                        width: 90,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primarycolor,
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            color: _controller.selectedindex
                                                            .value !=
                                                        null &&
                                                    _controller.selectedindex
                                                            .value ==
                                                        1
                                                ? primarycolor
                                                : whitecolor),
                                        child: StaticText(
                                            color: _controller.selectedindex
                                                            .value !=
                                                        null &&
                                                    _controller.selectedindex
                                                            .value ==
                                                        1
                                                ? whitecolor
                                                : darkcolor,
                                            size: normaltextSize,
                                            weight: FontWeight.w500,
                                            align: TextAlign.center,
                                            text:
                                                '${converttimedayandmonth(_controller.fromTimeSelectable.value)} ${_controller.authtype.value == 'rider' ? "- ${converttimedayandmonth(_controller.toTimeSelectable.value)}" : ""} '),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Devider(size:5),
                          ],
                        ),
                        
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
                                    Devider(size:5),
                                    Center(
                                      child: SizedBox(
                                        width: width - 40,
                                        child: LineLoaderWidget(
                                          function: () => _controller
                                              .togglesearch('onmap', context),
                                          color: primarycolor,
                                          duration:
                                              Duration(milliseconds: 2500),
                                          width: width - 40,
                                          height: 10,
                                        ),
                                      ),
                                    ),
                                    Devider(size:5),
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
                            : _controller.data.value.length > 0 &&
                                    (_controller.resulttext?.value == null ||
                                        _controller.resulttext?.value == ' ' ||
                                        _controller.resulttext?.value == '')
                                ? Center(
                                    child: SizedBox(
                                    width: width - 40,
                                    height: width,
                                    child: ListView.builder(
                                      itemCount: _controller.data.value.length,
                                      itemBuilder: (context, index) {
                                        Rides ride =
                                            _controller.data.value[index];

                                        String addressText = '';
                                        if (ride.coordinates != null) {
                                          addressText = ride.coordinates!
                                              .map((element) =>
                                                  element.address ?? '')
                                              .join(', ');
                                        }
                                        return GestureDetector(
                                          onTap: () => _controller.lookmore(
                                              ride, context),
                                          child: Center(
                                            child: Container(
                                              width: width - 40,
                                              height: addressText.length > 30
                                                  ? 170
                                                  : 120,
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
                                                        width: 1)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    child: CachedNetworkImage(
                                                      imageUrl: getimageurl(
                                                          "models",
                                                          'automobils/types',
                                                          ride.automobil
                                                              ?.autotype?.icon),
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          CircleAvatar(
                                                        backgroundColor:
                                                            primarycolor,
                                                        foregroundColor:
                                                            whitecolor,
                                                        radius: 35,
                                                        backgroundImage:
                                                            imageProvider,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 11),
                                                  SizedBox(
                                                    width: Get.width / 2.6,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        StaticText(
                                                          maxline: 5,
                                                          textOverflow:
                                                              TextOverflow.clip,
                                                          text: addressText,
                                                          weight:
                                                              FontWeight.w500,
                                                          size: normaltextSize,
                                                          color: darkcolor,
                                                          align: TextAlign.left,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              FeatherIcons.user,
                                                              color: iconcolor,
                                                              size:
                                                                  normaltextSize,
                                                            ),
                                                            SizedBox(width: 4),
                                                            StaticText(
                                                              text:
                                                                  " ${ride.automobil?.autotype?.places}",
                                                              weight: FontWeight
                                                                  .w500,
                                                              size:
                                                                  smalltextSize,
                                                              color: iconcolor,
                                                              align: TextAlign
                                                                  .left,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .moneyBill,
                                                              color: iconcolor,
                                                              size:
                                                                  normaltextSize,
                                                            ),
                                                            SizedBox(width: 4),
                                                            StaticText(
                                                              text:
                                                                  " ${ride.priceOfWay}",
                                                              weight: FontWeight
                                                                  .w500,
                                                              size:
                                                                  smalltextSize,
                                                              color: iconcolor,
                                                              align: TextAlign
                                                                  .left,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
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
                                                              ride, context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ))
                                : Center(
                                    child: SizedBox(
                                      width: width - 40,
                                      height: width / 1.6,
                                      child: _controller.resulttext?.value !=
                                                  null &&
                                              _controller.resulttext?.value !=
                                                  '' &&
                                              _controller.resulttext?.value !=
                                                  ' '
                                          ? Center(
                                              child: StaticText(
                                                  align: TextAlign.center,
                                                  text: _controller
                                                          .resulttext?.value ??
                                                      ' ',
                                                  weight: FontWeight.w700,
                                                  size: normaltextSize,
                                                  color: errorcolor),
                                            )
                                          : ImageClass(
                                              type: false,
                                              boxfit: BoxFit.contain,
                                              url: "assets/images/findcar.png"),
                                    ),
                                  ),
                        Devider(size: 10),
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
                                      : "addroute".tr,
                              width: width - 70,
                              onPressed: () => _controller.authtype.value ==
                                      "rider"
                                  ? _controller.togglesearch("onmap", context)
                                  : _controller.togglesearch(
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
