import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Controllers/AuthController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class ProfileInformation extends StatefulWidget {
  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  final String authtype = "driver";
  final AuthController _controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "editprofile".tr,
          changeprof: false,
          titlebg: false,
          authtype: authtype,
        ),
        body: SingleChildScrollView(
            controller: ScrollController(),
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                textBaseline: TextBaseline.alphabetic,
                textDirection: TextDirection.ltr,
                verticalDirection: VerticalDirection.down,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Obx(() {
                          final imageFile = _controller.imageFile.value;
                          return CircleAvatar(
                            backgroundColor: primarycolor,
                            foregroundColor: whitecolor,
                            radius: 50,
                            backgroundImage: imageFile != null
                                ? FileImage(File(imageFile.path))
                                    as ImageProvider<Object>
                                : NetworkImage(
                                    'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
                          );
                        }),
                        Positioned(
                            right: -1,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: secondarycolor,
                                  borderRadius: BorderRadius.circular(40)),
                              child: IconButtonElement(
                                icon: FeatherIcons.camera,
                                onPressed: () => _controller.pickImage(context),
                                color: whitecolor,
                                size: buttontextSize,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Devider(size: 15),
                  Center(
                      child: Container(
                    width: width - 40,
                    child: InputElement(
                      accentColor: darkcolor,
                      placeholder: "name_surname".tr,
                      textColor: darkcolor,
                      cornerradius: BorderRadius.circular(15),
                      inputType: TextInputType.text,
                      controller: _controller.namesurnamecontroller.value,
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                  )),
                  Center(
                      child: Container(
                    width: width - 40,
                    child: InputElement(
                      accentColor: darkcolor,
                      placeholder: "email".tr,
                      textColor: darkcolor,
                      cornerradius: BorderRadius.circular(15),
                      inputType: TextInputType.emailAddress,
                      controller: _controller.emailcontroller.value,
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                  )),
                  Center(
                      child: Container(
                    width: width - 40,
                    child: InputElement(
                      accentColor: darkcolor,
                      placeholder: "mobile_phone".tr,
                      textColor: darkcolor,
                      cornerradius: BorderRadius.circular(15),
                      inputType: TextInputType.phone,
                      controller: _controller.phonecontroller.value,
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                  )),
                ])),
        bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonElement(
                text: "updateprofile".tr,
                height: 50,
                width: width - 100,
                borderRadius: BorderRadius.circular(45),
                onPressed: () => _controller.updateprofiledata()),
          ),
        ));
  }
}
