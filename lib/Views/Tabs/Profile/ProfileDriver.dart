import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Controllers/AutomobilsController.dart';
import 'package:yoldashapp/models/automobils.dart';

import '../../../Constants/BaseAppBar.dart';
import '../../../Constants/ButtonElement.dart';
import '../../../Constants/Devider.dart';
import '../../../Constants/ImageClass.dart';
import '../../../Constants/ImageModal.dart';
import '../../../Constants/StaticText.dart';
import '../../../Controllers/AuthController.dart';
import '../../../Functions/helpers.dart';
import '../../../Theme/ThemeService.dart';

class ProfileDriver extends StatefulWidget {
  @override
  State<ProfileDriver> createState() => _ProfileDriverState();
}

class _ProfileDriverState extends State<ProfileDriver> {
  final AuthController _controller = Get.put(AuthController());
  final AutomobilsController _automobilsController =
      Get.put(AutomobilsController());
  bool showimagemodal = false;
  String selectedimage = '';

  Country getcountryname(String name) {
    if (name == "az") {
      return Country.az;
    } else if (name == "ru") {
      return Country.ru;
    } else if (name == "en") {
      return Country.us;
    } else if (name == "tr") {
      return Country.tr;
    } else {
      return Country.az;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: _controller.driverpage.value?.nameSurname,
          changeprof: false,
          titlebg: false,
        ),
        body: showimagemodal == true
            ? ImageModal(
                image: selectedimage,
                close: () => setState(() => showimagemodal = false))
            : SingleChildScrollView(
                controller: ScrollController(),
                physics: const ScrollPhysics(),
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
                        child: CachedNetworkImage(
                          imageUrl: getimageurl(
                              "user",
                              'users',
                              _controller
                                  .driverpage.value?.additionalinfo?.image),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            backgroundColor: primarycolor,
                            foregroundColor: whitecolor,
                            radius: 55,
                            backgroundImage: imageProvider,
                          ),
                        ),
                      ),
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
                                    Container(
                                      height: 30,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _controller
                                                .driverpage
                                                .value
                                                ?.additionalinfo
                                                ?.knownLanguages
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          var item = _controller
                                              .driverpage
                                              .value
                                              ?.additionalinfo
                                              ?.knownLanguages![index]!;
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Container(
                                                  width: 32,
                                                  height: 30,
                                                  child: CountryFlag(
                                                    country: getcountryname(
                                                      item!,
                                                    ),
                                                    height: 30,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 7),
                                              // Diğer elemanlar eklenecek
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ]),
                              Devider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _controller.driverpage.value?.email != null &&
                                          _controller.driverpage.value?.email !=
                                              '' &&
                                          _controller.driverpage.value?.email !=
                                              ' '
                                      ? GestureDetector(
                                          onTap: () {
                                            launchUrlTOSITE(
                                                "mailto:${_controller.driverpage.value?.email}");
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FeatherIcons.mail,
                                                color: iconcolor,
                                                size: subHeadingSize,
                                              ),
                                              Devider(size: 8, type: false),
                                              StaticText(
                                                text:
                                                    "${_controller.driverpage.value?.email}",
                                                weight: FontWeight.w500,
                                                size: smalltextSize,
                                                color: iconcolor,
                                                align: TextAlign.left,
                                              )
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  GestureDetector(
                                    onTap: () {
                                      launchUrlTOSITE(
                                          "tel:${_controller.driverpage.value?.phone}");
                                    },
                                    child: Row(
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
                                          text:
                                              "${_controller.driverpage.value?.phone}",
                                          weight: FontWeight.w500,
                                          size: smalltextSize,
                                          color: iconcolor,
                                          align: TextAlign.left,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Devider(),
                              _controller.driverpage.value?.additionalinfo
                                              ?.description !=
                                          null &&
                                      _controller.driverpage.value
                                              ?.additionalinfo?.description !=
                                          '' &&
                                      _controller.driverpage.value
                                              ?.additionalinfo?.description !=
                                          ' '
                                  ? StaticText(
                                      text: _controller.driverpage.value!
                                          .additionalinfo!.description!,
                                      weight: FontWeight.w500,
                                      size: normaltextSize,
                                      color: iconcolor,
                                      align: TextAlign.left,
                                      maxline: 15,
                                      textOverflow: TextOverflow.clip,
                                    )
                                  : SizedBox(),
                              Devider(),
                              _automobilsController
                                              .selectedAutomobil.value !=
                                          null &&
                                      _automobilsController.selectedAutomobil
                                              .value?.autoSerialNumber !=
                                          null &&
                                      _automobilsController.selectedAutomobil
                                              .value?.autoSerialNumber !=
                                          '' &&
                                      _automobilsController.selectedAutomobil
                                              .value?.autoSerialNumber !=
                                          ' '
                                  ? StaticText(
                                      text: "infoauto".tr,
                                      weight: FontWeight.w600,
                                      size: normaltextSize,
                                      color: darkcolor,
                                      align: TextAlign.left,
                                    )
                                  : SizedBox(),
                              Devider(),
                              _automobilsController
                                              .selectedAutomobil.value !=
                                          null &&
                                      _automobilsController.selectedAutomobil
                                              .value?.autoSerialNumber !=
                                          null &&
                                      _automobilsController.selectedAutomobil
                                              .value?.autoSerialNumber !=
                                          '' &&
                                      _automobilsController.selectedAutomobil
                                              .value?.autoSerialNumber !=
                                          ' '
                                  ? CarouselSlider(
                                      options: CarouselOptions(
                                          enlargeCenterPage: true,
                                          aspectRatio: 16 / 9,
                                          autoPlay: true,
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 500),
                                          scrollDirection: Axis.horizontal),
                                      items: [
                                        ListView.builder(
                                          itemCount: _automobilsController
                                                  .selectedAutomobil
                                                  .value
                                                  ?.images
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            Images image = _automobilsController
                                                .selectedAutomobil
                                                .value!
                                                .images![index];
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedimage = getimageurl(
                                                      'automobil',
                                                      'automobils',
                                                      image?.image);
                                                  showimagemodal = true;
                                                });
                                              },
                                              child: ImageClass(
                                                url: getimageurl('automobil',
                                                    'automobils', image?.image),
                                                type: true,
                                                boxfit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
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
