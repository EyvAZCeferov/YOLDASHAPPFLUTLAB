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
            AccordionTemplate(title: "automodel".tr, type: "model"),
            Devider(),
            AccordionTemplate(title: "automarka".tr, type: "marka"),
            Devider(),
            AccordionTemplate(title: "autocolor".tr, type: "color"),
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
              onPressed: () => print("Logout")),
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
        // İlk iki karakteri sayıya dönüştürme
        final firstTwoDigits = int.tryParse(newText.substring(0, 2));
        final firstTwo = firstTwoDigits != null ? '$firstTwoDigits-' : '';

        // Son iki karakteri büyük harfle tutma
        final lastTwo = newText.substring(5, 7);

        // Orta üç karakteri büyük harfle tutma
        final middleThree = newText.substring(2, 5).toUpperCase();

        // Formatlı metni oluşturma
        formattedText = '$firstTwo$middleThree-$lastTwo';
      }

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    return oldValue;
  }
}
