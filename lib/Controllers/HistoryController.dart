import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Models/Cards.dart';

class HistoryController extends GetxController {
  RxList<Cards> data = <Cards>[
    Cards(description: "Description", title: "Taytl", value: false),
    Cards(description: "Description", title: "Taytl", value: false),
    Cards(description: "Description", title: "Taytl", value: false),
    Cards(description: "Description", title: "Taytl", value: false),
    Cards(description: "Description", title: "Taytl", value: false),
    Cards(description: "Description", title: "Taytl", value: false),
    Cards(description: "Description", title: "Taytl", value: false)
  ].obs;

  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    data.value = [
      Cards(description: "Description", title: "Taytl", value: false)
    ];
  }
}
