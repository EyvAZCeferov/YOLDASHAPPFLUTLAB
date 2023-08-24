import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Functions/CacheManager.dart';

import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../Views/Standarts/WebveiwFunctions.dart';
import '../models/cards.dart';
import 'MainController.dart';

class CardsController extends GetxController {
  late MainController _maincontroller = Get.put(MainController());
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
  Rx<int?> auth_id = Rx<int?>(null);
  Rx<String> authtype = Rx<String>('rider');

  void getAuthId() async {
    auth_id.value = await _maincontroller.getstoragedat('auth_id');
    authtype.value = await _maincontroller.getstoragedat('authtype');
  }

  void addcard(BuildContext context) async {
    try {
      refreshpage.value = true;
      var body = {};
      var response = await GetAndPost.postData("cards", body, context);
      if (response['status'] == "success") {
        if (response['redirect_url'] != null &&
            response['redirect_url'] != '' &&
            response['redirect_url'] != ' ') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebviewFunctions(
                  paymentUrl: response['redirect_url'],
                  title: 'add_bank_account'.tr),
            ),
          );
        }
      }

      // if ((cardNumberController.value.text != null &&
      //         cardNumberController.value.text != '') &&
      //     (validityDateController.value.text != null &&
      //         validityDateController.value.text != '') &&
      //     (cvvController.value.text != null &&
      //         cvvController.value.text != '') &&
      //     (holderNameController.value.text != null &&
      //         holderNameController.value.text != '')) {
      //   refreshpage.value = true;
      //   var language =
      //       await CacheManager.getvaluefromsharedprefences("language") ?? 'az';
      //   var body = {
      //     'cardnumber': cardNumberController.value.text,
      //     'language': language,
      //     'validitydate': validityDateController.value.text,
      //     'cvv': cvvController.value.text,
      //     'holdername': holderNameController.value.text
      //   };
      //   var response = await GetAndPost.postData("cards", body, context);
      //   if (response['status'] == "success") {
      //     fetchDatas(context);
      //     refreshpage.value = false;
      //     Get.offAllNamed('cards');
      //   } else {
      //     refreshpage.value = false;
      //     showToastMSG(errorcolor, response['message'], context);
      //   }
      // } else {
      //   refreshpage.value = true;
      //   showToastMSG(errorcolor, "fillthefield".tr, context);
      //   refreshpage.value = false;
      // }
    } catch (e) {
      refreshpage.value = false;
      print("Card page error: $e");
    }
  }

  Future<void> fetchDatas(context) async {
    try {
      getAuthId();
      refreshpage.value = true;
      Map<String, dynamic> body = {};
      var response = await GetAndPost.fetchData("cards", context, body);
      selectedCards.value = Cards();
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          if (response['data'] != null) {
            data.value = [];
            data.value = (response['data'] as List).map((dat) {
              return Cards.fromMap(dat);
            }).toList();

            selectedCards.value = data.firstWhere(
                (card) => card.selected == true,
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
        
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
      Cards cashmethod = Cards(
        id: 0,
        cardholdername: "nagd".tr,
        cardnumber: "nagd".tr,
        cardtype: "nagd",
        selected: data.value.every((element) {
          if (element.id != 0) {
            return !element.selected!;
          } else {
            return false;
          }
        }),
        userId: auth_id.value,
      );

      data.value.add(cashmethod);

      if (selectedCards.value!.id == null ||
          selectedCards.value!.id != '' ||
          selectedCards.value!.id != ' ') {
        print("selectedCards.value!.id is empty");
        print(data.length);
        selectedCards.value = cashmethod;
      } else {
        print(
            "selectedCards.value!.id is not empty: ${selectedCards.value!.id}");
      }
    } catch (e) {
      refreshpage.value = false;
      print(e.toString());
    }
  }

  Future<void> updateSelection(int index, bool value, context) async {
    refreshpage.value = true;
    var selectedelement;
    if (index != 0) {
      selectedelement = data.firstWhere((element) => element.id == index,
          orElse: () => Cards());

      var body = {};
      var response = await GetAndPost.patchData(
          "cards/${selectedelement.id}", body, context);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          refreshpage.value = false;
          fetchDatas(context);
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
    } else {
      if (data.value != null && data.value.length > 1) {
        for (var element in data.value) {
          if (element.id != 0) {
            updateSelection(element.id!, false, context);
          }
        }
        fetchDatas(context);
      }
      refreshpage.value = false;
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
