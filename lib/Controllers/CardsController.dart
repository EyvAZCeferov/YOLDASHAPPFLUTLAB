import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Functions/CacheManager.dart';

import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../models/cards.dart';

class CardsController extends GetxController {
  Rx<bool> refreshpage = Rx<bool>(false);
  RxList<Cards> data = RxList<Cards>();
  Rx<Cards?> selectedCards = Rx<Cards?>(null);

  Rx<TextEditingController> cardNumberController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> validityDateController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> cvvController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> holderNameController =
      Rx<TextEditingController>(TextEditingController());

  void addcard(BuildContext context) async {
    try {
      if ((cardNumberController.value.text != null &&
              cardNumberController.value.text != '') &&
          (validityDateController.value.text != null &&
              validityDateController.value.text != '') &&
          (cvvController.value.text != null &&
              cvvController.value.text != '') &&
          (holderNameController.value.text != null &&
              holderNameController.value.text != '')) {
        refreshpage.value = true;
        var language =
            await CacheManager.getvaluefromsharedprefences("language") ?? 'az';
        var body = {
          'cardnumber': cardNumberController.value.text,
          'language': language,
          'validitydate': validityDateController.value.text,
          'cvv': cvvController.value.text,
          'holdername': holderNameController.value.text
        };
        var response = await GetAndPost.postData("cards", body, context);
        if (response['status'] == "success") {
          refreshpage.value = false;
          Get.offAllNamed('cards');
        } else {
          refreshpage.value = false;
          showToastMSG(errorcolor, response['message'], context);
        }
      } else {
        refreshpage.value = true;
        showToastMSG(errorcolor, "fillthefield".tr, context);
        refreshpage.value = false;
      }
    } catch (e) {
      refreshpage.value = false;
      print("Card page error: $e");
    }
  }

  Future<void> fetchDatas(context) async {
    try {
      refreshpage.value = true;
      Map<String, dynamic> body = {};
      var response = await GetAndPost.fetchData("cards", context, body);

      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          if (response['data'] != null) {
            data.value = (response['data'] as List).map((dat) {
              return Cards.fromMap(dat);
            }).toList();

            selectedCards.value = data.firstWhere(
                (automobil) => automobil.selected == true,
                orElse: () => Cards());
          }
          refreshpage.value = false;
        } else {
          refreshpage.value = false;
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        data.value = [];
        selectedCards.value = Cards();
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } catch (e) {
      refreshpage.value=false;
      print(e.toString());
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

  CardType getcardtype() {
    var cardNumber = cardNumberController.value.text;
    if (cardNumber.startsWith('4')) {
      return CardType.visa;
    } else if (cardNumber.startsWith('5')) {
      return CardType.mastercard;
    } else if (cardNumber.startsWith('3')) {
      return CardType.americanExpress;
    } else {
      return CardType.elo;
    }
  }
}
