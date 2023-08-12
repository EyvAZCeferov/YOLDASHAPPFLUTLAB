import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Functions/GetAndPost.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/models/balance_types.dart';

class BalanceController extends GetxController {
  Rx<BalanceTypes?> selectedType = Rx<BalanceTypes?>(null);
  Rx<int?> price = Rx<int?>(null);
  Rx<bool> refreshpage = Rx<bool>(false);
  RxList<BalanceTypes> data = RxList<BalanceTypes>();
  Rx<BalanceElement?> selectedElement = Rx<BalanceElement?>(null);

  void changeAddType(String newType, context) {
    refreshpage.value = true;
    selectedType.value = null;
    price.value = null;
    for (var balanceType in data.value) {
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

  Future<void> fetchDatas(context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response = await GetAndPost.fetchData("balance_actions", context, body);
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

          data.value.add(BalanceTypes(
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
      data.value = [];
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

  void addbalance(context) {
    refreshpage.value = true;
    if (price.value != null) {
    } else {
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }

    refreshpage.value = false;
  }
}
