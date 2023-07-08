import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class AuthController extends GetxController {
  late TextEditingController namesurnamecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController phonecontroller;
  Rx<File?> imageFile = Rx<File?>(null);

  @override
  void onInit() {
    namesurnamecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    phonecontroller = TextEditingController();
    super.onInit();
  }

  void pickImage() async {
    // photos camera storage
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
        showToastMSG(errorcolor, 'permissiondenied'.tr);
      } else if (status.isPermanentlyDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr);
      }
    }
  }

  void updateprofiledata() {
    print("Update Profile");
  }
}
