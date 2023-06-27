import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageButton.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TextButton.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phonenumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: bodycolor,
        resizeToAvoidBottomInset: true,
        body: Container(
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
                  size: 45,
                ),
                StaticText(
                    text: 'login'.tr,
                    weight: FontWeight.w500,
                    size: headingSize,
                    color: darkcolor),
                Devider(
                  size: 30,
                ),
                StaticText(
                    text: 'login_with_mobile_number'.tr,
                    weight: FontWeight.w400,
                    size: smalltextSize,
                    color: darkcolor),
                Devider(size: 25),
                Container(
                  width: width - 100,
                  child: InputElement(
                      placeholder: "mobile_phone".tr,
                      accentColor: primarycolor,
                      textColor: bodycolor,
                      cornerradius: BorderRadius.all(Radius.circular(50)),
                      controller: _phonenumberController),
                ),
                Devider(size: 25),
                ButtonElement(
                    text: "sendcode".tr,
                    height: 50,
                    width: width - 100,
                    borderRadius: BorderRadius.circular(45),
                    onPressed: () => Get.toNamed('/verificationcode')),
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
                        text: 'doesnothaveaccount'.tr,
                        weight: FontWeight.w400,
                        size: smalltextSize,
                        color: darkcolor),
                    TextButtonElement(
                        text: "register".tr,
                        width: width / 3,
                        borderRadius: BorderRadius.zero,
                        bgColor: bodycolor,
                        textColor: primarycolor,
                        onPressed: () => Get.toNamed('/register')),
                  ],
                ),
                Devider(size: 15),
              ],
            ),
          ),
        ));
  }
}
