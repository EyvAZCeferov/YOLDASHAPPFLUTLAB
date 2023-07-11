import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/ButtonElement.dart';
import 'package:yoldash/Constants/Devider.dart';
import 'package:yoldash/Constants/ImageClass.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Constants/TimePicker.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class GoingController extends GetxController {
  final String authtype = "rider";

  final TextEditingController fromcontroller = TextEditingController();
  final TextEditingController tocontroller = TextEditingController();
  final TextEditingController weightcontroller = TextEditingController();
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

  void search() {
    loading.value = !loading.value;
  }

  void fetchdata() {
    data.add('asb');
  }
}
