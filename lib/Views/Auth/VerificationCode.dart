import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TextButton.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class VerificationCode extends StatefulWidget {
  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final TextEditingController pincontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bodycolor,
      resizeToAvoidBottomInset: true,
      appBar: BaseAppBar(
        backbutton: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: [
          StaticText(
              text: "enter_verification_code".tr,
              weight: FontWeight.w500,
              size: buttontextSize,
              align: TextAlign.center,
              color: darkcolor),
          Devider(size: 10),
          StaticText(
              text:
                  "sendedcodephone".trParams({'phoneNumber': '+994516543290'}),
              weight: FontWeight.w400,
              size: smalltextSize,
              align: TextAlign.center,
              color: Colors.grey),
          Devider(size: 10),
          Container(
            width: width - 40,
            alignment: Alignment.center,
            child: PinCodeTextField(
              length: 4,
              obscureText: false,
              appContext: context,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(14),
                  fieldHeight: 55,
                  fieldWidth: 70,
                  activeFillColor: secondarycolor,
                  activeBorderWidth: 1,
                  activeColor: secondarycolor,
                  borderWidth: 1,
                  disabledColor: bodycolor,
                  inactiveColor: whitecolor,
                  errorBorderColor: errorcolor,
                  errorBorderWidth: 1,
                  inactiveFillColor: whitecolor,
                  selectedColor: secondarycolor,
                  selectedFillColor: secondarycolor,
                  selectedBorderWidth: 1,
                  inactiveBorderWidth: 1,
                  disabledBorderWidth: 1),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: bodycolor,
              enableActiveFill: true,
              controller: pincontroller,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
                // setState(() {
                //   currentText = value;
                // });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              autoFocus: true,
            ),
          ),
          Devider(size: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StaticText(
                  text: 'dontgetcode'.tr,
                  weight: FontWeight.w400,
                  size: smalltextSize,
                  color: darkcolor),
              TextButtonElement(
                  text: "resend".tr,
                  width: 140,
                  borderRadius: BorderRadius.zero,
                  bgColor: bodycolor,
                  textColor: secondarycolor,
                  onPressed: () => Get.toNamed('/register')),
            ],
          ),
          Devider(size: 80),
          ButtonElement(
              text: "submit".tr,
              height: 50,
              width: width - 40,
              borderRadius: BorderRadius.circular(45),
              onPressed: () => Get.toNamed('/verificationcode')),
          Devider(size: 10),
        ],
      ),
    );
  }
}
