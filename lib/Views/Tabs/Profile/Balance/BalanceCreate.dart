import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/BalanceController.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class BalanceCreate extends StatefulWidget {
  @override
  State<BalanceCreate> createState() => _BalanceCreateState();
}

class _BalanceCreateState extends State<BalanceCreate> {
  final BalanceController _controller = Get.find<BalanceController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Devider(),
              GestureDetector(
                onTap: () => _controller.changeAddType('ayliq'),
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
                      color: _controller.getActiveBgColor('ayliq')),
                  child: StaticText(
                    color: _controller.getActiveTextColor('ayliq'),
                    size: normaltextSize,
                    align: TextAlign.center,
                    weight: FontWeight.w500,
                    text: "monthly_balance".tr,
                  ),
                ),
              ),
              Devider(size: 15),
              GestureDetector(
                onTap: () => _controller.changeAddType('gunluk'),
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
                      color: _controller.getActiveBgColor('gunluk')),
                  child: StaticText(
                    color: _controller.getActiveTextColor('gunluk'),
                    size: normaltextSize,
                    align: TextAlign.center,
                    weight: FontWeight.w500,
                    text: "daily_balance".tr,
                  ),
                ),
              ),
              Devider(size: 15),
              GestureDetector(
                onTap: () => _controller.changeAddType('ferdi'),
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
                      color: _controller.getActiveBgColor('ferdi')),
                  child: StaticText(
                    color: _controller.getActiveTextColor('ferdi'),
                    size: normaltextSize,
                    align: TextAlign.center,
                    weight: FontWeight.w500,
                    text: "personal_adding".tr,
                  ),
                ),
              ),
              Devider(size: 15),
              SizedBox(
                  width: width - 40,
                  child: Obx(() => getDailyOrPersonal(context))),
              Devider(size: 15),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Obx(
              () => _controller.selectedprice.value != null &&
                      _controller.selectedprice.value != '' &&
                      _controller.selectedprice.value != ' '
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StaticText(
                            text: _controller.selectedprice.value + 'AZN',
                            weight: FontWeight.w500,
                            size: subHeadingSize,
                            color: secondarycolor),
                        ButtonElement(
                            text: "add".tr,
                            height: 50,
                            width: width - 200,
                            borderRadius: BorderRadius.circular(45),
                            onPressed: () => print("add")),
                      ],
                    )
                  : SizedBox(),
            ),
          ),
        ));
  }

  Row getDailyOrPersonal(context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (_controller.selectedType.value == "gunluk") {
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _controller.selectPriceType('gunluk', index),
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
                      color: _controller.selectedDay.value == index
                          ? primarycolor
                          : whitecolor,
                    ),
                    child: StaticText(
                      color: _controller.selectedDay.value == index
                          ? whitecolor
                          : darkcolor,
                      size: smalltextSize,
                      text: "${index} day",
                      weight: FontWeight.w400,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                itemCount: 5,
                controller: ScrollController(),
                physics: ScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                scrollDirection: Axis.horizontal,
              ),
            )
          ]);
    } else if (_controller.selectedType.value == "ferdi") {
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _controller.selectPriceType('ferdi', index),
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
                      color: _controller.selectedDay.value == index
                          ? primarycolor
                          : whitecolor,
                    ),
                    child: StaticText(
                      color: _controller.selectedDay.value == index
                          ? whitecolor
                          : darkcolor,
                      size: smalltextSize,
                      text: "${index} AZN",
                      weight: FontWeight.w400,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                itemCount: 5,
                controller: ScrollController(),
                physics: ScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                scrollDirection: Axis.horizontal,
              ),
            )
          ]);
    } else {
      return Row();
    }
  }
}
