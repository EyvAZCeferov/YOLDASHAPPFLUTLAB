import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Constants/BaseAppBar.dart';
import '../../Constants/ButtonElement.dart';
import '../../Constants/Devider.dart';
import '../../Constants/StaticText.dart';
import '../../Constants/TextButton.dart';
import '../../Controllers/AuthController.dart';
import '../../Functions/CacheManager.dart';
import '../../Theme/ThemeService.dart';

class VerificationCode extends StatefulWidget {
  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final AuthController _controller = Get.put(AuthController());
  final TextEditingController pincontroller = TextEditingController();
  var phoneNumber;

  @override
  void initState() {
    super.initState();
    _setPhoneNumber();
  }

  void _setPhoneNumber() async {
    Map<String, dynamic> arguments = Get.arguments;
    var phone = await CacheManager.getvaluefromsharedprefences("phone");
    setState(() => phoneNumber = arguments['phoneNumber'] ?? phone);
  }

  @override
  void dispose() {
    pincontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bodycolor,
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          backbutton: true,
        ),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: StaticText(
                align: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
                text:
                    "Applikasiyadan çıxmaq üçün 2 dəfə geri düyməsinə toxunun.",
                weight: FontWeight.bold,
                size: 12,
                  color: whitecolor),
          ),
          child: SingleChildScrollView(
            child: Column(
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
                    text: "sendedcodephone"
                        .trParams({'phoneNumber': phoneNumber}),
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
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15),
                        fieldHeight: 58,
                        fieldWidth: 71,
                        activeFillColor: secondarycolor,
                        activeBorderWidth: 1,
                        activeColor: whitecolor,
                        borderWidth: 1,
                        disabledColor: bodycolor,
                        inactiveColor: whitecolor,
                        errorBorderColor: errorcolor,
                        errorBorderWidth: 1,
                        inactiveFillColor: whitecolor,
                        selectedColor: whitecolor,
                        selectedFillColor: secondarycolor,
                        selectedBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        disabledBorderWidth: 1),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: bodycolor,
                    enableActiveFill: true,
                    controller: pincontroller,
                    onCompleted: (v) {
                      _controller.verifycode(
                          pincontroller.text, phoneNumber, context);
                    },
                    beforeTextPaste: (text) {
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
                        onPressed: () {
                          pincontroller.text = "";
                          _controller.resendcode(phoneNumber, context);
                        }),
                  ],
                ),
                Devider(size: 80),
                ButtonElement(
                    text: "submit".tr,
                    height: 50,
                    width: width - 40,
                    borderRadius: BorderRadius.circular(45),
                    onPressed: () => _controller.verifycode(
                        pincontroller.text, phoneNumber, context)),
                Devider(size: 10),
              ],
            ),
          ),
        ));
  }
}
