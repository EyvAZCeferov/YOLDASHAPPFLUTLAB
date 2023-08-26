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
import '../../../Functions/helpers.dart';
import '../../../Theme/ThemeService.dart';
import 'build_menu_items.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController _controller = Get.put(AuthController());
  final AutomobilsController automobilscontroller =
      Get.put(AutomobilsController());
  final BalanceController balancecontroller = Get.put(BalanceController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    balancecontroller.fetchData(context);
    _controller.getalldataoncache(context);
    return Scaffold(
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
            backbutton: false,
            title: "myaccount".tr,
            changeprof: true,
            titlebg: false,
            authtype: _controller.authType.value ?? 'rider',
            changeprofpage: () => _controller.changeprofpage(context)),
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
                        height: width / 4,
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
                              imageUrl: getimageurl(
                                  "user",
                                  'users',
                                  _controller
                                      .userdatas.value?.additionalinfo?.image),
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
                                        text: _controller
                                                .userdatas.value?.nameSurname ??
                                            '',
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FeatherIcons.phone,
                                      color: secondarycolor,
                                      size: normaltextSize,
                                    ),
                                    StaticText(
                                        text: _controller.userdatas.value!.phone
                                                .toString() ??
                                            '',
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
                        AddableWidget(type: 'cards', width: width),
                        Devider(size: 20),
                        _controller.authType.value == "driver"
                            ? AddableWidget(
                                width: width,
                                type: 'automobils',
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
