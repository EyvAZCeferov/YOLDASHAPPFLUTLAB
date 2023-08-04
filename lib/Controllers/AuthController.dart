import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:yoldash/Functions/CacheManager.dart';
import 'package:yoldash/Functions/GetAndPost.dart';
import 'package:yoldash/Functions/ProviderContext.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/models/users.dart';

class AuthController extends GetxController {
  Rx<TextEditingController> namesurnamecontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> gendercontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<String> birthdaycontroller = Rx<String>('');
  Rx<TextEditingController> emailcontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> phonecontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> aboutcontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<File?> imageFile = Rx<File?>(null);
  Rx<String> authType = 'rider'.obs;
  Rx<List<String>> selectedlang = Rx<List<String>>([]);
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<TextEditingController> pincontroller =
      Rx<TextEditingController>(TextEditingController());

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

  void selectlangknowns(lang) {
    bool exists = selectedlang.value.contains(lang);
    if (exists == true) {
      selectedlang.value.remove(lang);
    } else {
      selectedlang.value.add(lang);
    }
  }

  void register(context) async {
    if ((namesurnamecontroller.value.text != null &&
            namesurnamecontroller.value.text.length > 0) &&
        (birthdaycontroller.value != null &&
            birthdaycontroller.value.length > 0) &&
        (emailcontroller.value.text != null &&
            emailcontroller.value.text.length > 0) &&
        (phonecontroller.value.text != null &&
            phonecontroller.value.text.length > 0)) {
      refreshpage.value = true;
      var body = {
        'phone': phonecontroller.value.text,
        'name_surname': namesurnamecontroller.value.text,
        'birthday': birthdaycontroller.value,
        'email': emailcontroller.value.text,
        'type': authType.value,
        'description': aboutcontroller.value.text.toString(),
        'language': 'az'
      };
      var response = await GetAndPost.postData("auth/register", body, context);
      if (authType.value == "driver") {
      } else {}
      refreshpage.value = false;
    } else {
      refreshpage.value = true;
      showToastMSG(errorcolor, "fillthefield".tr, context);
      refreshpage.value = false;
    }
  }

  void login(context) async {
    if (phonecontroller.value.text != null &&
        phonecontroller.value.text.length > 0) {
      refreshpage.value = true;

      var body = {'phone': phonecontroller.value.text, 'language': 'az'};
      var response = await GetAndPost.postData("auth/login", body, context);
      if (response != null) {
        refreshpage.value = false;
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          var data = Users.fromMap(response['data']);
          var cachedModel =
              await CacheManager.getCachedModel<Users>('authenticated');
          if (cachedModel == null) {
            await CacheManager.cacheModel('authenticated', data);
          }

          if (data.id != null) {
            // Provider.of<ProviderContext>(context, listen: false)
            //     .changedata('authid', data.id);
            // Provider.of<ProviderContext>(context, listen: false)
            //     .changedata('authid', data.id);
            CacheManager.setvaluetoprefences('auth_id', data.id);
          }

          CacheManager.setvaluetoprefences('email', data.email);
          CacheManager.setvaluetoprefences('phone', data.phone);

          print(await CacheManager.getvaluefromsharedprefences('auth_id'));

          Get.toNamed(
            'verificationcode',
            arguments: {'phoneNumber': phonecontroller.value.text},
          );

          showToastMSG(primarycolor, message, context);
        } else {
          showToastMSG(errorcolor, message, context);
        }
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } else {
      refreshpage.value = true;
      showToastMSG(errorcolor, "fillthefield".tr, context);
      refreshpage.value = false;
    }
  }

  void verifycode(phoneNumber, value, context) async {
    refreshpage.value = true;
    if (value != null && value.length == 4) {
      String auth_id =
          await CacheManager.getvaluefromsharedprefences('auth_id');
      print(auth_id);

      String? language =
          await CacheManager.getvaluefromsharedprefences('language');

      print(language);
      print(phoneNumber);
      var body = {
        'phone': phoneNumber,
        'auth_id': auth_id,
        'language': language ?? 'az'
      };
      print(body);
      var response = await GetAndPost.postData("auth/verifysms", body, context);

      if (response != null) {
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          showToastMSG(primarycolor, message, context);
          Get.toNamed(
            'mainscreen',
          );
        } else {
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } else {
      showToastMSG(errorcolor, "passwordiswrong".tr, context);
      refreshpage.value = false;
    }
  }

  void resendcode(phoneNumber, context) async {
    refreshpage.value = true;

    var auth_id = await CacheManager.getvaluefromsharedprefences("auth_id");

    var body = {'phone': phoneNumber, 'auth_id': auth_id, 'language': 'az'};
    print(body);
    var response = await GetAndPost.postData("auth/resendcode", body, context);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        print(response['data']);
        showToastMSG(primarycolor, message, context);
      } else {
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }
}
