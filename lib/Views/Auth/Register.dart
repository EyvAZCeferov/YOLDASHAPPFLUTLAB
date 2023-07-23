import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/DateElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageButton.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Constants/LoaderScreen.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TextButton.dart';
import 'package:yoldash/Controllers/AuthController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthController _controller = Get.put(AuthController());
  Map<String, bool> items = {
    'male': true,
    'female': false,
  };

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    void _showgendermodal(controller) {
      print(controller);
      Get.bottomSheet(Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            Devider(),
            StaticText(
              color: secondarycolor,
              size: buttontextSize,
              text: "gender".tr,
              weight: FontWeight.w500,
              align: TextAlign.center,
            ),
            Devider(),
            SizedBox(
              width: width,
              height: 120,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final keysList = items.keys.toList();
                  final valuesList = items.values.toList();

                  final key = keysList[index];
                  final value = valuesList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        title: StaticText(
                          color: darkcolor,
                          size: normaltextSize,
                          text: "gender_$key".tr,
                          weight: FontWeight.w500,
                          align: TextAlign.left,
                        ),
                        trailing: Radio<bool>(
                          value: true,
                          activeColor: primarycolor,
                          focusColor: primarycolor,
                          hoverColor: primarycolor,
                          toggleable: true,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          groupValue: items[key],
                          onChanged: (value) {
                            setState(() {
                              items.forEach((key, value) {
                                items[key] = false;
                              });
                              items[key] = value!;
                            });
                            print(items);
                          },
                        ),
                      ),
                      Devider(),
                    ],
                  );
                },
              ),
            ),
            Devider(),
            ButtonElement(
              text: "choise".tr,
              width: 90,
              onPressed: () => Get.back(),
              bgColor: primarycolor,
              borderRadius: BorderRadius.circular(45),
              fontsize: normaltextSize,
              height: 45,
              textColor: whitecolor,
            ),
            Devider(),
          ],
        ),
      ));
    }

    return Scaffold(
        backgroundColor: bodycolor,
        resizeToAvoidBottomInset: true,
        body: _controller.refreshpage.value == true
            ? LoaderScreen()
            : SingleChildScrollView(
                child: Container(
                  child: Obx(
                    () => Center(
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
                                  borderRadius:
                                      BorderRadius.circular(width - 40 / 2),
                                  border: Border.all(
                                      color: primarycolor,
                                      style: BorderStyle.solid,
                                      width: 2)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        _controller.authType.value = "rider",
                                    child: Container(
                                      width: width / 2.3,
                                      height: 47,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: _controller.authType.value ==
                                                "rider"
                                            ? primarycolor
                                            : whitecolor,
                                      ),
                                      child: StaticText(
                                        color: _controller.authType.value ==
                                                "rider"
                                            ? whitecolor
                                            : darkcolor,
                                        size: normaltextSize,
                                        weight: FontWeight.w500,
                                        align: TextAlign.center,
                                        text: "rider".tr,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        _controller.authType.value = "driver",
                                    child: Container(
                                      width: width / 2.3,
                                      height: 47,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: _controller.authType.value ==
                                                "driver"
                                            ? primarycolor
                                            : whitecolor,
                                      ),
                                      child: StaticText(
                                        color: _controller.authType.value ==
                                                "driver"
                                            ? whitecolor
                                            : darkcolor,
                                        size: normaltextSize,
                                        weight: FontWeight.w500,
                                        align: TextAlign.center,
                                        text: "driver".tr,
                                      ),
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
                            width: width - 40,
                            height: 53,
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: InputElement(
                                placeholder: "name_surname".tr,
                                accentColor: primarycolor,
                                textColor: bodycolor,
                                inputType: TextInputType.text,
                                cornerradius:
                                    BorderRadius.all(Radius.circular(50)),
                                controller:
                                    _controller.namesurnamecontroller.value),
                          ),
                          Devider(size: 15),
                          GestureDetector(
                            onTap: () => _showgendermodal(
                                _controller.gendercontroller.value),
                            child: Container(
                              width: width - 40,
                              height: 53,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: primarycolor,
                                      style: BorderStyle.solid,
                                      width: 1),
                                  color: whitecolor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: StaticText(
                                text: "gender".tr,
                                color: iconcolor,
                                size: normaltextSize,
                                weight: FontWeight.w500,
                                align: TextAlign.left,
                              ),
                            ),
                          ),
                          Devider(size: 15),
                          Container(
                            width: width - 40,
                            height: 53,
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
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
                            width: width - 40,
                            height: 53,
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: InputElement(
                                placeholder: "email".tr,
                                accentColor: primarycolor,
                                textColor: bodycolor,
                                inputType: TextInputType.emailAddress,
                                cornerradius:
                                    BorderRadius.all(Radius.circular(50)),
                                controller: _controller.emailcontroller.value),
                          ),
                          Devider(size: 15),
                          Container(
                            width: width - 40,
                            height: 53,
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: InputElement(
                                placeholder: "mobile_phone".tr,
                                accentColor: primarycolor,
                                textColor: bodycolor,
                                inputType: TextInputType.text,
                                cornerradius:
                                    BorderRadius.all(Radius.circular(50)),
                                controller: _controller.phonecontroller.value),
                          ),
                          Devider(size: 15),
                          _controller.authType.value == "rider"
                              ? SizedBox()
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      StaticText(
                                        color: darkcolor,
                                        size: normaltextSize,
                                        weight: FontWeight.w500,
                                        align: TextAlign.left,
                                        text: "langinformations".tr,
                                      ),
                                      Devider(size: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () => _controller
                                                .selectlangknowns('az'),
                                            child: SizedBox(
                                              width: 90,
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: _controller
                                                                      .selectedlang
                                                                      .value
                                                                      .contains(
                                                                          'az') ==
                                                                  true
                                                              ? primarycolor
                                                              : whitecolor,
                                                          width: 4,
                                                        ),
                                                      ),
                                                      child: CountryFlag(
                                                        country: Country.az,
                                                        height: 28,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  StaticText(
                                                      text: "AZE",
                                                      weight: FontWeight.w400,
                                                      size: normaltextSize,
                                                      color: darkcolor),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => _controller
                                                .selectlangknowns('ru'),
                                            child: SizedBox(
                                              width: 90,
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: _controller
                                                                      .selectedlang
                                                                      .value
                                                                      .contains(
                                                                          'ru') ==
                                                                  true
                                                              ? primarycolor
                                                              : whitecolor,
                                                          width: 4,
                                                        ),
                                                      ),
                                                      child: CountryFlag(
                                                        country: Country.ru,
                                                        height: 28,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  StaticText(
                                                      text: "RU",
                                                      weight: FontWeight.w400,
                                                      size: normaltextSize,
                                                      color: darkcolor),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => _controller
                                                .selectlangknowns('en'),
                                            child: SizedBox(
                                              width: 90,
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: _controller
                                                                      .selectedlang
                                                                      .value
                                                                      .contains(
                                                                          'en') ==
                                                                  true
                                                              ? primarycolor
                                                              : whitecolor,
                                                          width: 4,
                                                        ),
                                                      ),
                                                      child: CountryFlag(
                                                        country: Country.gb,
                                                        height: 28,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  StaticText(
                                                      text: "EN",
                                                      weight: FontWeight.w400,
                                                      size: normaltextSize,
                                                      color: darkcolor),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => _controller
                                                .selectlangknowns('tr'),
                                            child: SizedBox(
                                              width: 90,
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: _controller
                                                                      .selectedlang
                                                                      .value
                                                                      .contains(
                                                                          'tr') ==
                                                                  true
                                                              ? primarycolor
                                                              : whitecolor,
                                                          width: 4,
                                                        ),
                                                      ),
                                                      child: CountryFlag(
                                                        country: Country.tr,
                                                        height: 28,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  StaticText(
                                                      text: "TR",
                                                      weight: FontWeight.w400,
                                                      size: normaltextSize,
                                                      color: darkcolor),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Devider(size: 15),
                                      Container(
                                          width: width - 40,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: whitecolor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          child: TextField(
                                            controller: _controller
                                                .aboutcontroller.value,
                                            keyboardType: TextInputType.text,
                                            maxLines: 5,
                                            minLines: 5,
                                            decoration: InputDecoration(
                                              hintText: "writeaboutyou".tr,
                                              fillColor: Colors.white,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15,
                                                  top: 10,
                                                  bottom: 10),
                                            ),
                                          )),
                                    ]),
                          Devider(size: 25),
                          ButtonElement(
                              text: "register".tr,
                              height: 50,
                              width: width - 40,
                              borderRadius: BorderRadius.circular(45),
                              onPressed: () => _controller.register(context)),
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
                                image:
                                    AssetImage('assets/images/facebook.webp'),
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
                ),
              ));
  }
}
