import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/IconButtonElement.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/LoaderScreen.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/AutomobilsController.dart';
import 'package:yoldash/Controllers/CardsController.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class AddableWidget extends StatelessWidget {
  final CardsController _cardscontroller = Get.put(CardsController());
  final AutomobilsController _automobilscontroller =
      Get.put(AutomobilsController());
  final String type;

  AddableWidget({
    this.type = "cards",
  });

  @override
  Widget build(BuildContext context) {
    _cardscontroller.fetchDatas(context);
    _automobilscontroller.fetchDatas(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StaticText(
                text: type == "cards"
                    ? "bank_account_and_cards".tr
                    : "automobils".tr,
                color: darkcolor,
                size: normaltextSize,
                weight: FontWeight.w500,
                align: TextAlign.left,
              ),
              IconButtonElement(
                icon: FeatherIcons.edit2,
                onPressed: () => Get.toNamed('/' + type),
                color: secondarycolor,
                size: normaltextSize,
              ),
            ]),
        _buildbankorauto(type, context),
        GestureDetector(
          onTap: () {
            Get.toNamed('/' + type + '/add');
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
                text: type == "cards"
                    ? "add_bank_account".tr
                    : "add_automobil".tr,
                weight: FontWeight.w500,
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
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
                    return Row(
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
                              text:
                                  item.selected == true ? "mainaccount".tr : '',
                              color: Colors.grey,
                              size: smalltextSize,
                              weight: FontWeight.w400,
                              align: TextAlign.left,
                            ),
                          ],
                        )
                      ],
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
                  itemCount: _automobilscontroller.data.length,
                  itemBuilder: (context, index) {
                    final item = _automobilscontroller.data[index];
                    return Row(
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
                            child: ImageClass(
                              type: true,
                              boxfit: BoxFit.contain,
                              url: imageurl +
                                  'automobils/models/' +
                                  item.automodels!.icon! as String,
                            )),
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
                    );
                  }),
        ),
      );
    }
  }
}
