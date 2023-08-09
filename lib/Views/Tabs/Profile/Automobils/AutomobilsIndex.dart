import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/LoaderScreen.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/AutomobilsController.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class AutomobilsIndex extends StatelessWidget {
  final AutomobilsController _controller = Get.find<AutomobilsController>();
  @override
  Widget build(BuildContext context) {
    _controller.fetchDatas(context);
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
        if (_controller.refreshpage.value == true) {
          return LoaderScreen();
        } else {
          final dat = _controller.data;
          if (dat.isEmpty) {
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
                      leading: ImageClass(
                        type: true,
                        boxfit: BoxFit.contain,
                        url: imageurl +
                            'automobils/models/' +
                            item.automodels!.icon! as String,
                      ),
                      title: StaticText(
                        color: darkcolor,
                        size: normaltextSize,
                        text: getLocalizedValue(item.automodels!.name, 'name')
                            as String,
                        weight: FontWeight.w500,
                        align: TextAlign.left,
                      ),
                      subtitle: StaticText(
                        color: iconcolor,
                        size: smalltextSize,
                        text: item.autoSerialNumber as String,
                        weight: FontWeight.w400,
                        align: TextAlign.left,
                      ),
                      trailing: Radio<bool>(
                        value: true,
                        groupValue: item.selected as bool,
                        activeColor: primarycolor,
                        focusColor: primarycolor,
                        hoverColor: primarycolor,
                        toggleable: true,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        onChanged: (value) {
                          _controller.updateSelection(
                              item.id as int, true, context);
                        },
                      ),
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
