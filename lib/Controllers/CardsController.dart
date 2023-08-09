import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Functions/GetAndPost.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/models/cards.dart';

class CardsController extends GetxController {
  Rx<bool> refreshpage = Rx<bool>(false);
  RxList<Cards> data = <Cards>[].obs;
  Rx<Cards?> selectedCards = Rx<Cards?>(null);

  Rx<TextEditingController> cardNumberController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> validityDateController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> cvvController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> holderNameController =
      Rx<TextEditingController>(TextEditingController());

  Future<void> fetchDatas(context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response = await GetAndPost.fetchData("cards", context, body);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        data.value = (response['data'] as List).map((dat) {
          return Cards.fromMap(dat);
        }).toList();

        selectedCards.value = data.firstWhere(
            (automobil) => automobil.selected == true,
            orElse: () => Cards());
      } else {
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      data.value = [];
      selectedCards.value = Cards();
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }

  Future<void> updateSelection(int index, bool value, context) async {
    refreshpage.value = true;
    var selectedelement;

    selectedelement = data.firstWhere((automobil) => automobil.id == index,
        orElse: () => Cards());

    var body = {};
    var response = await GetAndPost.patchData(
        "cards/${selectedelement.id}", body, context);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        fetchDatas(context);
      } else {
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      data.value = [];
      selectedCards.value = Cards();
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }
}
