import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../Constants/BaseAppBar.dart';
import '../../../Constants/ButtonElement.dart';
import '../../../Constants/Devider.dart';
import '../../../Constants/IconButtonElement.dart';
import '../../../Constants/InputElement.dart';
import '../../../Constants/LoaderScreen.dart';
import '../../../Controllers/AuthController.dart';
import '../../../Functions/helpers.dart';
import '../../../Theme/ThemeService.dart';

class ProfileInformation extends StatelessWidget {
  final AuthController _controller = Get.find<AuthController>();

  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
  _controller.getalldataoncache(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "editprofile".tr,
          changeprof: false,
          titlebg: false,
          authtype: _controller.authType.value,
        ),
        body: Obx(
          () => _controller.refreshpage.value == true
              ? LoaderScreen()
              : SingleChildScrollView(
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
                                  radius: 50,
                                  backgroundImage: imageProvider,
                                ),
                              ),
                              Positioned(
                                  right: -1,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: secondarycolor,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: IconButtonElement(
                                      icon: FeatherIcons.camera,
                                      onPressed: () =>
                                          _controller.pickImage(context),
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
        ),
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
                onPressed: () => _controller.updateprofiledata(context)),
          ),
        ));
  }
}
