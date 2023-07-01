import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoldash/Constants/BaseAppBar.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/CardsController.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CardsAdd extends StatelessWidget {
  final CardsController _controller = Get.find<CardsController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
          CreditCardWidget(
            cardNumber: "41",
            expiryDate: "10/20",
            cardHolderName: "Eyvaz Ceferov",
            cvvCode: "763",
            showBackView: true,
            onCreditCardWidgetChange: (evt) => print(evt),
            animationDuration: Duration(milliseconds: 1500),
            bankName: "Kapital Bank",
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
            textStyle: GoogleFonts.poppins(),
          ),
          Devider(),
        ],
      ),
    );
  }
}
