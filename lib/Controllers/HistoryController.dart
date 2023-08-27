import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:yoldashapp/Theme/ThemeService.dart';
import 'package:yoldashapp/models/rides.dart';

import '../Constants/ButtonElement.dart';
import '../Constants/Devider.dart';
import '../Constants/ImageClass.dart';
import '../Constants/InputElement.dart';
import '../Constants/StaticText.dart';
import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../models/automobils.dart';
import 'MainController.dart';

class HistoryController extends GetxController {
  late MainController _maincontroller = Get.put(MainController());
  RxBool openmodalval = false.obs;
  Rx<String> image = "".obs;
  Rx<bool> refreshpage = Rx<bool>(false);
  final Completer<GoogleMapController> googlemapcontroller = Completer();
  Rx<GoogleMapController?> newgooglemapcontroller =
      Rx<GoogleMapController?>(null);
  RxSet<Polyline?> polyline = RxSet<Polyline?>({});
  RxSet<Marker?> markers = RxSet<Marker?>({});
  RxSet<Circle?> circles = RxSet<Circle?>({});
  Rx<int?> auth_id = Rx<int?>(null);
  Rx<String?> authtype = Rx<String?>('rider');
  Rx<LatLng?> latLngPos = Rx<LatLng?>(null);
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(40.409264, 49.867092),
    zoom: 12,
  );
  Rx<Rides?> selectedRide = Rx<Rides?>(null);
  RxList<Rides?> data = <Rides>[].obs;
  Rx<TextEditingController> priceofwaycontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> namesurnamecontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> phonecontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<int> selectedindex = Rx<int>(0);
  Rx<int> selectedplace = Rx<int>(0);
  Map<int, String> items = {
    1: 'male',
    2: 'female',
  };
  Rx<int> selectedgender = Rx<int>(1);

  HistoryController() {
    getAuthId();
  }

  void getAuthId() async {
    auth_id.value = await _maincontroller.getstoragedat('auth_id');
    authtype.value = await _maincontroller.getstoragedat('authtype');
  }

  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void openModal(imageval) {
    image.value = '';
    if (imageval != null) {
      image.value = imageval;
    }
    openmodalval.value = !openmodalval.value;
  }

  void getridecoordsandmarks(context) async {
    refreshpage.value = true;

    List<LatLng> polylineList = [];

    selectedRide.value?.polylinePoints?.forEach((element) {
      if (element.length >= 2) {
        LatLng latLng = LatLng(element[0], element[1]);
        polylineList.add(latLng);
      }
    });

    if (selectedRide.value?.polylinePoints != null) {
      List polylinePoints = selectedRide.value?.polylinePoints ?? [];

      if (polylinePoints.isNotEmpty) {
        double firstLatitude = polylinePoints.first[0];
        double firstLongitude = polylinePoints.first[1];

        markers.value.add(Marker(
          markerId: MarkerId("marker-first"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(
            title: "mylocation".tr,
            snippet: 'mylocation'.tr,
          ),
          position: LatLng(firstLatitude, firstLongitude),
          draggable: false,
        ));

        circles.value.add(Circle(
          circleId: CircleId("circle-first"),
          fillColor: secondarycolor,
          center: LatLng(firstLatitude, firstLongitude),
          radius: 15,
          strokeWidth: 4,
          strokeColor: errorcolor,
        ));

        double lastLatitude = polylinePoints.last[0];
        double lastLongitude = polylinePoints.last[1];

        markers.value.add(Marker(
          markerId: MarkerId("marker-last"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: "destinationlocation".tr,
            snippet: 'destinationlocation'.tr,
          ),
          position: LatLng(lastLatitude, lastLongitude),
          draggable: false,
        ));

        circles.value.add(Circle(
          circleId: CircleId("circle-last"),
          fillColor: errorcolor,
          center: LatLng(lastLatitude, lastLongitude),
          radius: 15,
          strokeWidth: 4,
          strokeColor: errorcolor,
        ));
      }

      refreshpage.value = false;
    } else {
      refreshpage.value = false;
    }

    Polyline polylineNew = Polyline(
      polylineId: PolylineId("current_destination"),
      color: primarycolor,
      points: polylineList,
      jointType: JointType.mitered,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );

    polyline.value.add(polylineNew);
    if (markers.value.length >= 2) {
      Marker? firstMarker = markers.value.first;
      Marker? lastMarker = markers.value.last;

      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          firstMarker!.position.latitude,
          lastMarker!.position.longitude,
        ),
        northeast: LatLng(
          lastMarker!.position.latitude,
          firstMarker!.position.longitude,
        ),
      );

      newgooglemapcontroller.value?.animateCamera(
        CameraUpdate.newLatLngBounds(
          bounds,
          100,
        ),
      );
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
    }

    refreshpage.value = false;
  }

  void bottombutton(context) async {
    if (authtype.value == "rider") {
      launchUrlTOSITE(selectedRide.value?.user?.phone);
    } else {
      print("ABS");
    }
  }

  List<Widget> groupAndSortPlaces(List<PlacesMark> places, context) {
    Map<int, List<PlacesMark>> rowGroups = {};

    for (var place in places) {
      final row = place.row ?? 0;
      if (!rowGroups.containsKey(row)) {
        rowGroups[row] = [];
      }
      rowGroups[row]!.add(place);
    }

    rowGroups.forEach((row, group) {
      group.sort((a, b) {
        final positionA = a.position ?? 0;
        final positionB = b.position ?? 0;
        return positionA.compareTo(positionB);
      });
    });

    List<Widget> groupedItems = rowGroups.entries.map((entry) {
      List<Widget> rowWidgets = entry.value.map((place) {
        String imageUrl;
        if (place.type == "driver") {
          imageUrl = './assets/images/place_driver.png';
        } else {
          imageUrl = './assets/images/place_rider.png';
        }

        return GestureDetector(
          onTap: () {
            if (place.type == "driver") {
              showToastMSG(errorcolor, "youarenotselectingdriver".tr, context);
            } else {
              selectedplace.value = place.id!;
              Get.back();
            }
          },
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: ImageClass(
              url: selectedplace.value != 0 && selectedplace.value == place.id
                  ? selectedgender == 1
                      ? './assets/images/place_man.png'
                      : './assets/images/place_woman.png'
                  : imageUrl,
              type: false,
              boxfit: BoxFit.contain,
            ),
          ),
        );
      }).toList();

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: rowWidgets,
      );
    }).toList();

    return groupedItems;
  }

  void selectplace(index, List places, Rides ride, BuildContext context) {
    selectedindex.value = index;
    if (index == 1) {
      Get.bottomSheet(Container(
        height: 500,
        color: Colors.white,
        child: Column(
          children: [
            Devider(size: 25),
            StaticText(
              color: secondarycolor,
              size: buttontextSize,
              text: "pleaseselectplaceandclick".tr,
              weight: FontWeight.w500,
              align: TextAlign.center,
              maxline: 2,
            ),
            Devider(size: 25),
            Column(
              children: groupAndSortPlaces(
                  places as List<PlacesMark>, context as BuildContext),
            ),
            Devider(
              size: 25,
            ),
          ],
        ),
      ));
    } else {
      selectedplace.value = 0;
      Get.back();
      lookmore(ride, context);
    }
  }

  void lookmore(Rides ride, BuildContext context) {
    priceofwaycontroller.value.text = ride.priceOfWay!;
    Get.bottomSheet(Container(
      height: 700,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Devider(),
            StaticText(
              color: secondarycolor,
              size: buttontextSize,
              text: "add".tr,
              weight: FontWeight.w500,
              align: TextAlign.center,
            ),
            Devider(),
            Container(
              width: Get.width - 40,
              height: 53,
              decoration: BoxDecoration(
                  color: whitecolor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: InputElement(
                  placeholder: "wayofprice".tr,
                  accentColor: primarycolor,
                  textColor: bodycolor,
                  inputType: TextInputType.number,
                  cornerradius: BorderRadius.all(Radius.circular(50)),
                  controller: priceofwaycontroller.value),
            ),
            Devider(),
            Container(
              width: Get.width - 40,
              height: 53,
              decoration: BoxDecoration(
                  color: whitecolor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: InputElement(
                  placeholder: "name_surname".tr,
                  accentColor: primarycolor,
                  textColor: bodycolor,
                  inputType: TextInputType.text,
                  cornerradius: BorderRadius.all(Radius.circular(50)),
                  controller: namesurnamecontroller.value),
            ),
            Devider(),
            Container(
              width: Get.width - 40,
              height: 53,
              decoration: BoxDecoration(
                  color: whitecolor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: IntlPhoneField(
                cursorColor: primarycolor,
                searchText: "search".tr,
                dropdownIcon: Icon(FeatherIcons.arrowDown,
                    color: secondarycolor, size: smalltextSize),
                decoration: InputDecoration(
                  hintText: "mobile_phone".tr,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: primarycolor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: primarycolor,
                      width: 1.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                ),
                initialCountryCode: 'AZ',
                onChanged: (phone) {
                  var phonenumb = phone.countryCode + phone.number;
                  phonecontroller.value.text = phonenumb.toString();
                },
              ),
            ),
            Devider(),
            SizedBox(
              width: Get.width - 40,
              height: 120,
              child: Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var keysList = items.keys.toList();
                    var valuesList = items.values.toList();

                    var key = keysList[index];

                    var value = valuesList[index];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          title: StaticText(
                            color: darkcolor,
                            size: normaltextSize,
                            text: "gender_$value".tr,
                            weight: FontWeight.w500,
                            align: TextAlign.left,
                          ),
                          trailing: Radio<bool>(
                            value: true,
                            activeColor: primarycolor,
                            focusColor: primarycolor,
                            hoverColor: primarycolor,
                            toggleable: true,
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                            groupValue: selectedgender == key ? true : false,
                            onChanged: (value) {
                              selectedgender.value = key;
                              Get.back();
                              lookmore(ride, context);
                            },
                          ),
                        ),
                        Devider(size: 5),
                      ],
                    );
                  },
                ),
              ),
            ),
            Devider(),
            Center(
              child: Container(
                width: Get.width - 40,
                height: 70,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => selectplace(
                          1,
                          ride.automobil?.autotype?.placesMark ?? [],
                          ride as Rides,
                          context as BuildContext),
                      child: Container(
                        width: 110,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: primarycolor,
                                style: BorderStyle.solid,
                                width: 1),
                            borderRadius: BorderRadius.circular(35),
                            color: selectedindex.value != null &&
                                    selectedindex.value == 1
                                ? primarycolor
                                : whitecolor),
                        child: StaticText(
                            color: selectedindex.value != null &&
                                    selectedindex.value == 1
                                ? whitecolor
                                : darkcolor,
                            size: normaltextSize,
                            weight: FontWeight.w500,
                            align: TextAlign.center,
                            text: "choiseplace".tr),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => selectplace(
                          2,
                          ride.automobil?.autotype?.placesMark ?? [],
                          ride as Rides,
                          context as BuildContext),
                      child: Container(
                        width: 150,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: primarycolor,
                                style: BorderStyle.solid,
                                width: 1),
                            borderRadius: BorderRadius.circular(35),
                            color: selectedindex.value != null &&
                                    selectedindex.value == 2
                                ? primarycolor
                                : whitecolor),
                        child: StaticText(
                            color: selectedindex.value != null &&
                                    selectedindex.value == 2
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
              ),
            ),
            Devider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonElement(
                  text: "close".tr,
                  width: 90,
                  onPressed: () {
                    selectedplace.value = 0;
                    selectedindex.value = 0;
                    Get.back();
                  },
                  bgColor: primarycolor,
                  borderRadius: BorderRadius.circular(45),
                  fontsize: normaltextSize,
                  height: 45,
                  textColor: whitecolor,
                ),
                SizedBox(
                  width: 7,
                ),
                ButtonElement(
                  text: "add".tr,
                  width: 160,
                  onPressed: () => sendrequest(context),
                  bgColor: primarycolor,
                  borderRadius: BorderRadius.circular(80),
                  fontsize: normaltextSize,
                  height: 45,
                  textColor: whitecolor,
                ),
              ],
            ),
            Devider()
          ],
        ),
      ),
    ));
  }

  void sendrequest(BuildContext context) async {
    refreshpage.value = true;
    List<CoordinatesRides> coordinatesList = selectedRide.value!.coordinates!;
    List<Map<String, dynamic>> coordinatesMapList =
        coordinatesList.map((coord) => coord.toJsonMap()).toList();
    String coordinatesJson = jsonEncode(coordinatesMapList);

    if ((namesurnamecontroller.value.text != null &&
            namesurnamecontroller.value.text != '' &&
            namesurnamecontroller.value.text != ' ') &&
        (phonecontroller.value.text != null &&
            phonecontroller.value.text != '' &&
            phonecontroller.value.text != ' ') &&
        (priceofwaycontroller.value.text != null &&
            priceofwaycontroller.value.text != '' &&
            priceofwaycontroller.value.text != ' ') &&
        (selectedgender.value != null &&
            selectedgender.value != '' &&
            selectedgender.value != ' ')) {
      Map<String, dynamic> body = {
        "ride_id": selectedRide.value?.id,
        "price": priceofwaycontroller.value.text ?? 0,
        "weight": 0,
        "position": selectedplace.value ?? null,
        "name_surname": namesurnamecontroller.value.text ?? '',
        'phone': phonecontroller.value.text ?? '',
        'gender': selectedgender.value ?? 1,
        "coordinates": coordinatesJson
      };
      print(body);
      refreshpage.value = false;
      var response =
          await GetAndPost.postData("rides_sendrequests", body, context);

      print(response);
      Get.back();

      if (response != null) {
        String status = response['status'];
        String message = '';
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          refreshpage.value = false;
          selectedindex.value = 0;
          priceofwaycontroller.value = TextEditingController();
          namesurnamecontroller.value = TextEditingController();
          phonecontroller.value = TextEditingController();
          selectedgender.value = 1;
          getridedata(context, selectedRide.value!.id as int);
        } else {
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } else {
      refreshpage.value = false;
      Get.back();
      showToastMSG(errorcolor, "fillthefield".tr, context);
    }
  }

  void getridedata(context, int id) async {
    selectedRide.value = Rides();
    refreshpage.value = true;
    var body = {};
    var response = await GetAndPost.fetchData("rides/${id}", body, context);
    print("RIDE DATA -----------------------------");
    print(response);
    if (response != null) {
      String status = response['status'];
      String message = '';
      if (response['message'] != null) message = response['message'];
      if (status == "success") {
        selectedRide.value = Rides.fromMap(response['data']);
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, message, context);
      }
    }

    refreshpage.value = false;
  }
}
