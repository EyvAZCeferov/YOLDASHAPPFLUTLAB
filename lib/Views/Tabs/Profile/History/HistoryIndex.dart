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

  Color getstatcolor(String? type) {
    if (type == "waiting" || type == "changed") {
      return Color(0xffffcc00);
    } else if (type == "completed") {
      return Color(0xff339900);
    } else if (type == "notcompleted" || type == "cancelled") {
      return Color(0xffcc3300);
    } else if (type == "ontheway") {
      return Color(0xffff9966);
    } else {
      return Color(0xffffcc00);
    }
  }

  List<Widget> getaddress(Rides ride) {
    if (ride.coordinates != null) {
      List<Widget> elements = [];
      for (var address in ride.coordinates!) {
        elements.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StaticText(
              color: secondarycolor,
              size: smalltextSize,
              text: address.address as String,
              weight: FontWeight.bold,
            ),
            Devider(),
          ],
        ));
      }

      return elements;
    } else {
      List<Widget> elements = [];
      return elements;
    }
  }

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
                            height: 300,
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
                                    color: getstatcolor(ride?.status),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: StaticText(
                                    color: whitecolor,
                                    size: smalltextSize,
                                    weight: FontWeight.w500,
                                    align: TextAlign.center,
                                    text: "ride_${ride?.status}".tr,
                                  ),
                                ),
                                Devider(size: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 44,
                                      height: 110,
                                      child: ImageClass(
                                          url:
                                              "assets/images/destinationicon.png",
                                          type: false),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: getaddress(ride),
                                      ),
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
                                            text: "yer_sayi".trParams({
                                              'counter': ride.automobil
                                                      ?.autotype?.places
                                                      .toString() ??
                                                  '4'
                                            }),
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
                                      text: ride.priceOfWay.toString(),
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
