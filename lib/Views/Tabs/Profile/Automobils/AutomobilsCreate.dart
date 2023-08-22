import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Constants/LoaderScreen.dart';

import '../../../../Constants/AccordionTemplate.dart';
import '../../../../Constants/BaseAppBar.dart';
import '../../../../Constants/ButtonElement.dart';
import '../../../../Constants/Devider.dart';
import '../../../../Constants/DocumentRow.dart';
import '../../../../Constants/StaticText.dart';
import '../../../../Controllers/AutomobilsController.dart';
import '../../../../Theme/ThemeService.dart';

class AutomobilsCreate extends StatelessWidget {
  final AutomobilsController _controller = Get.find<AutomobilsController>();

  @override
  Widget build(BuildContext context) {
    _controller.fetchModels(context, 'models');
    _controller.fetchModels(context, 'marks');
    _controller.fetchModels(context, 'colors');

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        title: "documents".tr,
        changeprof: false,
        titlebg: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Devider(),
            Center(
                child: Container(
                    width: Get.width - 40,
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        color: whitecolor,
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurStyle: BlurStyle.solid,
                            color: Colors.black38,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StaticText(
                            text: "autonumber".tr,
                            weight: FontWeight.w500,
                            size: normaltextSize,
                            color: darkcolor),
                        Devider(size: 5),
                        TextField(
                          controller: _controller.licensePlateController.value,
                          autocorrect: false,
                          autofocus: false,
                          cursorColor: iconcolor,
                          style: TextStyle(color: primarycolor),
                          inputFormatters: [
                            LicensePlateInputFormatter(),
                          ],
                        )
                      ],
                    ))),
            Devider(),
            Obx(
              () => _controller.refreshpage.value == true
                  ? LoaderScreen()
                  : DocumentRow(
                      title: "drivinglicence".tr,
                      subtitle: "uploadimage".tr,
                      onPressed: () =>
                          _controller.pickImage("driving_licence", context),
                      data: _controller.driving_licence.value,
                    ),
            ),
            Devider(),
            Obx(
              () => _controller.refreshpage.value == true
                  ? LoaderScreen()
                  : DocumentRow(
                      title: "idcard".tr,
                      subtitle: "uploadimage".tr,
                      onPressed: () =>
                          _controller.pickImage("id_card", context),
                      data: _controller.id_card.value,
                    ),
            ),
            Devider(),
            Obx(
              () => _controller.refreshpage.value == true
                  ? LoaderScreen()
                  : DocumentRow(
                      title: "autotexpasport".tr,
                      subtitle: "uploadimage".tr,
                      onPressed: () =>
                          _controller.pickImage("technical_passport", context),
                      data: _controller.technical_passport.value,
                    ),
            ),
            Devider(),
            Obx(
              () => _controller.refreshpage.value == true
                  ? LoaderScreen()
                  : AccordionTemplate(
                      title: "automarka".tr,
                      type: "marks",
                      data: _controller.automarks.value,
                    ),
            ),
            Devider(),
            Obx(
              () => _controller.refreshpage.value == true
                  ? LoaderScreen()
                  : AccordionTemplate(
                      title: "automodel".tr,
                      type: "models",
                      data: _controller.automodels.value),
            ),
            Devider(),
            Obx(
              () => _controller.refreshpage.value == true
                  ? LoaderScreen()
                  : AccordionTemplate(
                      title: "autocolor".tr,
                      type: "colors",
                      data: _controller.autocolors.value),
            ),
            Devider(),
          ],
        ),
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
              onPressed: () => _controller.addCar(context)),
        ),
      ),
    );
  }
}

class LicensePlateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String newText = newValue.text.toUpperCase();

    if (newText.length <= 7) {
      String formattedText = '';

      if (newText.isNotEmpty) {
        var firstTwo = newText.substring(0, 2);
        var lastThree = newText.substring(4, 7).toUpperCase();
        var middleTwo = newText.substring(2, 4);

        formattedText = '$firstTwo-$middleTwo-$lastThree';
      }

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
    return oldValue;
  }
}
