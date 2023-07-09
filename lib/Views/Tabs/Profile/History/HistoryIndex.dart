import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/HistoryController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class HistoryIndex extends StatefulWidget {
  @override
  State<HistoryIndex> createState() => _HistoryIndexState();
}

class _HistoryIndexState extends State<HistoryIndex> {
  final HistoryController _controller = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "history".tr,
          changeprof: false,
          titlebg: false,
        ),
        body: Obx(() => _controller.data.length > 0
            ? Container()
            : Center(
                child: StaticText(
                  color: errorcolor,
                  size: buttontextSize,
                  weight: FontWeight.w500,
                  align: TextAlign.center,
                  text: "nohasdata".tr,
                ),
              )));
  }
}
