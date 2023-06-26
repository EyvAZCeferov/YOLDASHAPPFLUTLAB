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
import 'package:yoldash/Theme/ThemeService.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phonenumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: bodycolor,
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Devider(size: 60),
                  Container(
                      width: width - 100,
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
                  Container(
                    width: width - 100,
                    child: InputElement(
                        placeholder: "name_surname".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _phonenumberController),
                  ),
                  Devider(size: 15),
                  Container(
                    width: width - 100,
                    child: InputElement(
                        placeholder: "gender".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _phonenumberController),
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
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _phonenumberController),
                  ),
                  Devider(size: 15),
                  Container(
                    width: width - 100,
                    child: InputElement(
                        placeholder: "mobile_phone".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _phonenumberController),
                  ),
                  Devider(size: 15),
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
                    size: 30,
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
