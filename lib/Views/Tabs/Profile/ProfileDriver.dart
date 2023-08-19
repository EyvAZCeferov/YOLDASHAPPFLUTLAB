import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../Constants/BaseAppBar.dart';
import '../../../Constants/ButtonElement.dart';
import '../../../Constants/Devider.dart';
import '../../../Constants/ImageClass.dart';
import '../../../Constants/ImageModal.dart';
import '../../../Constants/StaticText.dart';
import '../../../Theme/ThemeService.dart';

class ProfileDriver extends StatefulWidget {
  @override
  State<ProfileDriver> createState() => _ProfileDriverState();
}

class _ProfileDriverState extends State<ProfileDriver> {
  bool showimagemodal = false;
  String selectedimage = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "Eyvaz Cəfərov",
          changeprof: false,
          titlebg: false,
        ),
        body: showimagemodal == true
            ? ImageModal(
                image: selectedimage,
                close: () => setState(() => showimagemodal = false))
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
                          child: CircleAvatar(
                        backgroundColor: primarycolor,
                        foregroundColor: whitecolor,
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
                      )),
                      Devider(),
                      Center(
                        child: SizedBox(
                          width: width - 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  StaticText(
                                    text: "aboutme".tr,
                                    weight: FontWeight.w600,
                                    size: normaltextSize,
                                    color: darkcolor,
                                    align: TextAlign.left,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          width: 32,
                                          height: 30,
                                          child: CountryFlag(
                                            country: Country.az,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          width: 32,
                                          height: 30,
                                          child: CountryFlag(
                                            country: Country.ru,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          width: 32,
                                          height: 30,
                                          child: CountryFlag(
                                            country: Country.gb,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          width: 32,
                                          height: 30,
                                          child: CountryFlag(
                                            country: Country.tr,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Devider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                              StaticText(
                                text:
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                weight: FontWeight.w500,
                                size: normaltextSize,
                                color: iconcolor,
                                align: TextAlign.left,
                                maxline: 15,
                                textOverflow: TextOverflow.clip,
                              ),
                              Devider(),
                              StaticText(
                                text: "infoauto".tr,
                                weight: FontWeight.w600,
                                size: normaltextSize,
                                color: darkcolor,
                                align: TextAlign.left,
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
                                      setState(() {
                                        selectedimage =
                                            "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg";
                                        showimagemodal = true;
                                      });
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
                                      setState(() {
                                        selectedimage =
                                            "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg";
                                        showimagemodal = true;
                                      });
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
                                      setState(() {
                                        selectedimage =
                                            "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg";
                                        showimagemodal = true;
                                      });
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
                                      setState(() {
                                        selectedimage =
                                            "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg";
                                        showimagemodal = true;
                                      });
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
                                      setState(() {
                                        selectedimage =
                                            "https://images.hertz.com/content/dam/irac/Overlay/enUS/tiles/HertzShelbyGT500-H.jpg";
                                        showimagemodal = true;
                                      });
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
                            ],
                          ),
                        ),
                      ),
                      Devider(),
                    ])),
        bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonElement(
                text: "contact".tr,
                height: 50,
                width: width - 100,
                borderRadius: BorderRadius.circular(45),
                onPressed: () => Get.toNamed("/messages/1")),
          ),
        ));
  }
}
