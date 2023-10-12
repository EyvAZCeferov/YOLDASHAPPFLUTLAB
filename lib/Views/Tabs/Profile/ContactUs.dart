import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:yoldashapp/Controllers/ContactusController.dart';
import 'package:yoldashapp/Functions/helpers.dart';
import 'package:yoldashapp/models/settings.dart';
import '../../../Constants/BaseAppBar.dart';
import '../../../Constants/ButtonElement.dart';
import '../../../Constants/Devider.dart';
import '../../../Constants/InputElement.dart';
import '../../../Constants/LoaderScreen.dart';
import '../../../Constants/StaticText.dart';
import '../../../Theme/ThemeService.dart';

class ContactUs extends StatelessWidget {
  final ContactusController _controller = Get.put(ContactusController());

  List types = [
    'mobilePhone',
    'homePhone',
    'facebookUrl',
    'instagramUrl',
    'youtubemUrl',
    'email',
    'tiktok',
  ];

  Widget _buildsocialmediabuttonlinks(type) {
    SocialMedia? socialVal = _controller.settingModel.value?.socialMedia;
    if (socialVal != null) {
      if (type == "mobilePhone" &&
          socialVal.mobilePhone != null &&
          socialVal.mobilePhone != '' &&
          socialVal.mobilePhone != ' ') {
        return GestureDetector(
          onTap: () => launchUrlTOSITE("tel:${socialVal.mobilePhone}"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: EdgeInsets.only(right: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: iconcolor, style: BorderStyle.solid, width: 1),
              color: whitecolor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.mobile,
                  color: iconcolor,
                  size: normaltextSize,
                ),
                SizedBox(width: 10),
                StaticText(
                  color: iconcolor,
                  size: normaltextSize,
                  text: "${socialVal.mobilePhone}",
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      } else if (type == "homePhone" &&
          socialVal.homePhone != null &&
          socialVal.homePhone != '' &&
          socialVal.homePhone != ' ') {
        return GestureDetector(
          onTap: () => launchUrlTOSITE("tel:${socialVal.homePhone}"),
          child: Container(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: iconcolor, style: BorderStyle.solid, width: 1),
              color: whitecolor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.phone,
                  color: iconcolor,
                  size: normaltextSize,
                ),
                SizedBox(width: 10),
                StaticText(
                  color: iconcolor,
                  size: normaltextSize,
                  text: "${socialVal.homePhone}",
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      } else if (type == "email" &&
          socialVal.email != null &&
          socialVal.email != '' &&
          socialVal.email != ' ') {
        return GestureDetector(
          onTap: () => launchUrlTOSITE("mailto:${socialVal.email}"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                  color: iconcolor, style: BorderStyle.solid, width: 1),
              color: whitecolor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.mail,
                  color: iconcolor,
                  size: normaltextSize,
                ),
                SizedBox(width: 10),
                StaticText(
                  color: iconcolor,
                  size: normaltextSize,
                  text: "${socialVal.email}",
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      } else if (type == "facebookUrl" &&
          socialVal.facebookUrl != null &&
          socialVal.facebookUrl != '' &&
          socialVal.facebookUrl != ' ') {
        return GestureDetector(
          onTap: () => launchUrlTOSITE("${socialVal.facebookUrl}"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                  color: iconcolor, style: BorderStyle.solid, width: 1),
              color: whitecolor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.facebook,
                  color: iconcolor,
                  size: normaltextSize,
                ),
                SizedBox(width: 10),
                StaticText(
                  color: iconcolor,
                  size: normaltextSize,
                  text: "YOLDASH",
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      } else if (type == "instagramUrl" &&
          socialVal.instagramUrl != null &&
          socialVal.instagramUrl != '' &&
          socialVal.instagramUrl != ' ') {
        return GestureDetector(
          onTap: () => launchUrlTOSITE("${socialVal.instagramUrl}"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                  color: iconcolor, style: BorderStyle.solid, width: 1),
              color: whitecolor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.instagram,
                  color: iconcolor,
                  size: normaltextSize,
                ),
                SizedBox(width: 10),
                StaticText(
                  color: iconcolor,
                  size: normaltextSize,
                  text: "YOLDASH",
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      } else if (type == "youtubeUrl" &&
          socialVal.youtubeUrl != null &&
          socialVal.youtubeUrl != '' &&
          socialVal.youtubeUrl != ' ') {
        return GestureDetector(
          onTap: () => launchUrlTOSITE("${socialVal.youtubeUrl}"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                  color: iconcolor, style: BorderStyle.solid, width: 1),
              color: whitecolor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.youtube,
                  color: iconcolor,
                  size: normaltextSize,
                ),
                SizedBox(width: 10),
                StaticText(
                  color: iconcolor,
                  size: normaltextSize,
                  text: "${socialVal.youtubeUrl}",
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      } else if (type == "tiktok" &&
          socialVal.tiktok != null &&
          socialVal.tiktok != '' &&
          socialVal.tiktok != ' ') {
        return GestureDetector(
          onTap: () => launchUrlTOSITE("${socialVal.tiktok}"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                  color: iconcolor, style: BorderStyle.solid, width: 1),
              color: whitecolor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.tiktok,
                  color: iconcolor,
                  size: normaltextSize,
                ),
                SizedBox(width: 10),
                StaticText(
                  color: iconcolor,
                  size: normaltextSize,
                  text: "${socialVal.tiktok}",
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      } else {
        return SizedBox();
      }
    } else {
      return SizedBox();
    }
  }

ContactUs(){
  _controller.fetchSettings();
}

  @override
  Widget build(BuildContext context) {
    

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        title: "contact".tr,
        changeprof: false,
        titlebg: false,
      ),
      body: Obx(
        () => _controller.refreshpage.value == true
            ? LoaderScreen()
            : SingleChildScrollView(
              controller: ScrollController(),
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Devider(),
                  SizedBox(
                    height: 50,
                    width: Get.width - 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        var dat = types[index];
                        return _buildsocialmediabuttonlinks(dat);
                      },
                    ),
                  ),
                  Devider(
                    size: 30,
                  ),
                  StaticText(
                      text: 'reguestnow'.tr,
                      weight: FontWeight.w500,
                      size: headingSize,
                      color: darkcolor),
                  Devider(
                    size: 30,
                  ),
                  _controller.responseanswer.value != null &&
                          _controller.responseanswer.value != '' &&
                          _controller.responseanswer.value != ' '
                      ? StaticText(
                          text: _controller.responseanswer.value.toString(),
                          weight: FontWeight.bold,
                          size: subHeadingSize,
                          color: darkcolor,
                          align: TextAlign.center,
                          textOverflow: TextOverflow.ellipsis,
                        )
                      : SizedBox(),
                  Devider(
                    size: 20,
                  ),
                  Container(
                    width: width - 40,
                    height: 53,
                    decoration: BoxDecoration(
                        color: whitecolor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: InputElement(
                        placeholder: "name_surname".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        inputType: TextInputType.text,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _controller.namesurnamecontroller.value),
                  ),
                  Devider(size: 10),
                  Container(
                    width: width - 40,
                    height: 53,
                    decoration: BoxDecoration(
                        color: whitecolor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: InputElement(
                        placeholder: "email".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        inputType: TextInputType.emailAddress,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _controller.emailcontroller.value),
                  ),
                  Devider(size: 10),
                  Container(
                    width: width - 40,
                    height: 53,
                    decoration: BoxDecoration(
                        color: whitecolor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: InputElement(
                        placeholder: "mobile_phone".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        inputType: TextInputType.text,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _controller.phonecontroller.value),
                  ),
                  Devider(size: 10),
                  Container(
                    width: width - 40,
                    height: 53,
                    decoration: BoxDecoration(
                        color: whitecolor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: InputElement(
                        placeholder: "subject".tr,
                        accentColor: primarycolor,
                        textColor: bodycolor,
                        inputType: TextInputType.text,
                        cornerradius: BorderRadius.all(Radius.circular(50)),
                        controller: _controller.subjectcontroller.value),
                  ),
                  Devider(size: 10),
                  Container(
                      width: width - 40,
                      height: 150,
                      decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25))),
                      child: TextField(
                        controller: _controller.messagecontroller.value,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        minLines: 5,
                        decoration: InputDecoration(
                          hintText: "message".tr,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        ),
                      )),
                  Devider(size: 25),
                  ButtonElement(
                      text: "reguestnow".tr,
                      height: 50,
                      width: width - 40,
                      borderRadius: BorderRadius.circular(45),
                      onPressed: () => _controller.sendmessage(context)),
                  Devider(size: 25),
                ],
              ),
            ),
      ),
    );
  }
}
