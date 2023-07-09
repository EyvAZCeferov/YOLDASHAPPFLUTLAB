import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Models/Cards.dart';

class CardsController extends GetxController {
  RxList<Cards> cards = <Cards>[].obs;
  Rx<TextEditingController> cardNumberController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> validityDateController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> cvvController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> holderNameController =
      Rx<TextEditingController>(TextEditingController());

  @override
  void onInit() {
    fetchCards();
    super.onInit();
  }

  void fetchCards() {
    cards = [
      Cards(title: 'Ev', description: "Aciqlama", value: false),
      Cards(title: 'İş', description: "Aciqlama", value: true),
      Cards(title: 'Okul', description: "Aciqlama 2", value: false),
    ].obs;
  }

  void updateSelection(int index, bool value) {
    for (var i = 0; i < cards.length; i++) {
      if (i == index) {
        cards[i].value = value;
      } else {
        cards[i].value = false;
      }
    }
    cards.refresh();
  }
}
