import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Constants/IconButtonElement.dart';
import 'package:yoldashapp/Controllers/AutomobilsController.dart';
import 'package:yoldashapp/Controllers/MainController.dart';
import 'package:yoldashapp/Controllers/MessagesController.dart';
import 'package:yoldashapp/models/automobils.dart';
import '../../../Constants/BaseAppBar.dart';
import '../../../Constants/Devider.dart';
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
  final MainController mainController = Get.put(MainController());
  final AutomobilsController _automobilsController =
      Get.put(AutomobilsController());
      final MessagesController messagesController =
      Get.put(MessagesController());
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
          title:_controller.driverpage.value?.nameSurname,
          changeprof: false,
          titlebg: false,
        ),
        body: Obx(() => showimagemodal == true
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
                              _automobilsController.driverautomobil.value !=
                                          null &&
                                      _automobilsController.driverautomobil
                                              .value?.autoSerialNumber !=
                                          null &&
                                      _automobilsController.driverautomobil
                                              .value?.autoSerialNumber !=
                                          '' &&
                                      _automobilsController.driverautomobil
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
                              _automobilsController.driverautomobil.value !=
                                          null &&
                                      _automobilsController.driverautomobil
                                              .value?.autoSerialNumber !=
                                          null &&
                                      _automobilsController.driverautomobil
                                              .value?.autoSerialNumber !=
                                          '' &&
                                      _automobilsController.driverautomobil
                                              .value?.autoSerialNumber !=
                                          ' '
                                  ? SizedBox(
                                    height: 300,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: _automobilsController
                                                .driverautomobil
                                                .value
                                                ?.images
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          Images image = _automobilsController
                                              .driverautomobil
                                              .value!
                                              .images![index];
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedimage = getimageurl(
                                                    'automobil',
                                                    'automobils/types',
                                                    image?.image);
                                                showimagemodal = true;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: CachedNetworkImage(
                                                imageUrl: getimageurl(
                                                    'automobil',
                                                    'automobils/types',
                                                    image?.image),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error,color:Colors.white,size: 0,),
                                                
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                  )
                                  : SizedBox(),
                              Devider(),
                            ],
                          ),
                        ),
                      ),
                      Devider(),
                    ]))),
        bottomNavigationBar: GestureDetector(
          onTap: () {
                  print(mainController.auth_id.value);
                  print(_controller.driverpage.value?.id);
                   messagesController.createandredirectchat(mainController.auth_id?.value,_controller.driverpage.value?.id,context);
                },
          child: Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 15),
            color: primarycolor,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                      FeatherIcons.messageCircle,
                      color: whitecolor,
                      size: 22,),
                  SizedBox(
                    width: 5,
                  ),
                  StaticText(
                    text: "chat".tr,
                    weight: FontWeight.w600,
                    size: normaltextSize,
                    color: whitecolor,
                    align: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
