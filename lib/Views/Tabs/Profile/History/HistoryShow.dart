import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/ImageModal.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/HistoryController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class HistoryShow extends StatelessWidget {
  final HistoryController _controller = Get.find<HistoryController>();

  final index = int.parse(Get.parameters['index'] ?? '');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      body: Obx(
        () => _controller.openmodalval.value == true
            ? ImageModal(
                image: _controller.image.value,
                close: () => _controller.openModal(null))
            : Stack(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                  Devider(),
                  _controller.authtype == "rider"
                      ? Positioned(
                          top: width,
                          child: Container(
                              width: width,
                              height: width / 1.3,
                              color: whitecolor,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                physics: const ScrollPhysics(),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Devider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: primarycolor,
                                                foregroundColor: whitecolor,
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              StaticText(
                                                color: darkcolor,
                                                size: normaltextSize,
                                                weight: FontWeight.w400,
                                                align: TextAlign.left,
                                                text: "Eyvaz Ceferov",
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 90,
                                            height: 40,
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  Get.toNamed("/messages/1"),
                                              style: ElevatedButton.styleFrom(
                                                primary: primarycolor,
                                                onPrimary: whitecolor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      FeatherIcons
                                                          .messageCircle,
                                                      color: whitecolor,
                                                      size: normaltextSize),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  StaticText(
                                                    color: whitecolor,
                                                    size: smalltextSize,
                                                    weight: FontWeight.w400,
                                                    align: TextAlign.center,
                                                    text: "chat".tr,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Devider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FeatherIcons.briefcase,
                                                color: primarycolor,
                                                size: buttontextSize,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              StaticText(
                                                color: darkcolor,
                                                size: smalltextSize,
                                                weight: FontWeight.w400,
                                                align: TextAlign.center,
                                                text: "10kg yük",
                                              ),
                                            ],
                                          ),
                                          StaticText(
                                            color: primarycolor,
                                            size: buttontextSize,
                                            weight: FontWeight.w500,
                                            align: TextAlign.right,
                                            text: "45 AZN",
                                          ),
                                        ],
                                      ),
                                      Devider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          StaticText(
                                            color: darkcolor,
                                            size: smalltextSize,
                                            weight: FontWeight.w600,
                                            align: TextAlign.center,
                                            text: "aboutme".tr,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FeatherIcons.star,
                                                color: Colors.yellow,
                                                size: normaltextSize,
                                              ),
                                              Icon(
                                                FeatherIcons.star,
                                                color: Colors.yellow,
                                                size: normaltextSize,
                                              ),
                                              Icon(
                                                FeatherIcons.star,
                                                color: Colors.yellow,
                                                size: normaltextSize,
                                              ),
                                              Icon(
                                                FeatherIcons.star,
                                                color: Colors.yellow,
                                                size: normaltextSize,
                                              ),
                                              Icon(
                                                FeatherIcons.star,
                                                color: Colors.yellow,
                                                size: normaltextSize,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Devider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FeatherIcons.user,
                                                color: iconcolor,
                                                size: subHeadingSize,
                                              ),
                                              Devider(size: 8, type: false),
                                              StaticText(
                                                text: "Eyvaz Ceferov",
                                                weight: FontWeight.w500,
                                                size: smalltextSize,
                                                color: iconcolor,
                                                align: TextAlign.left,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FeatherIcons.phone,
                                                color: iconcolor,
                                                size: subHeadingSize,
                                              ),
                                              Devider(size: 8, type: false),
                                              StaticText(
                                                text: "+994516543290",
                                                weight: FontWeight.w500,
                                                size: smalltextSize,
                                                color: iconcolor,
                                                align: TextAlign.left,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Devider(),
                                      Center(
                                        child: SizedBox(
                                          width: width - 40,
                                          child: StaticText(
                                            text:
                                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                            weight: FontWeight.w500,
                                            size: normaltextSize,
                                            color: iconcolor,
                                            align: TextAlign.left,
                                            maxline: 15,
                                            textOverflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                      Devider(),
                                      CarouselSlider(
                                        options: CarouselOptions(
                                            enlargeCenterPage: true,
                                            aspectRatio: 16 / 9,
                                            autoPlay: true,
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 500),
                                            scrollDirection: Axis.horizontal),
                                        items: [
                                          GestureDetector(
                                            onTap: () {
                                              _controller.openModal(
                                                  "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg");
                                            },
                                            child: ImageClass(
                                              url:
                                                  "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg",
                                              type: true,
                                              boxfit: BoxFit.contain,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _controller.openModal(
                                                  "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg");
                                            },
                                            child: ImageClass(
                                              url:
                                                  "https://www.budget.com/content/dam/cars/m/2021/kia/2021-kia-soul-s-5door-hatchback-white_featured.png",
                                              type: true,
                                              boxfit: BoxFit.contain,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _controller.openModal(
                                                  "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg");
                                            },
                                            child: ImageClass(
                                              url:
                                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Ford_Model_T_and_VW_type_11_Luxus%2C_Technisches_Museum_Wien%2C_Juni_2009.jpg/300px-Ford_Model_T_and_VW_type_11_Luxus%2C_Technisches_Museum_Wien%2C_Juni_2009.jpg",
                                              type: true,
                                              boxfit: BoxFit.contain,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _controller.openModal(
                                                  "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg");
                                            },
                                            child: ImageClass(
                                              url:
                                                  "https://www.topgear.com/_next/static/images/hatchbacks-1b0085dc3dab0b05a327a8ed27e3c017.png",
                                              type: true,
                                              boxfit: BoxFit.contain,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _controller.openModal(
                                                  "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg");
                                            },
                                            child: ImageClass(
                                              url:
                                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/1916_Ford_Model_T_touring_car.JPG/250px-1916_Ford_Model_T_touring_car.JPG",
                                              type: true,
                                              boxfit: BoxFit.contain,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Devider(),
                                    ]),
                              )))
                      : Positioned(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          margin:
                                              EdgeInsets.symmetric(vertical: 7),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                      onPressed: () =>
                                                          Get.toNamed(
                                                              '/messages/$index',
                                                              arguments: index),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: primarycolor,
                                                        onPrimary: whitecolor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              FeatherIcons
                                                                  .messageCircle,
                                                              color: whitecolor,
                                                              size:
                                                                  normaltextSize),
                                                          StaticText(
                                                              text: "chat".tr,
                                                              weight: FontWeight
                                                                  .w400,
                                                              size:
                                                                  normaltextSize,
                                                              color:
                                                                  whitecolor),
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
      ),
    );
  }
}
