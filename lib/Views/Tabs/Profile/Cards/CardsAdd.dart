import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/InputElement.dart';
import 'package:yoldash/Controllers/CardsController.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CardsAdd extends StatelessWidget {
  final CardsController _controller = Get.find<CardsController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bodycolor,
        appBar: BaseAppBar(
          backbutton: true,
          title: "add".tr,
          changeprof: false,
          titlebg: false,
        ),
        body: Column(
          children: [
            Devider(),
            Obx(
              () => CreditCardWidget(
                cardNumber: _controller.cardNumberController.value.text,
                expiryDate: _controller.validityDateController.value.text,
                cardHolderName: _controller.holderNameController.value.text,
                cvvCode: _controller.cvvController.value.text,
                showBackView: false,
                onCreditCardWidgetChange: (evt) => print(evt),
                animationDuration: Duration(milliseconds: 500),
                cardBgColor: primarycolor,
                cardType: CardType.mastercard,
                chipColor: secondarycolor,
                frontCardBorder: Border.all(
                    color: iconcolor, width: 1, style: BorderStyle.solid),
                isChipVisible: false,
                isHolderNameVisible: false,
                isSwipeGestureEnabled: true,
                labelCardHolder: "name_surname".tr,
                labelExpiredDate: "xx/xx",
                obscureCardCvv: true,
                obscureCardNumber: false,
                obscureInitialCardNumber: true,
                padding: 10,
                textStyle: GoogleFonts.poppins(
                  color: whitecolor,
                  fontWeight: FontWeight.w500,
                  fontSize: normaltextSize,
                ),
              ),
            ),
            Devider(),
            Container(
              width: width - 40,
              child: InputElement(
                  placeholder: "name_surname".tr,
                  accentColor: primarycolor,
                  textColor: bodycolor,
                  cornerradius: BorderRadius.all(Radius.circular(50)),
                  controller: _controller.holderNameController.value),
            ),
            Devider(),
            Container(
              width: width - 40,
              child: InputElement(
                  placeholder: "cardnumber".tr,
                  accentColor: primarycolor,
                  textColor: bodycolor,
                  cornerradius: BorderRadius.all(Radius.circular(50)),
                  controller: _controller.cardNumberController.value),
            ),
            Devider(),
            Container(
              width: width - 40,
              child: InputElement(
                  placeholder: "validtydate".tr,
                  accentColor: primarycolor,
                  textColor: bodycolor,
                  cornerradius: BorderRadius.all(Radius.circular(50)),
                  controller: _controller.validityDateController.value),
            ),
            Devider(),
            Container(
              width: width - 40,
              child: InputElement(
                  placeholder: "CVV",
                  accentColor: primarycolor,
                  textColor: bodycolor,
                  cornerradius: BorderRadius.all(Radius.circular(50)),
                  controller: _controller.cvvController.value),
            ),
            Devider(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonElement(
                text: "add".tr,
                height: 50,
                width: width - 100,
                borderRadius: BorderRadius.circular(45),
                onPressed: () => print("Add CardNow")),
          ),
        ));
  }
}
