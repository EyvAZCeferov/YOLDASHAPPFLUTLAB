import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Models/Automobils.dart';

class AutomobilsController extends GetxController {
  RxList<Automobils> data = <Automobils>[].obs;

  @override
  void onInit() {
    fetchDatas();
    super.onInit();
  }

  void fetchDatas() {
    data = [
      Automobils(
          icon: FontAwesomeIcons.car,
          name: "Wolkswagen-CC",
          statebadge: "90-NR-190",
          value: true),
      Automobils(
          icon: FontAwesomeIcons.car,
          name: "Wolkswagen-AUTO",
          statebadge: "90-BA-190",
          value: false)
    ].obs;
  }

  void updateSelection(int index, bool value) {
    for (var i = 0; i < data.length; i++) {
      if (i == index) {
        data[i].value = value;
      } else {
        data[i].value = false;
      }
    }
    data.refresh();
  }
}
