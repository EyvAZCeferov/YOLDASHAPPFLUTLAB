import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Constants/IconButtonElement.dart';

import '../../../../Constants/BaseAppBar.dart';
import '../../../../Constants/Devider.dart';
import '../../../../Constants/LoaderScreen.dart';
import '../../../../Constants/StaticText.dart';
import '../../../../Controllers/CardsController.dart';
import '../../../../Functions/helpers.dart';
import '../../../../Theme/ThemeService.dart';

class CardsIndex extends StatelessWidget {
  final CardsController _controller = Get.find<CardsController>();

  CardsIndex() {
    _controller.fetchDatas(null);
  }

  @override
  Widget build(BuildContext context) {
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
        if (_controller.refreshpage.value == true) {
          return LoaderScreen();
        } else {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(fontawesome(item.cardtype ?? 'visa') as IconData?,
                            color: secondarycolor,
                            size: headingSize,
                            textDirection: TextDirection.ltr),
                        StaticText(
                          color: darkcolor,
                          size: normaltextSize,
                          text: maskLastFourDigits(item.cardnumber ?? ''),
                          weight: FontWeight.w500,
                          align: TextAlign.left,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            item.id != 0
                                ? IconButtonElement(
                                    icon: FontAwesomeIcons.trash,
                                    onPressed: () => _controller.removeCard(
                                        item.id, context),
                                    color: errorcolor,
                                    size: 18,
                                  )
                                : SizedBox(),
                            Radio<bool>(
                              value: true,
                              groupValue: item.selected,
                              activeColor: primarycolor,
                              focusColor: primarycolor,
                              hoverColor: primarycolor,
                              toggleable: true,
                              visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                              onChanged: (value) {
                                _controller.updateSelection(
                                    item.id!, true, context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Devider(),
                  ],
                );
              },
            );
          }
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.addcard(context),
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
