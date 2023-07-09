import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class BalanceController extends GetxController {
  Rx<String> selectedType = Rx<String>('');
  Rx<String> selectedprice = Rx<String>('');
  RxInt selectedDay = RxInt(0);
  RxInt selectedSuggestingPrice = RxInt(0);

  void changeAddType(String newType) {
    selectedType.value = newType;
    selectedprice.value = '';
    if (newType == "ayliq") {
      selectedprice.value = "20.00";
    } else if (newType == 'gunluk') {
      if (selectedDay.value != 0) {
        selectedprice.value = selectedDay.value.toString();
      }
    } else if (newType == 'ferdi') {
      if (selectedSuggestingPrice.value != 0) {
        selectedprice.value = selectedSuggestingPrice.value.toString();
      }
    }
  }

  Color getActiveBgColor(type) {
    if (selectedType.value == type) {
      return primarycolor;
    } else {
      return whitecolor;
    }
  }

  Color getActiveTextColor(type) {
    if (selectedType.value == type) {
      return whitecolor;
    } else {
      return darkcolor;
    }
  }

  void selectPriceType(type, index) {
    selectedSuggestingPrice.value = 0;
    selectedDay.value = 0;
    if (type == "gunluk") {
      selectedDay.value = index;
    } else {
      selectedSuggestingPrice.value = index;
    }
    changeAddType(type);
  }
}
