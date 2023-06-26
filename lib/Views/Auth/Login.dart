import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Constants/StaticText.dart';
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
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: [
                Container(
                    width: width - 100,
                    height: width / 3.5,
                    child: ImageClass(
                        type: false,
                        url: '/assets/images/yoldash_bg_white.png')),
                Devider(
                  size: 60,
                ),
                StaticText(
                    text: 'login'.tr,
                    weight: FontWeight.w500,
                    size: headingSize,
                    color: darkcolor),
                Devider(
                  size: 20,
                ),
                StaticText(
                    text: 'login_with_mobile_number'.tr,
                    weight: FontWeight.w400,
                    size: smalltextSize,
                    color: darkcolor),
                Devider(size: 20),
                Container(
                  width: width - 100,
                  child: InputElement(
                      placeholder: "mobile_phone".tr,
                      accentColor: primarycolor,
                      textColor: bodycolor,
                      cornerradius: BorderRadius.all(Radius.circular(50)),
                      controller: _phonenumberController),
                ),
                Devider(size: 20),
                ButtonElement(
                    text: "sendcode".tr,
                    height: 50,
                    width: width - 100,
                    borderRadius: BorderRadius.circular(45),
                    onPressed: () => print("A")),
                Devider(size: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ],
            ),
          ),
        ));
  }
}
