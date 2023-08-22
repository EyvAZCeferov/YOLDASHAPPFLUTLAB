import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldashapp/Controllers/AutomobilsController.dart';
import 'package:yoldashapp/models/distancedetails.dart';
import 'package:yoldashapp/models/rides.dart';
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
import 'MessagesController.dart';

class GoingController extends GetxController {
  late MainController _maincontroller = Get.put(MainController());
  late MessagesController _messagescontroller = Get.put(MessagesController());
  late AutomobilsController _automobilscontroller =
      Get.put(AutomobilsController());
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
  Rx<bool> openmodal = Rx<bool>(false);
  final data = [].obs;
  Rx<bool> addedsectionshow = Rx<bool>(false);
  Rx<bool> loading = Rx<bool>(false);
  final selectedindex = 0.obs;
  final Rx<DateTime> selectedTime = DateTime.now().obs;
  final selectedplace = 0.obs;
  RxList<UserLocations> userlocations = <UserLocations>[].obs;
  final Completer<GoogleMapController> googlemapcontroller = Completer();
  Rx<GoogleMapController?> newgooglemapcontroller =
      Rx<GoogleMapController?>(null);
  Rx<Position?> currentposition = Rx<Position?>(null);
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
  Rx<String> authtype = Rx<String>('rider');
  Rx<int?> auth_id = Rx<int?>(null);

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(40.409264, 49.867092),
    zoom: 14.4746,
  );

  GoingController() {
    getAuthId();
  }

  void getAuthId() async {
    auth_id.value = await _maincontroller.getstoragedat('auth_id');
    authtype.value = await _maincontroller.getstoragedat('authtype');
  }

  void getcurrentposition(context) async {
    refreshpage.value = true;
    await handlepermissionreq(Permission.location, context);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    currentposition.value = position;
    LatLng latLngPos = LatLng(position.latitude, position.longitude);
    CameraPosition cameraposition =
        new CameraPosition(target: latLngPos, zoom: 14);
    String language = await _maincontroller.getstoragedat('language');

    kGooglePlex = cameraposition;
    Map gettednameandplace_id = await getnameviacoords(
        position.latitude, position.longitude, language, context);
    UserLocations userlocation = await addlocationtodb(
        gettednameandplace_id['nameaddress'] as String,
        gettednameandplace_id['place_id'] as String,
        latLngPos as LatLng,
        'currentposition' as String,
        context as BuildContext);
    fetchlocations(context);
    refreshpage.value = false;

    newgooglemapcontroller.value
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
    if (gettednameandplace_id['nameaddress'] != null &&
        gettednameandplace_id['nameaddress'] != ' ' &&
        gettednameandplace_id['nameaddress'] != '' &&
        userlocation != null) {
      fromcontroller.value.text =
          getLocalizedValue(userlocation.name, 'name') as String;

      goinglocations.value.add(userlocation);

      markers.value.add(Marker(
          markerId: MarkerId(userlocation.type as String),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(
            title: getLocalizedValue(userlocation.name, 'name'),
            snippet: 'mylocation'.tr,
          ),
          position: LatLng(userlocation.coordinates!.latitude!.toDouble(),
              userlocation.coordinates!.longitude!.toDouble()),
          draggable: true,
          onDragEnd: ((value) => print(value)),
          onDrag: (value) => print(value),
          onDragStart: (value) => print(value)));
      circles.value.add(Circle(
        circleId: CircleId(userlocation.type as String),
        fillColor: secondarycolor,
        center: LatLng(userlocation.coordinates!.latitude!.toDouble(),
            userlocation.coordinates!.longitude!.toDouble()),
        radius: 15,
        strokeWidth: 4,
        strokeColor: secondarycolor,
      ));
    }
  }

  void addsections() {
    addedsectionshow.value = !addedsectionshow.value;
  }

  Future<UserLocations> addlocationtodb(String nameaddress, String place_id,
      LatLng latlng, String type, BuildContext context) async {
    try {
      var body = {
        'auth_id': auth_id.value,
        'place_id': place_id,
        'name': nameaddress,
        'latitude': latlng.latitude,
        'longitude': latlng.longitude,
        'type': type,
      };
      var response = await GetAndPost.postData("locations", body, context);

      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          UserLocations userlocation = UserLocations(
              id: 1,
              userId: auth_id.value as int,
              coordinates: Coordinates(
                  latitude: latlng.latitude, longitude: latlng.longitude),
              name: Name.fromMap(response['data']['name']),
              status: true,
              type: response['data']['type']);
          return userlocation;
        } else {
          return UserLocations();
        }
      } else {
        return UserLocations();
      }
    } catch (e) {
      print(e.toString());
      return UserLocations();
    }
  }

  Future<Map> getnameviacoords(double latitude, double longitude,
      String language, BuildContext context) async {
    var response = await GetAndPost.fetcOtherhData(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$mapsApiKey&language=$language',
        context, {});
    Map data = {};
    if (response != null) {
      data['nameaddress'] = response['results'][0]["address_components"][3]
              ['long_name'] +
          ", " +
          response['results'][0]["address_components"][2]['long_name'] +
          ", " +
          response['results'][0]["address_components"][1]['long_name'];

      data['place_id'] = response['results'][0]['place_id'];
      return data;
    } else {
      return data;
    }
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
      var language = await _maincontroller.getstoragedat('language');
      searchinglocations.value = userlocations.value
          .where(
              (element) => element.type == 'recent' || element.type == 'others')
          .map((element) => SearchingLocations(
                secondary_text: '' as String,
                main_text: getLocalizedValue(element.name, 'name') as String,
                place_id: element.placeId,
              ))
          .toList();

      var url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&location=40.409264%2C-49.867092&key=$mapsApiKey&components=country:az&language=$language";
      var response = await GetAndPost.fetcOtherhData(url, context, {});
      if (response['status'] == "OK") {
        List<SearchingLocations> listelements =
            (response['predictions'] as List)
                .map((e) => SearchingLocations.fromJson(e))
                .cast<SearchingLocations>()
                .toList();
        searchinglocations.value = listelements;
        editingcontroller.value = controller;
        inptype.value = type;
      }
    } else {
      searchinglocations.value = [];
    }
  }

  void selectsearchedloc(String place_id, BuildContext context) async {
    if (place_id != null) {
      refreshpage.value = true;
      var language = await _maincontroller.getstoragedat('language');
      var url =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$place_id&key=$mapsApiKey&language=$language";
      var response = await GetAndPost.fetcOtherhData(url, context, {});
      if (response['status'] == "OK") {
        editingcontroller.value.text = response['result']['formatted_address'];
        editingcontroller.value = TextEditingController();
        searchinglocations.value = [];
        UserLocations userlocation = await addlocationtodb(
            response['result']['formatted_address'],
            place_id,
            LatLng(response['result']['geometry']['location']['lat'],
                response['result']['geometry']['location']['lng']),
            inptype.value,
            context);
        if (goinglocations.value.length > 0) {
          goinglocations.value
              .removeWhere((element) => element.type == inptype.value);
        }
        goinglocations.value.add(userlocation);

        if (markers.value.length > 0) {
          markers.value.removeWhere((marker) =>
              marker?.markerId.value == userlocation.type as String);
        }

        if (circles.value.length > 0) {
          circles.value.removeWhere((circle) =>
              circle?.circleId.value == userlocation.type as String);
        }

        markers.value.add(Marker(
            markerId: MarkerId(userlocation.type as String),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                userlocation.type == "currentposition"
                    ? BitmapDescriptor.hueAzure
                    : BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: getLocalizedValue(userlocation.name, 'name'),
              snippet: 'mylocation'.tr,
            ),
            position: LatLng(userlocation.coordinates!.latitude!.toDouble(),
                userlocation.coordinates!.longitude!.toDouble()),
            draggable: true,
            onDragEnd: ((value) => print(value)),
            onDrag: (value) => print(value),
            onDragStart: (value) => print(value)));
        circles.value.add(Circle(
          circleId: CircleId(userlocation.type as String),
          fillColor: secondarycolor,
          center: LatLng(userlocation.coordinates!.latitude!.toDouble(),
              userlocation.coordinates!.longitude!.toDouble()),
          radius: 15,
          strokeWidth: 4,
          strokeColor: userlocation.type == "currentposition"
              ? secondarycolor
              : errorcolor,
        ));

        if (goinglocations.value.length == 2) {
          createroute(context);
        } else {
          refreshpage.value = false;
          openmodal.value = false;
          CameraPosition cameraposition = new CameraPosition(
              target: LatLng(response['result']['geometry']['location']['lat'],
                  response['result']['geometry']['location']['lng']),
              zoom: 14);
          kGooglePlex = cameraposition;
          newgooglemapcontroller.value
              ?.animateCamera(cameraposition as CameraUpdate);
        }
      } else {
        refreshpage.value = false;
      }
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
    var language = await _maincontroller.getstoragedat('language');
    var url =
        "https://maps.googleapis.com/maps/api/directions/json?key=$mapsApiKey&language=$language";
    LatLng? originCoordinates, destinationCoordinates;

    for (var location in goinglocations.value) {
      if (location.type == "currentposition") {
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
      print(response['routes'][0]['legs'][0]['duration']['text']);
      print(response['routes'][0]['legs'][0]['duration']['value']);
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
          polylineId: PolylineId("current_destination"),
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

      if (latLngBounds.contains(originCoordinates!) &&
          latLngBounds.contains(destinationCoordinates!)) {
        newgooglemapcontroller.value
            ?.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
      } else {
        newgooglemapcontroller.value?.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(
                (originCoordinates.latitude + destinationCoordinates.latitude) /
                    2,
                (originCoordinates.longitude +
                        destinationCoordinates.longitude) /
                    2),
            10));
      }

      refreshpage.value = false;
    } else {
      refreshpage.value = false;
    }
  }

  void togglesearch(String type, context) async {
    try {
      if (type == "onmap") {
        openmodal.value = true;
      }

      var nextprocess = false;

      if (authtype.value == "driver") {
        _automobilscontroller.fetchDatas(context);
        if (_automobilscontroller.data.length == 0) {
          nextprocess = false;
          showToastMSG(errorcolor, "add_automobil".tr, context);
          Get.toNamed('/automobils');
        } else {
          nextprocess = true;
        }
      } else {
        nextprocess = true;
      }

      if (nextprocess == true) {
        refreshpage.value = true;

        var body = {
          'auth_id': auth_id.value,
          'latitudefrom': markers.value
              .firstWhere(
                  (element) => element?.markerId.value == "currentposition")!
              .position!
              .latitude
              .toString(),
          'longitudefrom': markers.value
              .firstWhere(
                  (element) => element?.markerId.value == "currentposition")!
              .position!
              .longitude
              .toString(),
          "wayfrom": markers.value
              .firstWhere(
                  (element) => element?.markerId.value == "currentposition")!
              .infoWindow
              .title,
          'latitudeto': markers.value
              .firstWhere((element) =>
                  element?.markerId.value != "destinationposition")!
              .position!
              .latitude
              .toString(),
          'longitudeto': markers.value
              .firstWhere((element) =>
                  element?.markerId.value != "destinationposition")!
              .position!
              .longitude
              .toString(),
          "wayto": markers.value
              .firstWhere((element) =>
                  element?.markerId.value == "destinationposition")!
              .infoWindow
              .title,
          'start_time': selectedTime.value.toString() ?? null,
          'kmofway': directiondetails.value!.distanceValue ?? 0,
          'minimal_price_of_way':
              minimumpriceofwaycontroller.value.text != null &&
                      minimumpriceofwaycontroller.value.text != '' &&
                      minimumpriceofwaycontroller.value.text != ' '
                  ? minimumpriceofwaycontroller.value.text
                  : 0,
          'price_of_way': priceofwaycontroller.value.text != null &&
                  priceofwaycontroller.value.text != '' &&
                  priceofwaycontroller.value.text != ' '
              ? priceofwaycontroller.value.text
              : 0,
          'payment_method': 'nagd',
          'status': 'waiting',
          'weight': weightcontroller.value.text != null &&
                  weightcontroller.value.text != '' &&
                  weightcontroller.value.text != ' '
              ? weightcontroller.value.text
              : 0,
          'place_id': null,
        };
        var response = await GetAndPost.postData("rides", body, context);
        if (response != null) {
          String status = response['status'];
          String message = "";
          if (response['message'] != null) message = response['message'];
          if (status == "success") {
            data.value = (response['data'] as List).map((dat) {
              return Rides.fromMap(dat);
            }).toList();

            print(data.value);
            refreshpage.value = false;
          } else {
            refreshpage.value = false;
          }
        } else {
          refreshpage.value = false;
        }

        loading.value = !loading.value;
      }
    } catch (e) {
      refreshpage.value = false;
      showToastMSG(errorcolor, e.toString(), context);
      print(e.toString());
    }
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
                            onPressed: () =>
                                _messagescontroller.callpageredirect(
                                    'call',
                                    authtype == 'rider'
                                        ? _messagescontroller
                                                .selectedMessageGroup
                                                .value!
                                                .receiverImage ??
                                            null
                                        : _messagescontroller
                                                .selectedMessageGroup
                                                .value!
                                                .senderImage ??
                                            null,
                                    context),
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

  void changemethod(context) {
    final CardsController cardscontroller = Get.put(CardsController());
    cardscontroller.fetchDatas(context);
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
