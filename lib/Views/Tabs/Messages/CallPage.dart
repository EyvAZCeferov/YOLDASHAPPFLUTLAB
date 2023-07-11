import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/CallingController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class CallPage extends StatelessWidget {
  final String type;
  final CallingController _controller = Get.put(CallingController());
  final String? typepage =
      Get.arguments != null ? Get.arguments['type'] as String : 'calling';
  CallPage({Key? key, this.type = 'calling'}) : super(key: key);

  Widget _toolbar(width) {
    return Center(
      child: Obx(
        () => Container(
          width: width - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: () =>
                    _controller.muted.value = !_controller.muted.value,
                animationDuration: Duration(milliseconds: 300),
                elevation: 2,
                fillColor: primarycolor,
                shape: const CircleBorder(),
                padding: EdgeInsets.all(15),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: Icon(
                  _controller.muted.value == true
                      ? FeatherIcons.micOff
                      : FeatherIcons.mic,
                  color: whitecolor,
                  size: buttontextSize,
                ),
              ),
              RawMaterialButton(
                onPressed: () => Get.back(),
                animationDuration: Duration(milliseconds: 300),
                elevation: 2,
                fillColor: errorcolor,
                shape: const CircleBorder(),
                padding: EdgeInsets.all(25),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: Icon(
                  FeatherIcons.phoneOff,
                  color: whitecolor,
                  size: headingSize,
                ),
              ),
              type == "video"
                  ? RawMaterialButton(
                      onPressed: () => print("flip cam"),
                      animationDuration: Duration(milliseconds: 300),
                      elevation: 2,
                      fillColor: errorcolor,
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(25),
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      child: Icon(
                        FeatherIcons.refreshCw,
                        color: whitecolor,
                        size: headingSize,
                      ),
                    )
                  : SizedBox(
                      width: 45,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Center containerArea(width) {
    final String type = _controller.type.value;
    if (type == "video") {
      return Center(
        child: Container(
          width: width - 40,
          height: width,
          color: errorcolor,
        ),
      );
    } else {
      return Center(
        child: Container(
          width: width - 40,
          height: width,
          decoration: BoxDecoration(
              color: whitecolor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurStyle: BlurStyle.solid,
                  color: Colors.black38,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: primarycolor,
                foregroundColor: whitecolor,
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
              ),
              SizedBox(
                height: 10,
              ),
              StaticText(
                  text: "Eyvaz Ceferov",
                  weight: FontWeight.bold,
                  size: subHeadingSize,
                  color: primarycolor)
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: false,
        changeprof: false,
        title: "calling".tr,
        titlebg: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [containerArea(width), _toolbar(width)],
      ),
    );
  }
}