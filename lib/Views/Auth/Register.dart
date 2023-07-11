import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/DateElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageButton.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TextButton.dart';
import 'package:yoldash/Controllers/AuthController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class Register extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bodycolor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Devider(size: 40),
                  Container(
                      width: width - 40,
                      height: 100,
                      child: ImageClass(
                          type: false,
                          url: '/assets/images/yoldash_bg_white.png')),
                  Devider(
                    size: 20,
                  ),
                  StaticText(
                      text: 'register'.tr,
                      weight: FontWeight.w500,
                      size: headingSize,
                      color: darkcolor),
                  Devider(
                    size: 30,
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(width - 40 / 2),
                          border: Border.all(
                              color: primarycolor,
                              style: BorderStyle.solid,
                              width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width - 40 / 2,
                            height: 49,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _controller.authType.value == "rider"
                                  ? primarycolor
                                  : whitecolor,
                            ),
                            child: StaticText(
                              color: _controller.authType.value == "rider"
                                  ? whitecolor
                                  : darkcolor,
                              size: normaltextSize,
                              weight: FontWeight.w500,
                              align: TextAlign.center,
                              text: "rider".tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Devider(
                    size: 30,
                  ),
                  Container(
                    width: width - 100,
                    child: InputElement(
                        placeholder: "name_surname".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        inputType: TextInputType.text,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _controller.namesurnamecontroller.value),
                  ),
                  Devider(size: 15),
                  Container(
                    width: width - 100,
                    child: InputElement(
                        placeholder: "gender".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        inputType: TextInputType.text,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _controller.gendercontroller.value),
                  ),
                  Devider(size: 15),
                  Container(
                    width: width - 100,
                    height: 50,
                    child: DateElement(
                      placeholder: 'birthday'.tr,
                      textColor: Colors.black,
                      cornerradius: BorderRadius.circular(25),
                      onDateSelected: (DateTime selectedDate) {
                        print('Selected Date: $selectedDate');
                      },
                    ),
                  ),
                  Devider(size: 15),
                  Container(
                    width: width - 100,
                    child: InputElement(
                        placeholder: "email".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        inputType: TextInputType.emailAddress,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _controller.emailcontroller.value),
                  ),
                  Devider(size: 15),
                  Container(
                    width: width - 100,
                    child: InputElement(
                        placeholder: "mobile_phone".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        inputType: TextInputType.text,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _controller.phonecontroller.value),
                  ),
                  Devider(size: 25),
                  ButtonElement(
                      text: "register".tr,
                      height: 50,
                      width: width - 100,
                      borderRadius: BorderRadius.circular(45),
                      onPressed: () => print("A")),
                  Devider(size: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageButton(
                        image: AssetImage('assets/images/glogo.png'),
                        bgColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        width: 40,
                        padding: EdgeInsets.all(5),
                        onPressed: () {
                          print("Pressed Google");
                        },
                      ),
                      Devider(type: false),
                      ImageButton(
                        image: AssetImage('assets/images/facebook.webp'),
                        bgColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        width: 40,
                        padding: EdgeInsets.all(5),
                        onPressed: () {
                          print("Pressed Facebook");
                        },
                      ),
                      Devider(type: false),
                      ImageButton(
                        image: AssetImage('assets/images/apple.png'),
                        bgColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        width: 40,
                        padding: EdgeInsets.all(5),
                        onPressed: () {
                          print("Pressed apple");
                        },
                      )
                    ],
                  ),
                  Devider(
                    size: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StaticText(
                          text: "doeshaveaccount".tr,
                          weight: FontWeight.w400,
                          size: smalltextSize,
                          color: darkcolor),
                      TextButtonElement(
                          text: "login".tr,
                          width: width / 3,
                          borderRadius: BorderRadius.zero,
                          bgColor: bodycolor,
                          textColor: primarycolor,
                          onPressed: () => Get.toNamed('/login')),
                    ],
                  ),
                  Devider(size: 15),
                ],
              ),
            ),
          ),
        ));
  }
}
