import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/models/automobils.dart';

import '../../../../Constants/BaseAppBar.dart';
import '../../../../Constants/Devider.dart';
import '../../../../Constants/LoaderScreen.dart';
import '../../../../Constants/StaticText.dart';
import '../../../../Controllers/AutomobilsController.dart';
import '../../../../Functions/helpers.dart';
import '../../../../Theme/ThemeService.dart';

class AutomobilsIndex extends StatelessWidget {
  final AutomobilsController _controller = Get.put(AutomobilsController());

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
          final dat = _controller.data.value;
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
                Automobils item = _controller.data[index] as Automobils;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: getimageurl(
                            "models", 'automobils/types', item.autotype!.icon),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundColor: primarycolor,
                          foregroundColor: whitecolor,
                          radius: 35,
                          backgroundImage: imageProvider,
                        ),
                      ),
                      title: StaticText(
                        color: darkcolor,
                        size: normaltextSize,
                        text: getLocalizedValue(item.autotype!.name, 'name')
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
                      trailing: item.verified == true
                          ? Radio<bool>(
                              value: true,
                              groupValue: item.selected as bool,
                              activeColor: primarycolor,
                              focusColor: primarycolor,
                              hoverColor: primarycolor,
                              toggleable: true,
                              visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                              onChanged: (value) {
                                _controller.updateSelection(
                                    item.id as int, true, context);
                              },
                            )
                          : StaticText(
                            color: errorcolor,
                            size: normaltextSize,
                            text: "ride_waiting".tr,
                            align: TextAlign.center,
                            weight: FontWeight.w500,
                            
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
