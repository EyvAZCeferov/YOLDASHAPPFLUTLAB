import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Constants/LoaderScreen.dart';
import 'package:yoldash/Controllers/AuthController.dart';
import 'package:yoldash/Functions/CacheManager.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class ProfileInformation extends StatefulWidget {
  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  final AuthController _controller = Get.put(AuthController());
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
      var auth_id =
          await CacheManager.getvaluefromsharedprefences("auth_id") ?? '';
      var name_surname =
          await CacheManager.getvaluefromsharedprefences("name_surname") ?? '';
      var phone =
          ' ' + await CacheManager.getvaluefromsharedprefences("phone") ?? '';
      var email = await CacheManager.getvaluefromsharedprefences("email") ?? '';
      var profilepicture =
          await CacheManager.getvaluefromsharedprefences("profilepicture") ??
              'users/noprofilepicture.webp';
      if (profilepicture == null || profilepicture.isEmpty) {
        profilepicture = 'users/noprofilepicture.webp';
      }
      Map<String, dynamic> getData = {
        'auth_id': auth_id,
        'name_surname': name_surname,
        'email': email,
        'phone': phone,
        'profilepicture': profilepicture,
      };
      setState(() {
        userdatas = getData;
      });

      _controller.namesurnamecontroller.value.text = name_surname;
      _controller.emailcontroller.value.text = email;
      _controller.phonecontroller.value.text = phone;

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
