import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldashapp/Controllers/AuthController.dart';
import 'package:yoldashapp/Controllers/AutomobilsController.dart';
import 'package:yoldashapp/models/distancedetails.dart';
import 'package:yoldashapp/models/rides.dart';
import 'package:yoldashapp/models/searchionglocations.dart';
import '../Constants/ButtonElement.dart';
import '../Constants/Devider.dart';
import '../Constants/ImageClass.dart';
import '../Constants/InputElement.dart';
import '../Constants/StaticText.dart';
import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../models/automobils.dart';
import '../models/user_locations.dart';
import 'CardsController.dart';
import 'MainController.dart';
import 'MessagesController.dart';

class GoingController extends GetxController {
  late MainController _maincontroller = Get.put(MainController());
  late MessagesController _messagescontroller = Get.put(MessagesController());
  late AuthController _authController = Get.put(AuthController());
  late AutomobilsController _automobilscontroller =
      Get.put(AutomobilsController());
  Rx<bool> refreshpage = Rx<bool>(false);
  RxList<TextEditingController> textEditingControllers =
      RxList<TextEditingController>([]);
  RxMap<String, dynamic> addresscontrollers = RxMap<String, dynamic>({});
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
  final Rx<DateTime> fromTime = DateTime.now().obs;
  final Rx<DateTime> toTime = DateTime.now().add(Duration(days: 30)).obs;
  final Rx<DateTime> fromTimeSelectable = DateTime.now().obs;
  final Rx<DateTime> toTimeSelectable =
      DateTime.now().add(Duration(days: 30)).obs;
  Rx<int> selectedplace = Rx<int>(0);
  RxList<UserLocations> userlocations = <UserLocations>[].obs;
  final Completer<GoogleMapController> googlemapcontroller = Completer();
  Rx<GoogleMapController?> newgooglemapcontroller =
      Rx<GoogleMapController?>(null);
  Rx<Position?> position_0 = Rx<Position?>(null);
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
  Rx<LatLng?> latLngPos = Rx<LatLng?>(null);
  RxMap? mapped = RxMap();
  Rx<String?> resulttext = Rx<String?>(null);
  RxList<Rides> currentrides = <Rides>[].obs;
  late CardsController cardscontroller = Get.put(CardsController());
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(40.409264, 49.867092),
    zoom: 14.4746,
  );

  GoingController() {
    getAuthId();
    addorremoveeditingcontroller(0, 'add');
    addorremoveeditingcontroller(1, 'add');
  }

  void addorremoveeditingcontroller(int? index, String? type) {
    refreshpage.value = true;
    if (type == "delete" && index != null) {
      addresscontrollers.value.remove('position_$index');
    } else {
      if (addresscontrollers.value['position_$index'] == null) {
        addresscontrollers.value['position_$index'] = TextEditingController();
      }
    }
    // Future.delayed(Duration(seconds: 2),(){
    refreshpage.value = false;
    // });
  }

  @override
  void onClose() {
    for (var controller in textEditingControllers.value) {
      controller.dispose();
    }
    super.onClose();
  }

  void getAuthId() async {
    auth_id.value = await _maincontroller.getstoragedat('auth_id') ?? '';
    authtype.value = await _maincontroller.getstoragedat('authtype') ?? '';
  }

  void getcurrentposition(context) async {
    try {
      refreshpage.value = true;
      var statuslocation =
          await handlepermissionreq(Permission.location, context);

      if (statuslocation.isDenied) {
        statuslocation =
            await handlepermissionreq(Permission.location, context);
      }

      getcurrentrides(context);

      cardscontroller.fetchDatas(context);

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true);
      position_0.value = position;
      LatLng latLngPosn = LatLng(position.latitude, position.longitude);
      CameraPosition cameraposition =
          new CameraPosition(target: latLngPosn, zoom: 14);
      String language = await _maincontroller.getstoragedat('language');

      if (authtype.value == "driver") {
        _automobilscontroller.fetchDatas(context);
        addedsectionshow.value = true;
      }

      kGooglePlex = cameraposition;
      Map gettednameandplace_id = await getnameviacoords(
          position.latitude, position.longitude, language, context);
      UserLocations userlocation = await addlocationtodb(
          gettednameandplace_id['nameaddress'] as String,
          gettednameandplace_id['place_id'] as String,
          latLngPosn as LatLng,
          'position_0' as String,
          context as BuildContext);
      await fetchlocations(context);

      newgooglemapcontroller.value
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraposition));

      refreshpage.value = false;
      if (gettednameandplace_id['nameaddress'] != null &&
          gettednameandplace_id['nameaddress'] != ' ' &&
          gettednameandplace_id['nameaddress'] != '' &&
          userlocation != null) {
        if (addresscontrollers.value.containsKey('position_0')) {
          addresscontrollers.value['position_0'].text =
              getLocalizedValue(userlocation.name, 'name') as String;
        }

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
          onDragEnd: (LatLng latlng) =>
              dragortappedmarker(userlocation.type as String, latlng, context),
        ));
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
    } catch (e) {
      print(
          "--------------------------------------------------Init ERROR-------------------------------------");
      print(e.toString());
    }
  }

  void addsections() {
    addedsectionshow.value = !addedsectionshow.value;
  }

  Future<UserLocations> addlocationtodb(String nameaddress, String place_id,
      LatLng latlng, String type, BuildContext context) async {
    try {
      var body = {
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
          UserLocations userlocation = UserLocations.fromMap(response['data']);
          return userlocation;
        } else {
          return UserLocations();
        }
      } else {
        return UserLocations();
      }
    } catch (e) {
      print(
          "-----------------------------ADD LOCATIONS TO DB ERROR : ------------------------------ ${e.toString()}");
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

  void changeindex(index, BuildContext context) {
    selectedindex.value = 0;
    selectedindex.value = index;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 1000,
            color: Colors.white,
            child: SingleChildScrollView(
              controller: ScrollController(),
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
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
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StaticText(
                            text: "choisestarttime".tr,
                            weight: FontWeight.w600,
                            size: normaltextSize,
                            color: darkcolor,
                            align: TextAlign.center,
                            textOverflow: TextOverflow.ellipsis),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 250,
                          width: Get.width - 50,
                          child: CupertinoDatePicker(
                            use24hFormat: true,
                            minimumDate: fromTime.value,
                            mode: CupertinoDatePickerMode.dateAndTime,
                            backgroundColor: bodycolor,
                            maximumDate: fromTime.value.add(Duration(days: 30)),
                            initialDateTime: fromTime.value,
                            onDateTimeChanged: (DateTime newDate) {
                              fromTimeSelectable.value = newDate;
                            },
                          ),
                        ),
                        authtype.value == "rider"
                            ? StaticText(
                                text: "choiseendtime".tr,
                                weight: FontWeight.w600,
                                size: normaltextSize,
                                color: darkcolor,
                                align: TextAlign.center,
                                textOverflow: TextOverflow.ellipsis)
                            : SizedBox(),
                        authtype.value == "rider"
                            ? SizedBox(
                                height: 10,
                              )
                            : SizedBox(),
                        authtype.value == "rider"
                            ? SizedBox(
                                height: 250,
                                width: Get.width - 50,
                                child: CupertinoDatePicker(
                                  use24hFormat: true,
                                  minimumDate: fromTime.value,
                                  mode: CupertinoDatePickerMode.dateAndTime,
                                  backgroundColor: bodycolor,
                                  maximumDate:
                                      toTime.value.add(Duration(days: 30)),
                                  initialDateTime: toTime.value,
                                  onDateTimeChanged: (DateTime newDate) {
                                    toTimeSelectable.value = newDate;
                                  },
                                ),
                              )
                            : SizedBox(),
                      ],
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
            ),
          );
        });
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
    try {
      if (place_id != null) {
        refreshpage.value = true;
        var language = await _maincontroller.getstoragedat('language');
        var url =
            "https://maps.googleapis.com/maps/api/place/details/json?place_id=$place_id&key=$mapsApiKey&language=$language";
        var response = await GetAndPost.fetcOtherhData(url, context, {});
        if (response['status'] == "OK") {
          editingcontroller.value.text =
              response['result']['formatted_address'];
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
            onDragEnd: (LatLng latlng) => dragortappedmarker(
                userlocation.type as String, latlng, context),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                userlocation.type == "position_0"
                    ? BitmapDescriptor.hueAzure
                    : BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: getLocalizedValue(userlocation.name, 'name'),
              snippet: 'mylocation'.tr,
            ),
            position: LatLng(userlocation.coordinates!.latitude!.toDouble(),
                userlocation.coordinates!.longitude!.toDouble()),
            draggable: true,
          ));

          circles.value.add(Circle(
            circleId: CircleId(userlocation.type as String),
            fillColor: secondarycolor,
            center: LatLng(userlocation.coordinates!.latitude!.toDouble(),
                userlocation.coordinates!.longitude!.toDouble()),
            radius: 15,
            strokeWidth: 4,
            strokeColor:
                userlocation.type == "position_0" ? secondarycolor : errorcolor,
          ));

          if (goinglocations.value.length >= 2) {
            createroute(context);
          } else {
            refreshpage.value = false;
            openmodal.value = false;
            CameraPosition cameraposition = new CameraPosition(
                target: LatLng(
                    response['result']['geometry']['location']['lat'],
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
    } catch (e) {
      print(e.toString());
    }
  }

  int getplacenullorfull(List<Queries>? queries, PlacesMark place, context) {
    try {
      if (queries != null && queries.length > 0) {
        Queries? query = queries.firstWhere(
            (element) => element.position == place.id,
            orElse: () => Queries());

        if (query != null) {
          return query.rider!.additionalinfo!.gender!;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  void selectplace(index, List places, Rides ride, BuildContext context) {
    selectedindex.value = index;
    if (index == 1) {
      priceofwaycontroller.value.text =
          ride.minimalPriceOfWay ?? ride.priceOfWay;
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
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
                        ride,
                        ride.queries as List<Queries>,
                        places as List<PlacesMark>,
                        context as BuildContext),
                  ),
                  Devider(
                    size: 25,
                  ),
                ],
              ),
            );
          });
    } else {
      selectedplace.value = 0;
      priceofwaycontroller.value.text = ride.priceOfWay ?? 0;
      Get.back();
      lookmore(ride, context);
    }
  }

  List<Widget> groupAndSortPlaces(
      Rides ride, List<Queries>? queries, List<PlacesMark> places, context) {
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
        var getplaceinfo = getplacenullorfull(queries, place, context);

        if (place.type == "driver") {
          imageUrl = './assets/images/place_driver.png';
        } else {
          if (getplaceinfo != 0 && getplaceinfo == 1) {
            imageUrl = './assets/images/place_man.png';
          } else if (getplaceinfo != 0 && getplaceinfo == 2) {
            imageUrl = './assets/images/place_woman.png';
          } else {
            imageUrl = './assets/images/place_rider.png';
          }
        }

        return GestureDetector(
          onTap: () {
            selectedindex.value = 1;
            if (place.type == "driver") {
              showToastMSG(errorcolor, "youarenotselectingdriver".tr, context);
            } else {
              refreshpage.value = true;
              selectedplace.value = place.id!;
              refreshpage.value = false;
              showToastMSG(
                  primarycolor,
                  "youarenotselectingdriver".trParams({
                    "rider":
                        getLocalizedValue(place.name as Name, "name").toString()
                  }),
                  context);
              Get.back();
              Get.back();
              lookmore(ride, context);
            }
          },
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: ImageClass(
              url: selectedplace.value != 0 && selectedplace.value == place.id
                  ? _authController.userdatas.value?.additionalinfo?.gender == 1
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

  void createroute(context) async {
    openmodal.value = false;
    refreshpage.value = true;
    var language = await _maincontroller.getstoragedat('language');
    var url =
        "https://maps.googleapis.com/maps/api/directions/json?key=$mapsApiKey&language=$language";
    List<LatLng>? destinations;

    for (var location in goinglocations.value) {
      LatLng destination = LatLng(
        location.coordinates!.latitude as double,
        location.coordinates!.longitude as double,
      );

      if (destinations == null) {
        destinations = [destination];
      } else {
        destinations.add(destination);
      }
    }
    if (destinations != null && destinations.length > 1) {
      var origin = destinations.first;
      var destination = destinations.last;

      url = url +
          "&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}";

      for (var i = 1; i < destinations.length - 1; i++) {
        var waypoint = destinations[i];
        url = url + "&waypoints=${waypoint.latitude},${waypoint.longitude}";
      }
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
          polylineId: PolylineId("current_destination"),
          color: primarycolor,
          points: latlngs.value,
          jointType: JointType.mitered,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      polyline.add(polylinenew);

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
        if (_automobilscontroller.data.value.length == 0) {
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

        List<LatLng> points = [];

        polyline.forEach((polyline) {
          if (polyline != null) {
            polyline.points.forEach((element) {
              points.add(element);
            });
          }
        });

        var body = {
          "coordinates": <Map<String, dynamic>>[],
          'start_time': fromTimeSelectable.value.toString() ?? null,
          'end_time': toTimeSelectable.value.toString() ?? null,
          'kmofway': directiondetails.value!.distanceValue ?? 0,
          'durationofway': directiondetails.value!.durationValue ?? 0,
          "polyline_points": points,
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
          'payment_method': cardscontroller.selectedCards.value!.id == null ||
                  cardscontroller.selectedCards.value!.id == 0
              ? 'nagd'
              : 'card',
          'payment_card': cardscontroller.selectedCards.value!.id == null ||
                  cardscontroller.selectedCards.value!.id == 0
              ? null
              : cardscontroller.selectedCards.value!.id,
          'status': 'waiting',
          'weight': weightcontroller.value.text != null &&
                  weightcontroller.value.text != '' &&
                  weightcontroller.value.text != ' '
              ? weightcontroller.value.text
              : 0,
          'place_id': null,
        };
        resulttext.value = null;

        List<Map<String, dynamic>> coordinates = [];

        addresscontrollers.value.forEach((key, value) {
          coordinates.add({
            "latitude": markers.value
                .firstWhere((element) => element?.markerId.value == key)!
                .position!
                .latitude
                .toString(),
            "longitude": markers.value
                .firstWhere((element) => element?.markerId.value == key)!
                .position!
                .longitude
                .toString(),
            "address": markers.value
                .firstWhere((element) => element?.markerId.value == key)!
                .infoWindow
                .title,
            "type": key
          });
        });

        body['coordinates'] = coordinates;
        var response = await GetAndPost.postData("rides", body, context);
        if (response != null) {
          String status = response['status'];
          if (status == "success") {
            if (authtype.value == "rider") {
              data.value = [];
              if (response['data'] != null && response['data'].length > 0) {
                data.value = (response['data'] as List).map((dat) {
                  return Rides.fromMap(dat);
                }).toList();

                if (data.value.length == 0) {
                  resulttext.value = "nohasdataforallrides".tr;
                }
              } else {
                resulttext.value = "nohasdataforallrides".tr;
              }
            } else {
              if (type == "onsearch") {
                data.value = [];
                searchinglocations.value = [];
                selectedindex.value = 0;
                weightcontroller.value = TextEditingController();
                priceofwaycontroller.value = TextEditingController();
                addresscontrollers.value.clear();
                addorremoveeditingcontroller(0, "add");
                addorremoveeditingcontroller(1, "add");
                markers.removeWhere(
                    (element) => element?.markerId != "position_0");
                circles.removeWhere(
                    (element) => element?.circleId != "position_0");
                minimumpriceofwaycontroller.value = TextEditingController();
                openmodal.value = false;
                addedsectionshow.value = false;
                loading.value = false;
                fromTimeSelectable.value = DateTime.now();
                toTimeSelectable.value = DateTime.now().add(Duration(days: 30));
                goinglocations
                    .removeWhere((element) => element?.type != "position_0");
                polyline.value = {};
                inptype.value = "position_1";
                mapped?.value = {};
                resulttext.value = null;
                if (response['data'] != null) {
                  currentrides.value.add(Rides.fromMap(response['data']));
                }
                getcurrentposition(context);
                refreshpage.value = true;
                getcurrentrides(context);
              }

              getcurrentrides(context);
            }
            loading.value = false;

            refreshpage.value = false;
          } else {
            resulttext.value = "nohasdataforallrides".tr;
            data.value = [];
            refreshpage.value = false;
            loading.value = false;
          }
        } else {
          refreshpage.value = false;
          loading.value = false;
        }
      }
    } catch (e) {
      refreshpage.value = false;
      showToastMSG(errorcolor, e.toString(), context);
      print(e.toString());
    }
  }

  String getrideCardata(Rides ride) {
    String data = '';
    if (ride.automobil?.color != null &&
        ride.automobil?.color != '' &&
        ride.automobil?.color != ' ') {
      data += ride.automobil!.color! + ' ';
    }

    if (ride.automobil?.marka != null &&
        ride.automobil?.marka != '' &&
        ride.automobil?.marka != ' ') {
      data += ride.automobil!.marka! + ' ';
    }

    if (ride.automobil?.model != null &&
        ride.automobil?.model != '' &&
        ride.automobil?.model != ' ') {
      data += ride.automobil!.model! + ' ';
    }

    if (ride.automobil?.autoSerialNumber != null &&
        ride.automobil?.autoSerialNumber != '' &&
        ride.automobil?.autoSerialNumber != ' ') {
      data += ride.automobil!.autoSerialNumber! + ' ';
    }

    return data;
  }

  void lookmore(Rides ride, BuildContext context) {
    _authController.getalldataoncache(context);
    _automobilscontroller.fetchUserCar(context, ride.userId);
    if (priceofwaycontroller.value.text == null) {
      priceofwaycontroller.value.text =
          ride.minimalPriceOfWay ?? ride.priceOfWay!;
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
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
                      width: Get.width - 30,
                      child: ride.userId != auth_id?.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                  GestureDetector(
                                    onTap: () {
                                      _authController.driverpage.value =
                                          ride.user;
                                      _automobilscontroller.getautomobildata(
                                          ride.automobilId, context);
                                      if (_authController
                                                  .driverpage.value !=
                                              null &&
                                          _authController
                                                  .driverpage.value?.id !=
                                              null &&
                                          _authController
                                                  .driverpage.value?.id !=
                                              0 &&
                                          _authController
                                                  .driverpage.value?.id !=
                                              '' &&
                                          _authController
                                                  .driverpage.value?.id !=
                                              ' ') {
                                        Get.toNamed(
                                            '/profiledriver/${ride.userId}');
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: primarycolor,
                                      foregroundColor: whitecolor,
                                      radius: 25,
                                      backgroundImage: NetworkImage(getimageurl(
                                          "user",
                                          'users',
                                          ride.user?.additionalinfo?.image)),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _authController.driverpage.value =
                                          ride.user;
                                      _automobilscontroller.getautomobildata(
                                          ride.automobilId, context);
                                      if (_authController
                                                  .driverpage.value !=
                                              null &&
                                          _authController
                                                  .driverpage.value?.id !=
                                              null &&
                                          _authController
                                                  .driverpage.value?.id !=
                                              0 &&
                                          _authController
                                                  .driverpage.value?.id !=
                                              '' &&
                                          _authController
                                                  .driverpage.value?.id !=
                                              ' ') {
                                        Get.toNamed(
                                            '/profiledriver/${ride.userId}');
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            StaticText(
                                                text: ride.user?.nameSurname ??
                                                    ' ',
                                                weight: FontWeight.w600,
                                                size: normaltextSize,
                                                color: darkcolor),
                                            SizedBox(width: 4),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Get.width / 2.2,
                                          child: StaticText(
                                              align: TextAlign.left,
                                              maxline: 2,
                                              textOverflow: TextOverflow.clip,
                                              text: getrideCardata(ride),
                                              weight: FontWeight.w500,
                                              size: smalltextSize,
                                              color: iconcolor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () => _messagescontroller
                                              .callpageredirect('call',
                                                  ride.user?.phone, context),
                                          style: ElevatedButton.styleFrom(
                                            primary: primarycolor,
                                            onPrimary: whitecolor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                          child: Icon(FeatherIcons.phoneCall,
                                              color: whitecolor,
                                              size: normaltextSize),
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () => _messagescontroller
                                              .createandredirectchat(
                                                  auth_id?.value,
                                                  ride.userId,
                                                  context),
                                          style: ElevatedButton.styleFrom(
                                            primary: primarycolor,
                                            onPrimary: whitecolor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                          child: Icon(
                                              FeatherIcons.messageCircle,
                                              color: whitecolor,
                                              size: normaltextSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ])
                          : SizedBox(),
                    ),
                    Devider(),
                  ],
                )),
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
                      inputType: TextInputType.text,
                      cornerradius: BorderRadius.all(Radius.circular(50)),
                      controller: priceofwaycontroller.value),
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
                      text: "reguestnow".tr,
                      width: 160,
                      onPressed: () => getrequestforride(
                          ride as Rides, context as BuildContext),
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
          );
        });
  }

  void getrequestforride(Rides ride, BuildContext context) async {
    refreshpage.value = true;

    List<LatLng> points = [];

    polyline.forEach((polyline) {
      if (polyline != null) {
        polyline.points.forEach((element) {
          points.add(element);
        });
      }
    });

    Map<String, dynamic> body = {
      "ride_id": ride.id,
      "price": priceofwaycontroller.value.text ?? 0,
      "position": selectedplace.value ?? null,
      "coordinates": <Map<String, dynamic>>[],
      'start_time': fromTimeSelectable.value.toString() ?? null,
      'end_time': toTimeSelectable.value.toString() ?? null,
      'kmofway': directiondetails.value!.distanceValue ?? 0,
      'durationofway': directiondetails.value!.durationValue ?? 0,
      "polyline_points": points,
      'minimal_price_of_way': minimumpriceofwaycontroller.value.text != null &&
              minimumpriceofwaycontroller.value.text != '' &&
              minimumpriceofwaycontroller.value.text != ' '
          ? minimumpriceofwaycontroller.value.text
          : 0,
      'price_of_way': priceofwaycontroller.value.text != null &&
              priceofwaycontroller.value.text != '' &&
              priceofwaycontroller.value.text != ' '
          ? priceofwaycontroller.value.text
          : 0,
      'payment_method': cardscontroller.selectedCards.value!.id == null ||
              cardscontroller.selectedCards.value!.id == 0
          ? 'nagd'
          : 'card',
      'payment_card': cardscontroller.selectedCards.value!.id == null ||
              cardscontroller.selectedCards.value!.id == 0
          ? null
          : cardscontroller.selectedCards.value!.id,
      'status': 'waiting',
      'weight': weightcontroller.value.text != null &&
              weightcontroller.value.text != '' &&
              weightcontroller.value.text != ' '
          ? weightcontroller.value.text
          : 0,
      'place_id': null,
    };

    List<Map<String, dynamic>> coordinates = [];

    addresscontrollers.value.forEach((key, value) {
      coordinates.add({
        "latitude": markers.value
            .firstWhere((element) => element?.markerId.value == key)!
            .position!
            .latitude
            .toString(),
        "longitude": markers.value
            .firstWhere((element) => element?.markerId.value == key)!
            .position!
            .longitude
            .toString(),
        "address": markers.value
            .firstWhere((element) => element?.markerId.value == key)!
            .infoWindow
            .title,
        "type": key
      });
    });

    body['coordinates'] = coordinates;

    if (auth_id.value != null && auth_id.value != '' && auth_id.value != ' ') {
      body['user_id'] = auth_id.value;
    }
    var response =
        await GetAndPost.postData("rides_sendrequest", body, context);

    Get.back();

    if (response != null) {
      String status = response['status'];
      String message = '';
      if (response['message'] != null) message = response['message'];
      if (status == "success") {
        data.value = [];
        searchinglocations.value = [];
        selectedindex.value = 0;
        weightcontroller.value = TextEditingController();
        priceofwaycontroller.value = TextEditingController();
        addresscontrollers.value.clear();
        addorremoveeditingcontroller(0, "add");
        addorremoveeditingcontroller(1, "add");
        markers.removeWhere((element) => element?.markerId != "position_0");
        circles.removeWhere((element) => element?.circleId != "position_0");
        minimumpriceofwaycontroller.value = TextEditingController();
        openmodal.value = false;
        addedsectionshow.value = false;
        loading.value = false;
        fromTime.value = DateTime.now();
        toTime.value = DateTime.now().add(Duration(days: 4));
        fromTimeSelectable.value = DateTime.now();
        toTimeSelectable.value = DateTime.now().add(Duration(days: 4));
        goinglocations.removeWhere((element) => element?.type != "position_0");
        polyline.value = {};
        inptype.value = "position_1";
        mapped?.value = {};
        resulttext.value = null;
        if (response['data'] != null) {
          currentrides.value.add(Rides.fromMap(response['data']));
        }
        refreshpage.value = true;
      } else {
        print(
            "--------------------------------Xeta---------------------------------------------------");
        print(message);
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }

  void getcurrentrides(BuildContext context) async {
    try {
      refreshpage.value = true;
      Map<String, dynamic> body = {};
      userlocations.value = [];
      var response = await GetAndPost.fetchData("rides", context, body);
      if (response != null) {
        String status = response['status'];
        String message = '';
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          currentrides.value = (response['data'] as List).map((dat) {
            return Rides.fromMap(dat);
          }).toList();
        } else {
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        userlocations.value = [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void changemethod(context) {
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
                        leading: Icon(
                            fontawesome(item.cardtype ?? 'visa') as IconData?,
                            color: secondarycolor,
                            size: headingSize,
                            textDirection: TextDirection.ltr),
                        title: StaticText(
                          color: darkcolor,
                          size: normaltextSize,
                          text: maskLastFourDigits(item.cardnumber ?? ''),
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
                                item.id!, true, context);
                            Get.back();
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
        );
      },
    );
  }

  Future<void> fetchlocations(context) async {
    try {
      refreshpage.value = true;
      Map<String, dynamic> body = {};
      userlocations.value = [];
      var response = await GetAndPost.fetchData("locations", context, body);
      if (response != null) {
        String status = response['status'];
        String message = '';
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          userlocations.value = (response['data'] as List).map((dat) {
            return UserLocations.fromMap(dat);
          }).toList();
        } else {
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        userlocations.value = [];
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getnewmark(LatLng latlng, context) async {
    markers.value = {};
    Map mappeda = await getnameviacoords(
        latlng.latitude, latlng.longitude, 'az', context);
    mapped?.value = mappeda;
    latLngPos.value = latlng;
    markers.value.add(Marker(
      markerId: MarkerId("position_0"),
      onDragEnd: (LatLng latlng) =>
          dragortappedmarker("position_0", latlng, context),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(title: "mylocation".tr, snippet: 'mylocation'.tr),
      position: latlng,
      draggable: true,
    ));
  }

  Future<void> createorselectlocation(String type, context) async {
    var locationData = await gettypeoflocationaddress(type, context);

    if (locationData != null && locationData['name'] != null) {
      addresscontrollers.value[type].text = locationData['name'] as String;
      if (addresscontrollers['position_1'] == null) {
        inptype.value = "position_1";
      } else {
        inptype.value = "position_${addresscontrollers.value.length}";
      }
      selectsearchedloc(locationData['place_id'], context);
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                Obx(
                  () => Expanded(
                    child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: GoogleMap(
                          mapType: MapType.terrain,
                          myLocationButtonEnabled: true,
                          initialCameraPosition: kGooglePlex,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          mapToolbarEnabled: true,
                          myLocationEnabled: true,
                          markers: markers.isNotEmpty
                              ? Set<Marker>.from(markers)
                              : {},
                          onMapCreated: (GoogleMapController controller) {
                            googlemapcontroller.complete(controller);
                            newgooglemapcontroller.value = controller;
                            getcurrentposition(context);
                          },
                          onCameraMove: (cameraPosition) {
                            getnewmark(cameraPosition.target, context);
                          },
                          onLongPress: (LatLng latlng) {
                            getnewmark(latlng, context);
                          },
                        )),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addlocationtodb(
                        mapped?.value['nameaddress'],
                        mapped?.value['place_id'],
                        latLngPos.value!,
                        type,
                        context);
                    markers.value = {};
                    fetchlocations(context);
                    getcurrentposition(context);
                    Get.back();
                  },
                  child: StaticText(
                      color: secondarycolor,
                      size: normaltextSize,
                      weight: FontWeight.w500,
                      align: TextAlign.center,
                      text: "choise".tr),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void dragortappedmarker(
      String markerId, LatLng? latlng, BuildContext context) async {
    try {
      if (latlng != null) {
        refreshpage.value = true;
        CameraPosition cameraposition =
            new CameraPosition(target: latlng, zoom: 14);

        kGooglePlex = cameraposition;
        Map gettednameandplace_id = await getnameviacoords(
            latlng.latitude, latlng.longitude, 'az', context);

        goinglocations.value
            .removeWhere((element) => element.type == markerId);
        markers.value
            .removeWhere((element) => element?.markerId == MarkerId(markerId));
        circles.value
            .removeWhere((element) => element?.circleId == CircleId(markerId));

        UserLocations userlocationtoingdb = await addlocationtodb(
            gettednameandplace_id['nameaddress'] ?? '',
            gettednameandplace_id['place_id'] as String,
            latlng as LatLng,
            markerId,
            context as BuildContext);

        await fetchlocations(context);

        if (userlocationtoingdb.type != null &&
            userlocationtoingdb.placeId != null) {
          newgooglemapcontroller.value
              ?.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
          refreshpage.value = false;

          if (userlocationtoingdb.name != null &&
              userlocationtoingdb.name != ' ' &&
              userlocationtoingdb.name != '' &&
              userlocationtoingdb.placeId != null &&
              userlocationtoingdb.placeId != '' &&
              userlocationtoingdb.placeId != ' ') {
            if (addresscontrollers.value.containsKey(markerId)) {
              addresscontrollers.value[markerId].text =
                  getLocalizedValue(userlocationtoingdb.name, 'name') as String;
            }
            goinglocations.value.add(userlocationtoingdb);
            markers.value.add(Marker(
              markerId: MarkerId(userlocationtoingdb.type as String),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  markerId=="position_0"? BitmapDescriptor.hueAzure : BitmapDescriptor.hueRed),
              infoWindow: InfoWindow(
                title: getLocalizedValue(userlocationtoingdb.name, 'name'),
                snippet: 'mylocation'.tr,
              ),
              
              position: LatLng(
                  userlocationtoingdb.coordinates!.latitude!.toDouble(),
                  userlocationtoingdb.coordinates!.longitude!.toDouble()),
              draggable: true,
              onDragEnd: (LatLng latlng) => dragortappedmarker(
                  userlocationtoingdb.type as String, latlng, context),
            ));

            circles.value.add(Circle(
              circleId: CircleId(userlocationtoingdb.type as String),
              fillColor: markerId=="position_0"? secondarycolor : errorcolor,
              center: LatLng(
                  userlocationtoingdb.coordinates!.latitude!.toDouble(),
                  userlocationtoingdb.coordinates!.longitude!.toDouble()),
              radius: 15,
              strokeWidth: 4,
              strokeColor:  markerId=="position_0"? secondarycolor : errorcolor,
            ));

            if(markers.length>1){
              createroute(context);
            }
          }
        } else {
          refreshpage.value = false;
        }
      }
    } catch (e) {
      print(
          "-------------------------------------dragortappedmarker--------------------------------- ${e.toString()}");
    }
  }

  Map<String, dynamic>? gettypeoflocationaddress(String type, context) {
    if (userlocations.value != null) {
      for (UserLocations location in userlocations.value) {
        if (location.type == type) {
          return {
            "name": getLocalizedValue(location.name, 'name'),
            "place_id": location.placeId,
          };
        }
      }
    }
    return null;
  }
}
