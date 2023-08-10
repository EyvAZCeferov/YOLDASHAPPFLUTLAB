import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoldash/models/cards.dart';

class HistoryController extends GetxController {
  RxList<Cards> data = <Cards>[].obs;
  Rx<String> authtype = "rider".obs;
  RxBool openmodalval = false.obs;
  Rx<String> image = "".obs;

  LatLng? currentLocation;

  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentLocation = LatLng(position.latitude, position.longitude);
  }

  void openModal(imageval) {
    image.value = '';
    if (imageval != null) {
      image.value = imageval;
    }
    openmodalval.value = !openmodalval.value;
  }
}
