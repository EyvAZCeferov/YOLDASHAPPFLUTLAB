import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/AutomobilsController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class AutomobilsCreate extends StatelessWidget {
  final AutomobilsController _controller = Get.find<AutomobilsController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        title: "documents".tr,
        changeprof: false,
        titlebg: false,
      ),
      body: Container(),
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 15),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ButtonElement(
              text: "add".tr,
              height: 50,
              width: width - 100,
              borderRadius: BorderRadius.circular(45),
              onPressed: () => print("Logout")),
        ),
      ),
    );
  }
}
