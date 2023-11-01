import 'package:dash_flags/dash_flags.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../Constants/ButtonElement.dart';
import '../../Constants/DateElement.dart';
import '../../Constants/Devider.dart';
import '../../Constants/DocumentRow.dart';
import '../../Constants/ImageClass.dart';
import '../../Constants/InputElement.dart';
import '../../Constants/LoaderScreen.dart';
import '../../Constants/StaticText.dart';
import '../../Constants/TextButton.dart';
import '../../Controllers/AuthController.dart';
import '../../Functions/helpers.dart';
import '../../Theme/ThemeService.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            color: bodycolor,
            child:DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content:  StaticText(
                align: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
                  text: "Applikasiyadan çıxmaq üçün 2 dəfə geri düyməsinə toxunun.",
                  weight: FontWeight.bold,
                  size: 12,
                  color: whitecolor),
            ),
            child:  Obx(
              () => _controller.refreshpage.value == true
                  ? LoaderScreen()
                  : Center(
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
                                  url: './assets/images/yoldash_bg_white.png')),
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
                            onTap: () => _controller.showgendermodal(context),
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
                                text: _controller.gender.value != null &&
                                        _controller.gender.value == 1
                                    ? "gender_male".tr
                                    : "gender_female".tr,
                                color: iconcolor,
                                size: normaltextSize,
                                weight: FontWeight.w400,
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
                                _controller.birthdaycontroller.value =
                                    selectedDate.toString();
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
                            height: 60,
                            decoration: BoxDecoration(
                                color: whitecolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
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
                          Devider(size: 10),
                          _controller.authType.value == "rider"
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    StaticText(
                                      text: "social_status".tr,
                                      weight: FontWeight.bold,
                                      size: subHeadingSize,
                                      color: darkcolor,
                                      align: TextAlign.left,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 190,
                                      width: width - 50,
                                      child: ListView.builder(
                                          itemCount: _controller
                                              .social_statuses.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            var val = _controller
                                                .social_statuses[index];
                                            return ListTile(
                                              title: StaticText(
                                                color: darkcolor,
                                                size: normaltextSize,
                                                text: val == ''
                                                    ? 'social_status_no'.tr
                                                    : "social_status_$val".tr,
                                                weight: FontWeight.w500,
                                              align: TextAlign.left,
                                              ),
                                              trailing: Radio<bool>(
                                                value: true,
                                                activeColor: primarycolor,
                                                focusColor: primarycolor,
                                                hoverColor: primarycolor,
                                                toggleable: true,
                                                visualDensity: VisualDensity
                                                    .adaptivePlatformDensity,
                                                groupValue: _controller
                                                            .socialstatus
                                                            .value ==
                                                        val
                                                    ? true
                                                    : false,
                                                onChanged: (value) {
                                                  _controller
                                                      .socialstatus.value = val;
                                                },
                                              ),
                                            );
                                          }),
                                    ),
                                    Devider(),
                                    _controller.socialstatus.value != null &&
                                            _controller.socialstatus.value != ''
                                        ? DocumentRow(
                                            title: "Şəxsiyyət vəsiqəsi",
                                            subtitle: "uploadimage".tr,
                                            onPressed: () => _controller
                                                .pickImageTesdigleyici(
                                                    "human_document",
                                                    context),
                                            data: _controller
                                                .human_document.value,
                                          )
                                        : SizedBox(),

                                         Devider(),
                                    _controller.socialstatus.value != null &&
                                            _controller.socialstatus.value != ''
                                        ? DocumentRow(
                                            title: _controller
                                                        .socialstatus.value ==
                                                    'telebe'
                                                ? 'Tələbə bileti'
                                                : 'Təsdiqləyici sənəd',
                                            subtitle: "uploadimage".tr,
                                            onPressed: () => _controller
                                                .pickImageTesdigleyici(
                                                    "submitting_document",
                                                    context),
                                            data: _controller
                                                .submitting_document.value,
                                          )
                                        : SizedBox(),
                                  ],
                                )
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
                                            onTap: () =>
                                                _controller.selectlangknowns(
                                                    'az', context),
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
                                                      color: _controller
                                                                  .selectedlang
                                                                  .value
                                                                  .contains(
                                                                      'az') ==
                                                              true
                                                          ? primarycolor
                                                          : darkcolor),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                _controller.selectlangknowns(
                                                    'ru', context),
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
                                                      color: _controller
                                                                  .selectedlang
                                                                  .value
                                                                  .contains(
                                                                      'ru') ==
                                                              true
                                                          ? primarycolor
                                                          : darkcolor),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                _controller.selectlangknowns(
                                                    'en', context),
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
                                                      color: _controller
                                                                  .selectedlang
                                                                  .value
                                                                  .contains(
                                                                      'en') ==
                                                              true
                                                          ? primarycolor
                                                          : darkcolor),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                _controller.selectlangknowns(
                                                    'tr', context),
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
                                                      color: _controller
                                                                  .selectedlang
                                                                  .value
                                                                  .contains(
                                                                      'tr') ==
                                                              true
                                                          ? primarycolor
                                                          : darkcolor),
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
                          Devider(size: 5),
                          Center(
                            child: SizedBox(
                              width: Get.width - 50,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _controller.agreeterms.value,
                                    onChanged: (newValue) {
                                      _controller.agreeterms.value = newValue!;
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () => launchUrlTOSITE(
                                          "https://yoldash.app/az/pages/terms-of-use"),
                                      child: StaticText(
                                        color: secondarycolor,
                                        size: normaltextSize,
                                        text: "agreetermsandconditions".tr,
                                        weight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Devider(size: 25),
                          ButtonElement(
                              text: "register".tr,
                              height: 50,
                              width: width - 40,
                              borderRadius: BorderRadius.circular(45),
                              onPressed: () => _controller.register(context)),
                          Devider(size: 25),
                        
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
          )),
        ));
  }
}
