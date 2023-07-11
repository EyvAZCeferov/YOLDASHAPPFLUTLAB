import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TimePicker.dart';
import 'package:yoldash/Controllers/CardsController.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class GoingController extends GetxController {
  final String authtype = "driver";

  final TextEditingController fromcontroller = TextEditingController();
  final TextEditingController tocontroller = TextEditingController();
  final TextEditingController weightcontroller = TextEditingController();
  final TextEditingController minimumpriceofwaycontroller =
      TextEditingController();
  final TextEditingController priceofwaycontroller = TextEditingController();
  final openmodal = false.obs;
  final data = [].obs;
  final addedsectionshow = false.obs;
  final loading = false.obs;
  final selectedindex = 0.obs;
  final Rx<DateTime> selectedTime = DateTime.now().obs;
  final selectedplace = 0.obs;

  void addsections() {
    addedsectionshow.value = !addedsectionshow.value;
  }

  void changeindex(index) {
    selectedindex.value = 0;
    selectedindex.value = index;
    Get.bottomSheet(Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Devider(),
          StaticText(
            color: secondarycolor,
            size: buttontextSize,
            text: "choisetime".tr,
            weight: FontWeight.w500,
            align: TextAlign.center,
          ),
          Devider(),
          Obx(
            () => Expanded(
              child: TimePicker(
                initialTime: selectedTime.value,
                onTimeSelected: (time) {
                  selectedTime.value = time;
                },
              ),
            ),
          ),
          Devider(),
          ButtonElement(
            text: "choise".tr,
            width: 90,
            onPressed: () => Get.back(),
            bgColor: primarycolor,
            borderRadius: BorderRadius.circular(45),
            fontsize: normaltextSize,
            height: 45,
            textColor: whitecolor,
          ),
          Devider(),
        ],
      ),
    ));
  }

  void selectplace(index) {
    selectedplace.value = 0;
    selectedplace.value = index;
    if (index == 1) {
      Get.bottomSheet(Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            Devider(),
            StaticText(
              color: secondarycolor,
              size: buttontextSize,
              text: "pleaseselectplaceandclick".tr,
              weight: FontWeight.w500,
              align: TextAlign.center,
            ),
            Devider(),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: Get.width - 40,
                  child: ImageClass(
                    type: false,
                    boxfit: BoxFit.contain,
                    url: "assets/images/places.png",
                  ),
                ),
              ),
            ),
            Devider(),
            ButtonElement(
              text: "choise".tr,
              width: 90,
              onPressed: () => Get.back(),
              bgColor: primarycolor,
              borderRadius: BorderRadius.circular(45),
              fontsize: normaltextSize,
              height: 45,
              textColor: whitecolor,
            ),
            Devider(),
          ],
        ),
      ));
    }
  }

  void togglesearch() {
    loading.value = !loading.value;
  }

  void fetchdata() {
    data.add('asb');
  }

  void lookmore(index, context) {
    Get.bottomSheet(Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Devider(),
          StaticText(
            color: secondarycolor,
            size: buttontextSize,
            text: "informationforride".tr,
            weight: FontWeight.w500,
            align: TextAlign.center,
          ),
          Devider(),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Devider(),
              SizedBox(
                width: Get.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed('/profiledriver/eyvaz-ceferov'),
                      child: CircleAvatar(
                        backgroundColor: primarycolor,
                        foregroundColor: whitecolor,
                        radius: 25,
                        backgroundImage: NetworkImage(
                            "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => Get.toNamed('/profiledriver/eyvaz-ceferov'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StaticText(
                                  text: "Eyvaz Ceferov",
                                  weight: FontWeight.w600,
                                  size: normaltextSize,
                                  color: darkcolor),
                              SizedBox(width: 4),
                              Icon(
                                FeatherIcons.star,
                                color: Colors.yellow,
                                size: normaltextSize,
                              ),
                              StaticText(
                                  text: "4",
                                  weight: FontWeight.w500,
                                  size: smalltextSize,
                                  color: iconcolor),
                            ],
                          ),
                          SizedBox(
                            width: Get.width / 3,
                            child: StaticText(
                                align: TextAlign.left,
                                maxline: 2,
                                textOverflow: TextOverflow.clip,
                                text: "Ağ Volkswagen CC - 99-DD-556",
                                weight: FontWeight.w500,
                                size: smalltextSize,
                                color: iconcolor),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => callpageredirect('call', context),
                            style: ElevatedButton.styleFrom(
                              primary: primarycolor,
                              onPrimary: whitecolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Icon(FeatherIcons.phoneCall,
                                color: whitecolor, size: normaltextSize),
                          ),
                        ),
                        SizedBox(width: 3),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed("/messages/1"),
                            style: ElevatedButton.styleFrom(
                              primary: primarycolor,
                              onPrimary: whitecolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Icon(FeatherIcons.messageCircle,
                                color: whitecolor, size: normaltextSize),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Devider(),
            ],
          )),
          Devider(),
          Center(
            child: GestureDetector(
              onTap: () => changemethod(context),
              child: Container(
                width: Get.width - 40,
                height: 70,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffECECEC),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurStyle: BlurStyle.solid,
                        color: Colors.black38,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 15),
                    Container(
                      width: 60,
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: ImageClass(
                        type: false,
                        boxfit: BoxFit.contain,
                        url: "/assets/images/money.png",
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StaticText(
                          color: darkcolor,
                          size: normaltextSize,
                          align: TextAlign.left,
                          weight: FontWeight.w500,
                          text: "nagd".tr,
                        ),
                        StaticText(
                          color: iconcolor,
                          size: smalltextSize,
                          align: TextAlign.left,
                          weight: FontWeight.w400,
                          text: "changepaymentmethod".tr,
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Icon(FeatherIcons.chevronRight,
                        color: iconcolor, size: buttontextSize),
                  ],
                ),
              ),
            ),
          ),
          Devider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonElement(
                text: "close".tr,
                width: 90,
                onPressed: () => Get.back(),
                bgColor: primarycolor,
                borderRadius: BorderRadius.circular(45),
                fontsize: normaltextSize,
                height: 45,
                textColor: whitecolor,
              ),
              SizedBox(
                width: 7,
              ),
              ButtonElement(
                text: "reguestnow".tr,
                width: 160,
                onPressed: () => Get.back(),
                bgColor: primarycolor,
                borderRadius: BorderRadius.circular(80),
                fontsize: normaltextSize,
                height: 45,
                textColor: whitecolor,
              ),
            ],
          ),
          Devider()
        ],
      ),
    ));
  }

  void callpageredirect(type, context) async {
    try {
      if (type == "video") {
        _handlecameraandmic(Permission.camera, context);
      } else {
        print("calling");
      }

      _handlecameraandmic(Permission.microphone, context);

      Get.toNamed('/callpage/${type}', arguments: {type: type});
    } catch (error) {
      showToastMSG(errorcolor, error, context);
    }
  }

  void _handlecameraandmic(Permission permission, context) async {
    final status = await permission.request();
    if (status.isDenied) {
      showToastMSG(errorcolor, "permissiondenied".tr, context);
    }
  }

  void changemethod(context) {
    final CardsController cardscontroller = Get.put(CardsController());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: StaticText(
            color: darkcolor,
            size: normaltextSize,
            weight: FontWeight.w500,
            align: TextAlign.center,
            textOverflow: TextOverflow.ellipsis,
            maxline: 1,
            text: "changepaymentmethod".tr,
          ),
          content: Obx(
            () => SizedBox(
              width: Get.width,
              height: Get.width / 2,
              child: ListView.builder(
                itemCount: cardscontroller.cards.length,
                itemBuilder: (context, index) {
                  final item = cardscontroller.cards[index];
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
                          groupValue: item.value,
                          activeColor: primarycolor,
                          focusColor: primarycolor,
                          hoverColor: primarycolor,
                          toggleable: true,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          onChanged: (value) {
                            cardscontroller.updateSelection(index, value!);
                          },
                        ),
                      ),
                      Devider(),
                    ],
                  );
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: StaticText(
                color: secondarycolor,
                size: normaltextSize,
                weight: FontWeight.w500,
                align: TextAlign.right,
                textOverflow: TextOverflow.ellipsis,
                maxline: 1,
                text: "submit".tr,
              ),
            ),
          ],
        );
      },
    );
  }

  void selectplacing() {}
}