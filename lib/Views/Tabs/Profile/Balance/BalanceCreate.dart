import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Constants/BaseAppBar.dart';
import '../../../../Constants/ButtonElement.dart';
import '../../../../Constants/Devider.dart';
import '../../../../Constants/LoaderScreen.dart';
import '../../../../Constants/StaticText.dart';
import '../../../../Controllers/BalanceController.dart';
import '../../../../Functions/helpers.dart';
import '../../../../Theme/ThemeService.dart';
import '../../../../models/balance_types.dart';

class BalanceCreate extends StatefulWidget {
  @override
  State<BalanceCreate> createState() => _BalanceCreateState();
}

class _BalanceCreateState extends State<BalanceCreate> {
  final BalanceController _controller = Get.find<BalanceController>();

  @override
  Widget build(BuildContext context) {
    _controller.fetchTypes(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "addbalance".tr,
          changeprof: false,
          titlebg: false,
        ),
        body: Obx(
          () => _controller.refreshpage.value == true
              ? LoaderScreen()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Devider(size: 40),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _controller.balancetypes.length,
                        itemBuilder: (context, index) {
                          final item = _controller.balancetypes[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => _controller.changeAddType(
                                    item.type.toString(), context),
                                child: Container(
                                  width: width - 40,
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: primarycolor,
                                          style: BorderStyle.solid,
                                          width: 1),
                                      color: _controller.getActiveBgColor(
                                          item.type.toString())),
                                  child: StaticText(
                                    color: _controller.getActiveTextColor(
                                        item.type.toString()),
                                    size: normaltextSize,
                                    align: TextAlign.center,
                                    weight: FontWeight.w500,
                                    text: "${item.type}_balance".tr,
                                  ),
                                ),
                              ),
                              Devider(),
                            ],
                          );
                        },
                      ),
                    ),
                    Devider(),
                    SizedBox(
                        width: width - 40, child: getDailyOrPersonal(context)),
                    Devider(size: 35),
                    Obx(
                      () => _controller.price.value != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StaticText(
                                    text: _controller.price.value!.toString() +
                                        'AZN',
                                    weight: FontWeight.w500,
                                    size: subHeadingSize,
                                    color: secondarycolor),
                                ButtonElement(
                                    text: "add".tr,
                                    height: 50,
                                    width: width - 200,
                                    borderRadius: BorderRadius.circular(45),
                                    onPressed: () =>
                                        _controller.addbalance(context)),
                              ],
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 15),
          child: Align(alignment: Alignment.bottomCenter, child: SizedBox()),
        ));
  }

  Row getDailyOrPersonal(context) {
    final width = MediaQuery.of(context).size.width;
    List<BalanceElement>? elements = _controller.selectedType?.value?.elements;
    if (elements == null ||
        _controller.selectedType?.value?.type == "monthly") {
      return Row();
    } else {
      BalanceElement? selectedElement = _controller.selectedElement?.value;
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              width: width - 40,
              height: width / 5,
              child: ListView.builder(
                itemCount: elements!.length,
                itemBuilder: (context, index) {
                  BalanceElement element = elements[index];
                  return GestureDetector(
                    onTap: () => _controller.selectPriceType(
                        element.type, element.id, context),
                    child: Container(
                      width: width / 4,
                      height: width / 4,
                      margin: EdgeInsets.only(right: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: primarycolor,
                            style: BorderStyle.solid,
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: selectedElement != null &&
                                selectedElement.id == element.id
                            ? primarycolor
                            : whitecolor,
                      ),
                      child: StaticText(
                        color: selectedElement != null &&
                                selectedElement.id == element.id
                            ? whitecolor
                            : darkcolor,
                        size: smalltextSize,
                        text: getLocalizedValue(element.name, 'name') as String,
                        weight: FontWeight.w400,
                        align: TextAlign.center,
                      ),
                    ),
                  );
                },
                controller: ScrollController(),
                physics: ScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                scrollDirection: Axis.horizontal,
              ),
            )
          ]);
    }
  }
}
