import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/AutomobilsController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class AutomobilsIndex extends StatelessWidget {
  final AutomobilsController _controller = Get.find<AutomobilsController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        title: "automobils".tr,
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
                    leading: Icon(_controller.data[index].icon,
                        color: secondarycolor,
                        size: headingSize,
                        textDirection: TextDirection.ltr),
                    title: StaticText(
                      color: darkcolor,
                      size: normaltextSize,
                      text: _controller.data[index].name,
                      weight: FontWeight.w500,
                      align: TextAlign.left,
                    ),
                    subtitle: StaticText(
                      color: iconcolor,
                      size: smalltextSize,
                      text: _controller.data[index].statebadge,
                      weight: FontWeight.w400,
                      align: TextAlign.left,
                    ),
                    trailing: Radio<bool>(
                      value: true,
                      groupValue: item.value,
                      activeColor: primarycolor,
                      focusColor: primarycolor,
                      hoverColor: primarycolor,
                      toggleable: true,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      onChanged: (value) {
                        _controller.updateSelection(index, value!);
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
        onPressed: () => Get.toNamed('/automobils/add'),
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
