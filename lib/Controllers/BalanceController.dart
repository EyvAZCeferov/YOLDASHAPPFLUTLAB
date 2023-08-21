import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../Views/Standarts/WebveiwFunctions.dart';
import '../models/balance_types.dart';
import '../models/user_balances.dart';

class BalanceController extends GetxController {
  Rx<BalanceTypes?> selectedType = Rx<BalanceTypes?>(null);
  Rx<int?> price = Rx<int?>(null);
  Rx<bool> refreshpage = Rx<bool>(false);
  RxList<BalanceTypes> balancetypes = RxList<BalanceTypes>();
  RxList<UserBalances?> userbalances = RxList<UserBalances?>();
  Rx<int?> totalprice = Rx<int?>(0);
  Rx<BalanceElement?> selectedElement = Rx<BalanceElement?>(null);

  void changeAddType(String newType, context) {
    refreshpage.value = true;
    selectedType.value = null;
    price.value = null;
    for (var balanceType in balancetypes.value) {
      if (balanceType.type == newType) {
        selectedType.value = balanceType;
        break;
      }
    }
    refreshpage.value = false;
    if (newType == "monthly") {
      selectedElement.value = selectedType.value!.elements![0];
      selectPriceType("monthly", selectedElement.value!.id, context);
    }
  }

  Future<void> fetchData(context) async {
    try {
      refreshpage.value = true;
      Map<String, dynamic> body = {};
      var response =
          await GetAndPost.fetchData("balance_actions", context, body);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          if (response['data'] != null) {
            if (response['data'] != null) {
              userbalances.value = (response['data'] as List).map((dat) {
                var data = UserBalances.fromMap(dat);
                return data;
              }).toList();
            }
          }

          totalprice.value = response['price'];
        } else {
          showToastMSG(errorcolor, message, context);
          totalprice.value = 0;
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        totalprice.value = 0;
        userbalances.value = [];
        balancetypes.value = [];
        selectedType.value = BalanceTypes();
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } catch (e) {
      refreshpage.value = false;
      print("Balance error " + e.toString());
    }
  }

  Future<void> fetchTypes(context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response =
        await GetAndPost.fetchData("balance_actions/create", context, body);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        List<String> groups = response['data'].keys.toList();
        for (String group in groups) {
          List<dynamic> elements = response['data'][group];
          List<BalanceElement> balanceElements = elements.map((element) {
            return BalanceElement.fromMap(element);
          }).toList();

          balancetypes.value.add(BalanceTypes(
            type: group,
            elements: balanceElements,
          ));
        }
      } else {
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      balancetypes.value = [];
      selectedType.value = BalanceTypes();
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }

  Color getActiveBgColor(type) {
    if (selectedType.value != null && selectedType.value!.type == type) {
      return primarycolor;
    } else {
      return whitecolor;
    }
  }

  Color getActiveTextColor(type) {
    if (selectedType.value != null && selectedType.value!.type == type) {
      return whitecolor;
    } else {
      return darkcolor;
    }
  }

  void selectPriceType(type, id, context) {
    refreshpage.value = true;
    price.value = null;
    if (selectedType.value != null) {
      List<BalanceElement>? elements = selectedType!.value!.elements;
      for (var element in elements!) {
        if (element.id == id) {
          selectedElement.value = element;
          price.value = element.price;
          break;
        }
      }
    }
    refreshpage.value = false;
  }

  void addbalance(context) async {
    refreshpage.value = true;
    if (price.value != null) {
      Map<String, dynamic> body = {
        'price': price.value,
        'balance_type': selectedElement.value!.id,
        'package_type': selectedType.value!.type
      };
      var response =
          await GetAndPost.postData("balance_actions", body, context);
      if (response != null) {
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          if (response['data'] != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebviewFunctions(
                    paymentUrl: response['data'], title: 'paynow'.tr),
              ),
            );
            // launchUrlTOSITE(response['data']);
          } else {
            showToastMSG(errorcolor, "nothavepaymentlink".tr, context);
          }
        } else {
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      }
    } else {
      refreshpage.value = false;

      showToastMSG(errorcolor, "notpickedprice".tr, context);
    }
  }
}
