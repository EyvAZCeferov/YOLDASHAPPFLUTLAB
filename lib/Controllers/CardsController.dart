import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import '../Constants/ButtonElement.dart';
import '../Constants/Devider.dart';
import '../Constants/StaticText.dart';
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
  Rx<bool?> really_delete = Rx<bool>(false);

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
          // showToastMSG(errorcolor, message, context);
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
        selected: selectedCards.value!.id == null ||
                selectedCards.value!.id == '' ||
                selectedCards.value!.id == ' ' ||
                selectedCards.value!.id == 0 ||
                selectedCards.value!.id == '0'
            ? true
            : false,
        userId: auth_id.value,
      );

      data.value.add(cashmethod);

      if (cashmethod.selected == true) {
        selectedCards.value = cashmethod;
      }
    } catch (e) {
      refreshpage.value = false;
      print(e.toString());
    }
  }

  Future<void> updateSelection(int index, bool value, context) async {
    refreshpage.value = true;
    var selectedelement;
    selectedelement = data.firstWhere((element) => element.id == index,
        orElse: () => Cards());
    var body = {};
    var response = await GetAndPost.patchData(
        "cards/${selectedelement.id}", body, context);
    if (response != null) {
      String status = response['status'];
      String message = "";
      if (response['message'] != null) message = response['message'];
      fetchDatas(context).then((value) {
        if (status == "success") {
          refreshpage.value = false;
        } else {
          refreshpage.value = false;
          showToastMSG(errorcolor, message, context);
        }
      });
    } else {
      refreshpage.value = false;
      data.value = [];
      selectedCards.value = Cards();
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }

  void removeCard(id, context) async {
    refreshpage.value = true;
    if (really_delete.value == false) {
      refreshpage.value = false;
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 140,
              color: Colors.white,
              child: Column(
                children: [
                  Devider(),
                  StaticText(
                    color: secondarycolor,
                    size: buttontextSize,
                    text: "really_delete".tr,
                    weight: FontWeight.w500,
                    align: TextAlign.center,
                    maxline: 3,
                    textOverflow: TextOverflow.clip,
                  ),
                  Devider(size: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonElement(
                        text: "really_delete_no".tr,
                        bgColor: errorcolor,
                        fontsize: 14,
                        textColor: whitecolor,
                        onPressed: () => Get.back(),
                        width: Get.width / 3,
                        height: 50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      SizedBox(width: 25),
                      ButtonElement(
                        text: "really_delete_yes".tr,
                        bgColor: primarycolor,
                        fontsize: 14,
                        textColor: whitecolor,
                        onPressed: () {
                          really_delete.value = true;
                          refreshpage.value = false;
                          Get.back();
                          removeCard(id, context);
                        },
                        width: Get.width / 3,
                        height: 50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    } else {
      Map<String, dynamic> body = {
        "id": id,
      };

      var response = await GetAndPost.postData("removeCard", body, context);

      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          really_delete.value = false;
          fetchDatas(context);
          refreshpage.value = false;
        } else {
          showToastMSG(errorcolor, message, context);
          refreshpage.value = false;
        }
      } else {
        refreshpage.value = false;
      }
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
