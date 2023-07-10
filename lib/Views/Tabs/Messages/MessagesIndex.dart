import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
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
                      height: 75,
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
                              SizedBox(width: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StaticText(
                                      text: "Eyvaz Ceferov",
                                      weight: FontWeight.w500,
                                      size: normaltextSize,
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
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                index % 2 == 0
                                    ? Container(
                                        width: 35,
                                        height: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: errorcolor,
                                        ),
                                        child: StaticText(
                                          color: whitecolor,
                                          size: smalltextSize,
                                          text: "1",
                                          weight: FontWeight.w500,
                                          align: TextAlign.center,
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    index % 2 == 0
                                        ? SizedBox()
                                        : Icon(FontAwesomeIcons.checkDouble,
                                            color: secondarycolor,
                                            size: buttontextSize),
                                    SizedBox(width: 10),
                                    StaticText(
                                      text: "15:19",
                                      weight: FontWeight.w400,
                                      size: smalltextSize,
                                      color: iconcolor,
                                      align: TextAlign.center,
                                    )
                                  ],
                                ),
                              ]),
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
