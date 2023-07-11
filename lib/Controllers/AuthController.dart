import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class AuthController extends GetxController {
  Rx<TextEditingController> namesurnamecontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> gendercontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> birthdaycontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> emailcontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> phonecontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<File?> imageFile = Rx<File?>(null);
  Rx<String> authType = 'rider'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void pickImage(context) async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final picker = ImagePicker();
      final source = ImageSource.gallery;
      final pickedFile = await picker.getImage(source: source);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    } else {
      if (status.isDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr, context);
      } else if (status.isPermanentlyDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr, context);
      }
    }
  }

  void updateprofiledata() {
    print("Update Profile");
  }

  void changeprofpage() {
    print(authType.value);
    if (authType.value == "rider") {
      Get.toNamed('/verificationcode');
    } else {
      authType.value = 'rider';
    }
  }
}
