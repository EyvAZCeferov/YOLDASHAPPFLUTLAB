import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/AccordionTemplate.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/DocumentRow.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Devider(),
          DocumentRow(
            title: "drivinglicence".tr,
            subtitle: "uploadimage".tr,
            completed: false,
            onPressed: () => _controller.pickImage("suruculuk", context),
          ),
          Devider(),
          DocumentRow(
            title: "idcard".tr,
            subtitle: "uploadimage".tr,
            completed: false,
            onPressed: () => _controller.pickImage("idcard", context),
          ),
          Devider(),
          DocumentRow(
            title: "autotexpasport".tr,
            subtitle: "uploadimage".tr,
            completed: false,
            onPressed: () => _controller.pickImage("autotexpasport", context),
          ),
          Devider(),
          AccordionTemplate()
        ],
      ),
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
