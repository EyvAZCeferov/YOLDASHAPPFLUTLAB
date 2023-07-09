import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Controllers/HistoryController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class HistoryShow extends GetView<HistoryController> {
  final index = int.parse(Get.parameters['index'] ?? '');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "historydetail".tr,
          changeprof: false,
          titlebg: true,
        ),
        body: Container());
  }
}
