import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../Constants/AddableWidget.dart';
import '../../../Constants/BaseAppBar.dart';
import '../../../Constants/ButtonElement.dart';
import '../../../Constants/Devider.dart';
import '../../../Constants/IconButtonElement.dart';
import '../../../Constants/LoaderScreen.dart';
import '../../../Constants/StaticText.dart';
import '../../../Controllers/AuthController.dart';
import '../../../Controllers/AutomobilsController.dart';
import '../../../Controllers/BalanceController.dart';
import '../../../Controllers/MainController.dart';
import '../../../Functions/helpers.dart';
import '../../../Theme/ThemeService.dart';
import 'build_menu_items.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController _controller = Get.put(AuthController());
  final MainController _maincontroller = Get.put(MainController());
  final AutomobilsController automobilscontroller =
      Get.put(AutomobilsController());
  final BalanceController balancecontroller = Get.put(BalanceController());
  Map<String, dynamic> userdatas = {
    'auth_id': '',
    'name_surname': '',
    'email': '',
    'phone': '',
    'profilepicture': 'users/noprofilepicture.webp',
  };

  @override
  void initState() {
    super.initState();
    getalldataoncache();
  }

  void getalldataoncache() async {
    try {
      _controller.refreshpage.value = true;
      var auth_id = await _maincontroller.getstoragedat('auth_id');

      var name_surname = await _maincontroller.getstoragedat('name_surname');
      var phone = ' ' + await _maincontroller.getstoragedat('phone');
      var email = await _maincontroller.getstoragedat('email')??null;
      var profilepicture =
          await _maincontroller.getstoragedat('profilepicture') ??
              'users/noprofilepicture.webp';
      if (profilepicture == null || profilepicture.isEmpty) {
        profilepicture = 'users/noprofilepicture.webp';
      }
      Map<String, dynamic> getData = {
        'auth_id': auth_id,
        'name_surname': name_surname,
        'email': ' ' + email,
        'phone': phone,
        'profilepicture': profilepicture,
      };
      print(getData);
      setState(() {
        userdatas = getData;
      });

      _controller.refreshpage.value = false;
    } catch (e) {
      _controller.refreshpage.value = false;
      Get.back();
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    balancecontroller.fetchData(context);
    return Scaffold(
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
            backbutton: false,
            title: "myaccount".tr,
            changeprof: true,
            titlebg: false,
            authtype: _controller.authType.value,
            changeprofpage: () => _controller.changeprofpage()),
        body: Obx(() => _controller.refreshpage.value == true
            ? LoaderScreen()
            : SingleChildScrollView(
                controller: ScrollController(),
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  textBaseline: TextBaseline.alphabetic,
                  textDirection: TextDirection.ltr,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    Center(
                      child: Container(
                        height: width / 3,
                        width: width - 40,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: whitecolor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurStyle: BlurStyle.solid,
                                color: Colors.black38,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageurl +
                                  userdatas['profilepicture'].toString(),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundColor: primarycolor,
                                foregroundColor: whitecolor,
                                radius: 35,
                                backgroundImage: imageProvider,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    StaticText(
                                        text: userdatas['name_surname'] ?? '',
                                        weight: FontWeight.bold,
                                        size: normaltextSize,
                                        color: darkcolor),
                                    IconButtonElement(
                                        color: secondarycolor,
                                        size: buttontextSize,
                                        icon: FeatherIcons.edit2,
                                        onPressed: () =>
                                            Get.toNamed("/profileinformation"))
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FeatherIcons.mail,
                                        color: secondarycolor,
                                        size: normaltextSize,
                                      ),
                                      StaticText(
                                          text: userdatas['email'] ?? '',
                                          weight: FontWeight.w500,
                                          size: smalltextSize,
                                          color: Colors.grey),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FeatherIcons.phone,
                                      color: secondarycolor,
                                      size: normaltextSize,
                                    ),
                                    StaticText(
                                        text: userdatas['phone'] ?? '',
                                        weight: FontWeight.w400,
                                        size: smalltextSize,
                                        color: Colors.grey),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Devider(
                      size: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Devider(),
                        _controller.authType.value == "driver"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.toNamed('/balance'),
                                    child: Container(
                                      width: width - 50,
                                      alignment: Alignment.center,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          color: whitecolor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              blurStyle: BlurStyle.solid,
                                              color: Colors.black38,
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                              spreadRadius: 0,
                                            )
                                          ]),
                                      child: balancecontroller
                                                  .refreshpage.value ==
                                              true
                                          ? LoaderScreen()
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                StaticText(
                                                  color: darkcolor,
                                                  size: buttontextSize,
                                                  weight: FontWeight.w600,
                                                  align: TextAlign.center,
                                                  text:
                                                      "${balancecontroller.totalprice.value} AZN",
                                                ),
                                                StaticText(
                                                  color: darkcolor,
                                                  size: smalltextSize,
                                                  weight: FontWeight.w400,
                                                  align: TextAlign.center,
                                                  text: "balance".tr,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Devider(size: 20),
                        Center(
                          child: Container(
                            width: width - 40,
                            height: width / 1.8,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: whitecolor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurStyle: BlurStyle.solid,
                                  color: Colors.black38,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: AddableWidget(type: 'cards'),
                          ),
                        ),
                        Devider(size: 20),
                        _controller.authType.value == "driver"
                            ? Center(
                                child: Container(
                                  width: width - 40,
                                  height: width / 1.8,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: whitecolor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        blurStyle: BlurStyle.solid,
                                        color: Colors.black38,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: AddableWidget(type: 'automobils'),
                                ),
                              )
                            : SizedBox(),
                        Devider()
                      ],
                    ),
                    Devider(),
                    build_menu_items(_controller.authType.value),
                    Devider(),
                  ],
                ),
              )),
        bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonElement(
                text: "logout".tr,
                height: 50,
                width: width - 100,
                borderRadius: BorderRadius.circular(45),
                onPressed: () => _controller.logout(context)),
          ),
        ));
  }
}
