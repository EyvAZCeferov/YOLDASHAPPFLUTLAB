import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../Controllers/AutomobilsController.dart';
import '../Controllers/CardsController.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import 'IconButtonElement.dart';
import 'LoaderScreen.dart';
import 'StaticText.dart';

class AddableWidget extends StatefulWidget {
  final String type;
  final double width;

  AddableWidget({this.type = "cards", required this.width});

  @override
  _AddableWidgetState createState() => _AddableWidgetState();
}

class _AddableWidgetState extends State<AddableWidget> {
  final CardsController _cardscontroller = Get.put(CardsController());
  final AutomobilsController _automobilscontroller =
      Get.put(AutomobilsController());
  dynamic data;

  @override
  void initState() {
    super.initState();
    initFunction(context);
  }

  void initFunction(BuildContext context) {
    dynamic dat;
    if (widget.type == "cards") {
      _cardscontroller.fetchDatas(context);
      dat = _cardscontroller.data;
    } else {
      _automobilscontroller.fetchDatas(context);
      dat = _automobilscontroller.data;
    }

    setState(() {
      data = dat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width - 40,
        height: data.length > 0 ? 110 : widget.width / 1.8,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: whitecolor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurStyle: BlurStyle.solid,
              color: Colors.black38,
              blurRadius: 10,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StaticText(
                    text: widget.type == "cards"
                        ? "bank_account_and_cards".tr
                        : "automobils".tr,
                    color: darkcolor,
                    size: normaltextSize,
                    weight: FontWeight.w500,
                    align: TextAlign.left,
                  ),
                  IconButtonElement(
                    icon: FeatherIcons.edit2,
                    onPressed: () => Get.toNamed('/' + widget.type),
                    color: secondarycolor,
                    size: normaltextSize,
                  ),
                ]),
            _buildbankorauto(widget.type, context),
            GestureDetector(
              onTap: () {
                Get.toNamed('/' + widget.type + '/add');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 80,
                      height: 40,
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xffF4F5F6),
                        border: Border.all(
                            style: BorderStyle.solid,
                            width: 1,
                            color: secondarycolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(FontAwesomeIcons.plus,
                          color: secondarycolor, size: subHeadingSize)),
                  StaticText(
                    color: iconcolor,
                    size: normaltextSize,
                    text: widget.type == "cards"
                        ? "add_bank_account".tr
                        : "add_automobil".tr,
                    weight: FontWeight.w500,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildbankorauto(String type, BuildContext context) {
    if (type == "cards") {
      return Expanded(
        child: Obx(
          () => _cardscontroller.refreshpage.value == true
              ? LoaderScreen()
              : ListView.builder(
                  itemCount: _cardscontroller.data.length,
                  itemBuilder: (context, index) {
                    final item = _cardscontroller.data[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 80,
                              height: 60,
                              margin: EdgeInsets.only(right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xffF4F5F6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                  fontawesome(item.cardtype ?? 'visa')
                                      as IconData?,
                                  color: secondarycolor,
                                  size: headingSize)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StaticText(
                                text: maskLastFourDigits(item.cardnumber ?? ''),
                                color: darkcolor,
                                size: buttontextSize,
                                weight: FontWeight.w500,
                                align: TextAlign.left,
                              ),
                              StaticText(
                                text: item.selected == true
                                    ? "mainaccount".tr
                                    : '',
                                color: Colors.grey,
                                size: smalltextSize,
                                weight: FontWeight.w400,
                                align: TextAlign.left,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
        ),
      );
    } else {
      return Expanded(
        child: Obx(
          () => _automobilscontroller.refreshpage.value == true
              ? LoaderScreen()
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 60,
                            margin: EdgeInsets.only(right: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xffF4F5F6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: getimageurl("models",
                                  'automobils/models', item.automodels.icon),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundColor: primarycolor,
                                foregroundColor: whitecolor,
                                radius: 35,
                                backgroundImage: imageProvider,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StaticText(
                                text: getLocalizedValue(
                                    item.automodels!.name, 'name') as String,
                                color: darkcolor,
                                size: buttontextSize,
                                weight: FontWeight.w500,
                                align: TextAlign.left,
                              ),
                              StaticText(
                                text: item.autoSerialNumber as String,
                                color: Colors.grey,
                                size: smalltextSize,
                                weight: FontWeight.w400,
                                align: TextAlign.left,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
        ),
      );
    }
  }
}
