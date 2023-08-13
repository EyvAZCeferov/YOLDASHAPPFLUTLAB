import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/LoaderScreen.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/BalanceController.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class BalanceIndex extends StatelessWidget {
  final BalanceController _controller = Get.find<BalanceController>();
  @override
  Widget build(BuildContext context) {
    _controller.fetchData(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bodycolor,
      appBar: BaseAppBar(
        backbutton: true,
        title: "balanceactions".tr,
        changeprof: false,
        titlebg: false,
      ),
      body: Obx(() {
        if (_controller.refreshpage.value == true) {
          return LoaderScreen();
        } else {
          final dat = _controller.userbalances;
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
            return Center(
              child: DataTable(
                border: TableBorder.all(
                    color: bodycolor, style: BorderStyle.solid, width: 1),
                columns: [
                  DataColumn(
                      label: StaticText(
                    text: 'price'.tr,
                    color: darkcolor,
                    size: buttontextSize,
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                  )),
                  DataColumn(
                      label: StaticText(
                    text: 'time'.tr,
                    color: darkcolor,
                    size: buttontextSize,
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                  )),
                ],
                rows:
                    _controller.userbalances.value.map<DataRow>((userBalance) {
                  return DataRow(
                    cells: [
                      DataCell(Text(userBalance!.price.toString() + 'AZN')),
                      DataCell(Text(differenceintwotimes(
                          DateTime.parse(userBalance!.startsAt! as String),
                          DateTime.parse(userBalance!.endsAt! as String)))),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/balance/add'),
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
