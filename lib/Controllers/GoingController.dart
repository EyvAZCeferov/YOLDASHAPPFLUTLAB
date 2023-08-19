import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldashapp/models/distancedetails.dart';
import 'package:yoldashapp/models/searchionglocations.dart';

import '../Constants/ButtonElement.dart';
import '../Constants/Devider.dart';
import '../Constants/ImageClass.dart';
import '../Constants/StaticText.dart';
import '../Constants/TimePicker.dart';
import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../models/user_locations.dart';
import 'CardsController.dart';
import 'MainController.dart';

class GoingController extends GetxController {
  final MainController _maincontroller = Get.put(MainController());
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<TextEditingController> fromcontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> tocontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> weightcontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> minimumpriceofwaycontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> priceofwaycontroller =
      Rx<TextEditingController>(TextEditingController());
  final openmodal = false.obs;
  final data = [].obs;
  final addedsectionshow = false.obs;
  final loading = false.obs;
  final selectedindex = 0.obs;
  final Rx<DateTime> selectedTime = DateTime.now().obs;
  final selectedplace = 0.obs;
  RxList<UserLocations> userlocations = <UserLocations>[].obs;
  final Completer<GoogleMapController> googlemapcontroller = Completer();
  Rx<GoogleMapController?> newgooglemapcontroller =
      Rx<GoogleMapController?>(null);
  Rx<Position?> currentposition = Rx<Position?>(null);
  Rx<Geolocator?> geolocator = Rx<Geolocator?>(null);
  RxList<SearchingLocations> searchinglocations = <SearchingLocations>[].obs;
  RxList<UserLocations> goinglocations = <UserLocations>[].obs;
  Rx<DistanceDetails?> directiondetails =
      Rx<DistanceDetails>(DistanceDetails());
  RxList<LatLng> latlngs = <LatLng>[].obs;
  RxSet<Polyline?> polyline = RxSet<Polyline?>({});
  RxSet<Marker?> markers = RxSet<Marker?>({});
  RxSet<Circle?> circles = RxSet<Circle?>({});
  Rx<TextEditingController> editingcontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<String> inptype = Rx<String>('to');

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(40.409264, 49.867092),
    zoom: 14.4746,
  );

  void getcurrentposition(context) async {
    refreshpage.value = true;
    await handlepermissionreq(Permission.location, context);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentposition.value = position;
    LatLng latLngPos = LatLng(position.latitude, position.longitude);
    CameraPosition cameraposition =
        new CameraPosition(target: latLngPos, zoom: 14);
    String language = await _maincontroller.getstoragedat('language');

    kGooglePlex = cameraposition;
    var response = await GetAndPost.fetcOtherhData(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapsApiKey&language=$language',
        context, {});
    refreshpage.value = false;

    newgooglemapcontroller.value
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
    if (response != null) {
      var nameaddress = response['results'][0]["address_components"][3]
              ['long_name'] +
          ", " +
          response['results'][0]["address_components"][2]['long_name'] +
          ", " +
          response['results'][0]["address_components"][1]['long_name'];
      fromcontroller.value.text = nameaddress;
      goinglocations.value.add(UserLocations(
          id: 1,
          coordinates: Coordinates(
              latitude: position.latitude, longitude: position.longitude),
          name: Name(
              azName: nameaddress,
              ruName: nameaddress,
              enName: nameaddress,
              trName: nameaddress),
          status: true,
          type: "first"));
    }
  }

  void addsections() {
    addedsectionshow.value = !addedsectionshow.value;
  }

  void changeindex(index) {
    selectedindex.value = 0;
    selectedindex.value = index;
    Get.bottomSheet(Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Devider(),
          StaticText(
            color: secondarycolor,
            size: buttontextSize,
            text: "choisetime".tr,
            weight: FontWeight.w500,
            align: TextAlign.center,
          ),
          Devider(),
          Obx(
            () => Expanded(
              child: TimePicker(
                initialTime: selectedTime.value,
                onTimeSelected: (time) {
                  selectedTime.value = time;
                },
              ),
            ),
          ),
          Devider(),
          ButtonElement(
            text: "choise".tr,
            width: 90,
            onPressed: () => Get.back(),
            bgColor: primarycolor,
            borderRadius: BorderRadius.circular(45),
            fontsize: normaltextSize,
            height: 45,
            textColor: whitecolor,
          ),
          Devider(),
        ],
      ),
    ));
  }

  void findplaces(String placename, TextEditingController controller,
      String type, context) async {
    if (placename != null && placename.length > 1) {
      searchinglocations.value = [];
      var url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&location=40.409264%2C-49.867092&key=$mapsApiKey&components=country:az";
      var response = await GetAndPost.fetcOtherhData(url, context, {});
      if (response['status'] == "OK") {
        var listelements = (response['predictions'] as List)
            .map((e) => SearchingLocations.fromJson(e))
            .toList();
        searchinglocations.value = listelements;
        editingcontroller.value = controller;
        inptype.value = type;
      }
    } else {
      searchinglocations.value = [];
    }
  }

  void selectsearchedloc(String place_id, context) async {
    refreshpage.value = true;
    var language = await _maincontroller.getstoragedat('language');
    var url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$place_id&key=$mapsApiKey&language=$language";
    var response = await GetAndPost.fetcOtherhData(url, context, {});
    if (response['status'] == "OK") {
      refreshpage.value = false;
      editingcontroller.value.text = response['result']['formatted_address'];
      editingcontroller.value = TextEditingController();
      searchinglocations.value = [];

      goinglocations.value.add(UserLocations(
        id: 1,
        coordinates: Coordinates(
            latitude: response['result']['geometry']['location']['lat'],
            longitude: response['result']['geometry']['location']['lng']),
        name: Name(
            azName: response['result']['formatted_address'],
            ruName: response['result']['formatted_address'],
            enName: response['result']['formatted_address'],
            trName: response['result']['formatted_address']),
        status: true,
        type: inptype.value == "from" ? "first" : 'second',
      ));

      if (goinglocations.value.length == 2) {
        createroute(context);
      } else {
        openmodal.value = false;
        refreshpage.value = false;
        LatLngBounds latLngBounds;
        LatLng latlng = LatLng(
            response['result']['geometry']['location']['lat'],
            response['result']['geometry']['location']['lng']);

        latLngBounds = LatLngBounds(southwest: latlng, northeast: latlng);
        markers.value.add(Marker(
          markerId: MarkerId("pickup"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(
              title: getLocalizedValue(
                  goinglocations.where((p0) => p0.type == "first").first.name,
                  'name'),
              snippet: 'mylocation'.tr),
          position: latlng,
          onDragEnd: ((value) => print(value)),
          onDrag: (value) => print(value),
          onDragStart: (value)=>print(value)
        ));

        circles.value.add(Circle(
          circleId: CircleId("pickup"),
          fillColor: secondarycolor,
          center: latlng,
          radius: 12,
          strokeWidth: 4,
          strokeColor: secondarycolor,
        ));

        newgooglemapcontroller.value!
            .animateCamera(CameraUpdate.newLatLng(latlng));
      }
    } else {
      refreshpage.value = false;
    }
  }

  void selectplace(index) {
    selectedplace.value = 0;
    selectedplace.value = index;
    if (index == 1) {
      Get.bottomSheet(Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            Devider(),
            StaticText(
              color: secondarycolor,
              size: buttontextSize,
              text: "pleaseselectplaceandclick".tr,
              weight: FontWeight.w500,
              align: TextAlign.center,
            ),
            Devider(),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: Get.width - 40,
                  child: ImageClass(
                    type: false,
                    boxfit: BoxFit.contain,
                    url: "./assets/images/places.png",
                  ),
                ),
              ),
            ),
            Devider(),
            ButtonElement(
              text: "choise".tr,
              width: 90,
              onPressed: () => Get.back(),
              bgColor: primarycolor,
              borderRadius: BorderRadius.circular(45),
              fontsize: normaltextSize,
              height: 45,
              textColor: whitecolor,
            ),
            Devider(),
          ],
        ),
      ));
    }
  }

  void createroute(context) async {
    openmodal.value = false;
    refreshpage.value = true;
    var url =
        "https://maps.googleapis.com/maps/api/directions/json?key=$mapsApiKey";
    LatLng? originCoordinates, destinationCoordinates;
    for (var location in goinglocations.value) {
      if (location.type == "first") {
        originCoordinates = LatLng(location.coordinates!.latitude as double,
            location.coordinates!.longitude as double);
      } else {
        destinationCoordinates = LatLng(
            location.coordinates!.latitude as double,
            location.coordinates!.longitude as double);
      }
    }

    if (originCoordinates != null && destinationCoordinates != null) {
      url = url +
          "&origin=${originCoordinates.latitude},${originCoordinates.longitude}&destination=${destinationCoordinates.latitude},${destinationCoordinates.longitude}";
    } else {
      showToastMSG(errorcolor, "pleaseselectplaceandclick".tr, context);
    }

    var response = await GetAndPost.fetcOtherhData(url, context, {});
    if (response['status'] == "OK") {
      directiondetails.value = DistanceDetails(
        encodedPoints: response['routes'][0]['overview_polyline']['points'],
        distanceText: response['routes'][0]['legs'][0]['distance']['text'],
        distanceValue: response['routes'][0]['legs'][0]['distance']['value'],
        durationText: response['routes'][0]['legs'][0]['duration']['text'],
        durationValue: response['routes'][0]['legs'][0]['duration']['value'],
      );
      latlngs.clear();

      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> pointslatlang = polylinePoints
          .decodePolyline(response['routes'][0]['overview_polyline']['points']);
      if (pointslatlang.isNotEmpty) {
        pointslatlang.forEach((PointLatLng element) {
          latlngs.add(LatLng(element.latitude, element.longitude));
        });
      }

      polyline.clear();
      Polyline polylinenew = Polyline(
          polylineId: PolylineId("token"),
          color: primarycolor,
          points: latlngs.value,
          jointType: JointType.mitered,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      polyline.add(polylinenew);

      LatLngBounds latLngBounds;
      if (originCoordinates!.latitude > destinationCoordinates!.latitude &&
          originCoordinates.longitude > destinationCoordinates.longitude) {
        latLngBounds = LatLngBounds(
            southwest: destinationCoordinates, northeast: originCoordinates);
      } else if (originCoordinates!.longitude >
          destinationCoordinates!.longitude) {
        latLngBounds = LatLngBounds(
            southwest: LatLng(
                originCoordinates.latitude, destinationCoordinates.longitude),
            northeast: LatLng(
                destinationCoordinates.latitude, originCoordinates.longitude));
      } else if (originCoordinates.latitude > destinationCoordinates.latitude) {
        latLngBounds = LatLngBounds(
            southwest: LatLng(
                destinationCoordinates.latitude, originCoordinates.longitude),
            northeast: LatLng(
                originCoordinates.latitude, destinationCoordinates.longitude));
      } else {
        latLngBounds = LatLngBounds(
            southwest: originCoordinates, northeast: destinationCoordinates);
      }

      newgooglemapcontroller.value
          ?.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

      markers.clear();
      circles.clear();

      markers.value.add(Marker(
        markerId: MarkerId("pickup"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(
            title: getLocalizedValue(goinglocations[0].name, 'name'),
            snippet: 'mylocation'.tr),
        position: originCoordinates,
        onDragEnd: ((value) => print(value)),
          onDrag: (value) => print(value),
          onDragStart: (value)=>print(value)
      ));
      markers.value.add(Marker(
        markerId: MarkerId("destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
            title: getLocalizedValue(goinglocations[1].name, 'name'),
            snippet: 'destinationlocation'.tr),
        position: destinationCoordinates,
        onDragEnd: ((value) => print(value)),
          onDrag: (value) => print(value),
          onDragStart: (value)=>print(value)
      ));
      circles.value.add(Circle(
        circleId: CircleId("pickup"),
        fillColor: secondarycolor,
        center: originCoordinates,
        radius: 12,
        strokeWidth: 4,
        strokeColor: secondarycolor,
      ));

      circles.value.add(Circle(
        circleId: CircleId("destination"),
        fillColor: errorcolor,
        center: destinationCoordinates,
        radius: 12,
        strokeWidth: 4,
        strokeColor: errorcolor,
      ));
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
    }
  }

  void togglesearch(String type, context) {
    if (type == "onmap") {
      openmodal.value = true;
    }
    loading.value = !loading.value;
  }

  void fetchdata() {
    data.add('asb');
  }

  void lookmore(index, context) {
    Get.bottomSheet(Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Devider(),
          StaticText(
            color: secondarycolor,
            size: buttontextSize,
            text: "informationforride".tr,
            weight: FontWeight.w500,
            align: TextAlign.center,
          ),
          Devider(),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Devider(),
              SizedBox(
                width: Get.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed('/profiledriver/eyvaz-ceferov'),
                      child: CircleAvatar(
                        backgroundColor: primarycolor,
                        foregroundColor: whitecolor,
                        radius: 25,
                        backgroundImage: NetworkImage(
                            "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => Get.toNamed('/profiledriver/eyvaz-ceferov'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StaticText(
                                  text: "Eyvaz Ceferov",
                                  weight: FontWeight.w600,
                                  size: normaltextSize,
                                  color: darkcolor),
                              SizedBox(width: 4),
                              Icon(
                                FeatherIcons.star,
                                color: Colors.yellow,
                                size: normaltextSize,
                              ),
                              StaticText(
                                  text: "4",
                                  weight: FontWeight.w500,
                                  size: smalltextSize,
                                  color: iconcolor),
                            ],
                          ),
                          SizedBox(
                            width: Get.width / 3,
                            child: StaticText(
                                align: TextAlign.left,
                                maxline: 2,
                                textOverflow: TextOverflow.clip,
                                text: "Ağ Volkswagen CC - 99-DD-556",
                                weight: FontWeight.w500,
                                size: smalltextSize,
                                color: iconcolor),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => callpageredirect('call', context),
                            style: ElevatedButton.styleFrom(
                              primary: primarycolor,
                              onPrimary: whitecolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Icon(FeatherIcons.phoneCall,
                                color: whitecolor, size: normaltextSize),
                          ),
                        ),
                        SizedBox(width: 3),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed("/messages/1"),
                            style: ElevatedButton.styleFrom(
                              primary: primarycolor,
                              onPrimary: whitecolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Icon(FeatherIcons.messageCircle,
                                color: whitecolor, size: normaltextSize),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Devider(),
            ],
          )),
          Devider(),
          Center(
            child: GestureDetector(
              onTap: () => changemethod(context),
              child: Container(
                width: Get.width - 40,
                height: 70,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffECECEC),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 15),
                    Container(
                      width: 60,
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: ImageClass(
                        type: false,
                        boxfit: BoxFit.contain,
                        url: "./assets/images/money.png",
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          text: "changepaymentmethod".tr,
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Icon(FeatherIcons.chevronRight,
                        color: iconcolor, size: buttontextSize),
                  ],
                ),
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
                onPressed: () => Get.back(),
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
                text: "reguestnow".tr,
                width: 160,
                onPressed: () => Get.back(),
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
    ));
  }

  void callpageredirect(type, context) async {
    // try {
    //   if (type == "video") {
    //     _handlecameraandmic(Permission.camera, context);
    //   } else {
    //     print("calling");
    //   }

    //   _handlecameraandmic(Permission.microphone, context);

    //   Get.toNamed('/callpage/${type}', arguments: {type: type});
    // } catch (error) {
    //   showToastMSG(errorcolor, error, context);
    // }
  }

  void changemethod(context) {
    final CardsController cardscontroller = Get.put(CardsController());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: StaticText(
            color: darkcolor,
            size: normaltextSize,
            weight: FontWeight.w500,
            align: TextAlign.center,
            textOverflow: TextOverflow.ellipsis,
            maxline: 1,
            text: "changepaymentmethod".tr,
          ),
          content: Obx(
            () => SizedBox(
              width: Get.width,
              height: Get.width / 2,
              child: ListView.builder(
                itemCount: cardscontroller.data.length,
                itemBuilder: (context, index) {
                  final item = cardscontroller.data[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.ccVisa,
                            color: secondarycolor,
                            size: headingSize,
                            textDirection: TextDirection.ltr),
                        title: StaticText(
                          color: darkcolor,
                          size: normaltextSize,
                          text: "***0049",
                          weight: FontWeight.w500,
                          align: TextAlign.left,
                        ),
                        trailing: Radio<bool>(
                          value: true,
                          groupValue: item.selected,
                          activeColor: primarycolor,
                          focusColor: primarycolor,
                          hoverColor: primarycolor,
                          toggleable: true,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          onChanged: (value) {
                            cardscontroller.updateSelection(
                                index, true, context);
                          },
                        ),
                      ),
                      Devider(),
                    ],
                  );
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: StaticText(
                color: secondarycolor,
                size: normaltextSize,
                weight: FontWeight.w500,
                align: TextAlign.right,
                textOverflow: TextOverflow.ellipsis,
                maxline: 1,
                text: "submit".tr,
              ),
            ),
          ],
        );
      },
    );
  }

  void selectplacing() {}

  Future<void> fetchlocations(context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response = await GetAndPost.fetchData("locations", context, body);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        userlocations.value = (response['data'] as List).map((dat) {
          var data = UserLocations.fromMap(dat);
          return data;
        }).toList();
      } else {
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      data.value = [];
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }

  void createorselectlocation(String type) {
    if (userlocations.value != null) {
    } else {
      //create
    }
  }

  String? gettypeoflocationaddress(String type) {
    if (userlocations.value != null) {
      for (UserLocations location in userlocations.value) {
        if (location.type == type) {
          return getLocalizedValue(location.name, 'name');
          break;
        }
      }
    } else {
      return null;
    }
  }
}
