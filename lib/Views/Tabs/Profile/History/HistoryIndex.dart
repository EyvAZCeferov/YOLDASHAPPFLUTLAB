import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../Constants/BaseAppBar.dart';
import '../../../../Constants/Devider.dart';
import '../../../../Constants/ImageClass.dart';
import '../../../../Constants/LoaderScreen.dart';
import '../../../../Constants/StaticText.dart';
import '../../../../Controllers/HistoryController.dart';
import '../../../../Theme/ThemeService.dart';
import '../../../../models/rides.dart';

class HistoryIndex extends StatefulWidget {
  @override
  State<HistoryIndex> createState() => _HistoryIndexState();
}

class _HistoryIndexState extends State<HistoryIndex> {
  final HistoryController _controller = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    _controller.getRides(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "history".tr,
          changeprof: false,
          titlebg: false,
        ),
        body: Obx(() => _controller.refreshpage.value == true
            ? LoaderScreen()
            : _controller.data.length > 0
                ? RefreshIndicator(
                    onRefresh: () => _controller.getRides(context),
                    color: secondarycolor,
                    strokeWidth: 2,
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    backgroundColor: whitecolor,
                    child: ListView.builder(
                      itemCount: _controller.data.length,
                      itemBuilder: (context, index) {
                        Rides ride = _controller.data[index]!;
                        return GestureDetector(
                          onTap: () {
                            _controller.selectedRide.value = ride;
                            Get.toNamed('/history/${ride.id}');
                          },
                          child: Center(
                              child: Container(
                            width: width - 40,
                            height: width / 1.8,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.symmetric(vertical: 8),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Devider(size: 3),
                                Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? Color(0xffD9F4E5)
                                        : Color(0xffFCCDD6),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: StaticText(
                                    color: index % 2 == 0
                                        ? Color(0xff18C161)
                                        : Color(0xffF52D56),
                                    size: smalltextSize,
                                    weight: FontWeight.w500,
                                    align: TextAlign.center,
                                    text: index % 2 == 0
                                        ? "succed".tr
                                        : "cancelled".tr,
                                  ),
                                ),
                                Devider(size: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 44,
                                      height: 77,
                                      child: ImageClass(
                                          url:
                                              "assets/images/destinationicon.png",
                                          type: false),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        StaticText(
                                          color: darkcolor,
                                          size: smalltextSize,
                                          weight: FontWeight.w400,
                                          align: TextAlign.left,
                                          text: "Bakı",
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        StaticText(
                                          color: darkcolor,
                                          size: smalltextSize,
                                          weight: FontWeight.w400,
                                          align: TextAlign.left,
                                          text: "Xırdalan",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Devider(size: 3),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(FeatherIcons.user,
                                              color: primarycolor,
                                              size: buttontextSize),
                                          SizedBox(width: 5),
                                          StaticText(
                                            color: darkcolor,
                                            size: smalltextSize,
                                            align: TextAlign.left,
                                            weight: FontWeight.w400,
                                            text: "yer_sayi"
                                                .trParams({'counter': '2'}),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(FeatherIcons.briefcase,
                                              color: primarycolor,
                                              size: buttontextSize),
                                          SizedBox(width: 5),
                                          StaticText(
                                            color: darkcolor,
                                            size: smalltextSize,
                                            align: TextAlign.left,
                                            weight: FontWeight.w400,
                                            text: "baqaj"
                                                .trParams({'counter': '2'}),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Devider(size: 3),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    StaticText(
                                      text: "52AZN",
                                      weight: FontWeight.w600,
                                      size: subHeadingSize,
                                      color: primarycolor,
                                      align: TextAlign.left,
                                    ),
                                    StaticText(
                                      text: "02/05/2023",
                                      weight: FontWeight.w400,
                                      size: smalltextSize,
                                      color: iconcolor,
                                      align: TextAlign.right,
                                    )
                                  ],
                                ),
                                Devider(size: 3),
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
                  )));
  }
}
