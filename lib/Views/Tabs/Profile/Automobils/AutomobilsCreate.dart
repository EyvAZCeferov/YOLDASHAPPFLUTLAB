import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
    _controller.fetchModels(context, 'types');

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
      body: Obx(
        () => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            height: Get.height * 1.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Devider(),
                Center(
                    child: Container(
                        width: Get.width - 40,
                        height: 150,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                              controller:
                                  _controller.licensePlateController.value,
                              autocorrect: true,
                              autofocus: false,
                              cursorColor: iconcolor,
                              style: TextStyle(color: primarycolor),
                              inputFormatters: [
                                LicensePlateInputFormatter(),
                              ],
                              onChanged: (text) {
                                if (text.isEmpty) {
                                  _controller.licensePlateController.value
                                      .clear();
                                }
                              },
                            )
                          ],
                        ))),
                Devider(),
                Center(
                    child: Container(
                        width: Get.width - 40,
                        height: 150,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                text: "automarka".tr,
                                weight: FontWeight.w500,
                                size: normaltextSize,
                                color: darkcolor),
                            Devider(size: 5),
                            TextField(
                              controller: _controller.marka.value,
                              autocorrect: false,
                              autofocus: false,
                              cursorColor: iconcolor,
                              style: TextStyle(color: primarycolor),
                            )
                          ],
                        ))),
                Devider(),
                Center(
                    child: Container(
                        width: Get.width - 40,
                        height: 150,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                text: "automodel".tr,
                                weight: FontWeight.w500,
                                size: normaltextSize,
                                color: darkcolor),
                            Devider(size: 5),
                            TextField(
                              controller: _controller.model.value,
                              autocorrect: false,
                              autofocus: false,
                              cursorColor: iconcolor,
                              style: TextStyle(color: primarycolor),
                            )
                          ],
                        ))),
                Devider(),
                Center(
                    child: Container(
                        width: Get.width - 40,
                        height: 150,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                text: "autocolor".tr,
                                weight: FontWeight.w500,
                                size: normaltextSize,
                                color: darkcolor),
                            Devider(size: 5),
                            TextField(
                              controller: _controller.color.value,
                              autocorrect: false,
                              autofocus: false,
                              cursorColor: iconcolor,
                              style: TextStyle(color: primarycolor),
                            )
                          ],
                        ))),
                Devider(),
                // Obx(() => _controller.refreshpage.value == true
                //     ? LoaderScreen()
                //     :

                Column(
                  children: [
                    DocumentRow(
                      title: "drivinglicence".tr,
                      subtitle: "uploadimage".tr,
                      onPressed: () =>
                          _controller.pickImage("driving_licence", context),
                      data: _controller.driving_licence.value,
                    ),
                    Devider(),
                    DocumentRow(
                      title: "idcard".tr,
                      subtitle: "uploadimage".tr,
                      onPressed: () =>
                          _controller.pickImage("id_card", context),
                      data: _controller.id_card.value,
                    ),
                    Devider(),
                    DocumentRow(
                      title: "autotexpasport".tr,
                      subtitle: "uploadimage".tr,
                      onPressed: () =>
                          _controller.pickImage("technical_passport", context),
                      data: _controller.technical_passport.value,
                    ),
                    Devider(),
                    AccordionTemplate(
                        title: "autotype".tr,
                        type: "types",
                        data: _controller.autotype.value),
                    Devider(),
                    AccordionTemplate(
                        title: "autoimages".tr,
                        type: "images",
                        data: _controller.autoimages.value),
                  ],
                ),

                // ),
                Devider(),
              ],
            ),
          ),
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
  final AutomobilsController _controller = Get.put(AutomobilsController());

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String newText = newValue.text.toUpperCase();

    if (newText.length <= 7) {
      String formattedText = '';

      if (newText.isNotEmpty) {
        if (newText.length <= 4) {
          formattedText = newText;
        } else {
          var firstTwo = newText.substring(0, 2);
          var lastThree = newText.substring(4, 7).toUpperCase();
          var middleTwo = newText.substring(2, 4);

          formattedText = '$firstTwo-$middleTwo-$lastThree';
        }
      }

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else {
      _controller.licensePlateController.value.clear();
      return TextEditingValue.empty;
    }
  }
}
