import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/CardsController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class CardsIndex extends StatelessWidget {
  final CardsController _controller = Get.find<CardsController>();

  @override
  Widget build(BuildContext context) {
    _controller.fetchDatas(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        title: "bank_account_and_cards".tr,
        changeprof: false,
        titlebg: false,
      ),
      body: Obx(() {
        final cards = _controller.data;
        if (cards.isEmpty) {
          return Center(
            child: StaticText(
              color: errorcolor,
              size: subHeadingSize,
              weight: FontWeight.w400,
              align: TextAlign.center,
              text: "nohasdata".tr,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: _controller.data.length,
            itemBuilder: (context, index) {
              final item = _controller.data[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Icon(FontAwesomeIcons.ccVisa,
                        color: secondarycolor,
                        size: headingSize,
                        textDirection: TextDirection.ltr),
                    title: StaticText(
                      color: darkcolor,
                      size: normaltextSize,
                      text: "***0049",
                      weight: FontWeight.w500,
                      align: TextAlign.left,
                    ),
                    trailing: Radio<bool>(
                      value: true,
                      groupValue: item.selected,
                      activeColor: primarycolor,
                      focusColor: primarycolor,
                      hoverColor: primarycolor,
                      toggleable: true,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      onChanged: (value) {
                        _controller.updateSelection(index, true, context);
                      },
                    ),
                  ),
                  Devider(),
                ],
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/cards/add'),
        backgroundColor: whitecolor,
        child:
            Icon(FeatherIcons.plus, color: secondarycolor, size: headingSize),
        elevation: 10,
        focusColor: secondarycolor,
        tooltip: "add".tr,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
