import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/HistoryController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class HistoryShow extends StatelessWidget {
  final HistoryController _controller = Get.find<HistoryController>();

  final index = int.parse(Get.parameters['index'] ?? '');
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            bottom: width / 2,
            child: ImageClass(
              url: "/assets/images/mapbg.png",
              type: false,
              boxfit: BoxFit.cover,
            ),
          ),
          BaseAppBar(
            backbutton: true,
            changeprof: false,
            title: "historydetail".tr,
            titlebg: true,
          ),
          Positioned(
              top: 80,
              left: 20,
              width: width - 40,
              child: Container(
                width: width - 40,
                height: width / 3.5,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 44,
                          height: 77,
                          child: ImageClass(
                              url: "assets/images/destinationicon.png",
                              type: false),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                ),
              )),
          Positioned(
            top: width,
            child: Container(
              width: width,
              height: width / 1.3,
              color: whitecolor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Devider(),
                  StaticText(
                    color: darkcolor,
                    size: subHeadingSize,
                    align: TextAlign.left,
                    weight: FontWeight.w500,
                    text: "customers".tr,
                  ),
                  Devider(),
                  Center(
                    child: SizedBox(
                      width: width - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          StaticText(
                            color: darkcolor,
                            size: normaltextSize,
                            align: TextAlign.left,
                            weight: FontWeight.w500,
                            text: "total_price".tr,
                          ),
                          StaticText(
                            color: primarycolor,
                            size: buttontextSize,
                            align: TextAlign.right,
                            weight: FontWeight.w500,
                            text: "40 AZN",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Devider(),
                  SizedBox(
                    width: width,
                    height: width / 2.3,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Container(
                            width: width - 40,
                            height: 125,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: 7),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: whitecolor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurStyle: BlurStyle.solid,
                                    color: Colors.black38,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: primarycolor,
                                  foregroundColor: whitecolor,
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                      "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StaticText(
                                      color: darkcolor,
                                      size: normaltextSize,
                                      weight: FontWeight.w400,
                                      align: TextAlign.left,
                                      text: "Eyvaz Ceferov",
                                    ),
                                    StaticText(
                                      color: iconcolor,
                                      size: smalltextSize,
                                      weight: FontWeight.w400,
                                      align: TextAlign.left,
                                      text: "Arxa sol oturacaq",
                                    ),
                                    StaticText(
                                      color: iconcolor,
                                      size: smalltextSize,
                                      weight: FontWeight.w400,
                                      align: TextAlign.left,
                                      text: "Baqaj 100kg",
                                    ),
                                    StaticText(
                                      color: darkcolor,
                                      size: smalltextSize,
                                      weight: FontWeight.w600,
                                      align: TextAlign.left,
                                      text: "15 AZN",
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: buttontextSize,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: buttontextSize,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: buttontextSize,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: iconcolor,
                                            size: buttontextSize,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: iconcolor,
                                            size: buttontextSize,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: 90,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () => Get.toNamed(
                                            '/messages/$index',
                                            arguments: index),
                                        style: ElevatedButton.styleFrom(
                                          primary: primarycolor,
                                          onPrimary: whitecolor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(FeatherIcons.messageCircle,
                                                color: whitecolor,
                                                size: normaltextSize),
                                            StaticText(
                                                text: "chat".tr,
                                                weight: FontWeight.w400,
                                                size: normaltextSize,
                                                color: whitecolor),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Devider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
