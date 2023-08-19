import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../Constants/ButtonElement.dart';
import '../../Constants/Devider.dart';
import '../../Constants/ImageButton.dart';
import '../../Constants/ImageClass.dart';
import '../../Constants/LoaderScreen.dart';
import '../../Constants/StaticText.dart';
import '../../Constants/TextButton.dart';
import '../../Controllers/AuthController.dart';
import '../../Theme/ThemeService.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bodycolor,
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => _controller.refreshpage.value == true
              ? LoaderScreen()
              : SingleChildScrollView(
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Devider(size: 60),
                          Container(
                              width: width - 40,
                              height: 100,
                              child: ImageClass(
                                  type: false,
                                  url: './assets/images/yoldash_bg_white.png')),
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
                            width: width - 40,
                            child: IntlPhoneField(
                              cursorColor: primarycolor,
                              searchText: "search".tr,
                              dropdownIcon: Icon(FeatherIcons.arrowDown,
                                  color: secondarycolor, size: smalltextSize),
                              decoration: InputDecoration(
                                hintText: "mobile_phone".tr,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.only(
                                    left: 15, top: 10, bottom: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: Colors
                                        .red, // İstediğiniz renge ayarlayabilirsiniz
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: primarycolor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: primarycolor,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              initialCountryCode: 'AZ',
                              onChanged: (phone) {
                                var phonenumb =
                                    phone.countryCode + phone.number;
                                _controller.phonecontroller.value.text =
                                    phonenumb.toString();
                              },
                            ),
                          ),
                          Devider(size: 25),
                          ButtonElement(
                              text: "sendcode".tr,
                              height: 50,
                              width: width - 40,
                              borderRadius: BorderRadius.circular(45),
                              onPressed: () => _controller.login(context)),
                          Devider(size: 25),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageButton(
                                image: AssetImage('./assets/images/glogo.png'),
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
                                image:
                                    AssetImage('./assets/images/facebook.webp'),
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
                                image: AssetImage('./assets/images/apple.png'),
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
                  ),
                ),
        ));
  }
}
