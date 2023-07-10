import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/MessagesController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class MessagesIndex extends StatelessWidget {
  late MessagesController _controller = Get.put(MessagesController());

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
          title: "chat".tr,
          titlebg: false,
          bgcolorheader: whitecolor),
      body: Obx(() => _controller.data.length > 0
          ? RefreshIndicator(
              onRefresh: _controller.refreshData,
              color: secondarycolor,
              strokeWidth: 2,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              backgroundColor: whitecolor,
              child: ListView.builder(
                itemCount: _controller.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        Get.toNamed('/messages/$index', arguments: index),
                    child: Center(
                        child: Container(
                      width: width - 40,
                      height: 100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                              bottom: BorderSide(
                                  color: iconcolor,
                                  style: BorderStyle.solid,
                                  width: 1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: primarycolor,
                                foregroundColor: whitecolor,
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                              ),
                              SizedBox(width: 3),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StaticText(
                                      text: "Eyvaz Ceferov",
                                      weight: FontWeight.w500,
                                      size: buttontextSize,
                                      color: darkcolor,
                                      align: TextAlign.left),
                                  StaticText(
                                      text: "Salam",
                                      weight: FontWeight.w500,
                                      size: smalltextSize,
                                      color: iconcolor,
                                      align: TextAlign.left),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  );
                },
              ))
          : Center(
              child: StaticText(
                color: errorcolor,
                size: buttontextSize,
                weight: FontWeight.w500,
                align: TextAlign.center,
                text: "nohasdata".tr,
              ),
            )),
    );
  }
}
