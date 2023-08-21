import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Functions/CacheManager.dart';
import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../models/users.dart';
import 'MainController.dart';

class AuthController extends GetxController {
  final MainController _maincontroller = Get.put(MainController());
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
  Rx<Users?> userdatas = Rx<Users?>(null);

  AuthController() {
    init();
  }

  void init() async {
    var newval = await _maincontroller.getstoragedat('authtype');
    authType.value = newval;
  }

  void getalldataoncache(context) async {
    try {
      refreshpage.value = true;
      var body = {};
      var response = await GetAndPost.postData("auth/me", body, context);

      if (response != null) {
        String status = response['status'];
        refreshpage.value = false;
        if (response['message'] != null) String message = response['message'];
        var data = Users.fromMap(response['data']);
        userdatas.value = data;

        namesurnamecontroller.value.text = data.nameSurname!;
        emailcontroller.value.text = data.email ?? '';
        phonecontroller.value.text = data.phone!;
      }
      refreshpage.value = false;
    } catch (e) {
      refreshpage.value = false;
      print("Prof information error: $e");
    }
  }

  void pickImage(context) async {
    await handlepermissionreq(Permission.photos, context);
    final picker = ImagePicker();
    final source = ImageSource.gallery;
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      refreshpage.value = true;
      var response = await GetAndPost.uploadfile(
          "auth/updateprofilephoto", image, context);
      if (response['status'] == "success") {
        refreshpage.value = false;
        var data = Users.fromMap(response['data']);
        userdatas.value = data;
        CacheManager.setvaluetoprefences('language', 'az');

        CacheManager.setvaluetoprefences('auth_id', data.id);

        CacheManager.setvaluetoprefences('name_surname', data.nameSurname);

        CacheManager.setvaluetoprefences('phone', data.phone);

        CacheManager.setvaluetoprefences('authtype', data.type);

        CacheManager.setvaluetoprefences(
            'profilepicture', data.additionalinfo?.image ?? '');

        namesurnamecontroller.value.text = data.nameSurname!;
        emailcontroller.value.text = data.email ?? '';
        phonecontroller.value.text = data.phone!;

        if (data.email != null && data.email != '' && data.email != ' ')
          CacheManager.setvaluetoprefences('email', data.email);
      } else {
        refreshpage.value = false;
      }
    }
  }

  void updateprofiledata(context) async {
    if (phonecontroller.value.text != null &&
        phonecontroller.value.text.length > 0 &&
        namesurnamecontroller.value.text != null &&
        namesurnamecontroller.value.text.length > 0) {
      refreshpage.value = true;
      var language =
          await CacheManager.getvaluefromsharedprefences("language") ?? 'az';
      var body = {
        'phone': phonecontroller.value.text,
        'language': language,
        'email': emailcontroller.value.text,
        'name_surname': namesurnamecontroller.value.text
      };
      var response =
          await GetAndPost.postData("auth/updatedata", body, context);
      if (response != null) {
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          var data = Users.fromMap(response['data']);
          var cachedModel =
              await CacheManager.getCachedModel<Users>('authenticated');
          if (cachedModel == null) {
            await CacheManager.cacheModel('authenticated', data);
          }

          CacheManager.setvaluetoprefences('name_surname', data.nameSurname);
          CacheManager.setvaluetoprefences('email', data.email);
          CacheManager.setvaluetoprefences('phone', data.phone);
          CacheManager.setvaluetoprefences(
              'profilepicture', data.additionalinfo?.image ?? '');

          showToastMSG(primarycolor, message, context);
        } else {
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
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
    refreshpage.value = true;

    if ((namesurnamecontroller.value.text != null &&
            namesurnamecontroller.value.text.length > 0) &&
        (birthdaycontroller.value != null &&
            birthdaycontroller.value.length > 0) &&
        (phonecontroller.value.text != null &&
            phonecontroller.value.text.length > 0)) {
      var body = {
        'phone': phonecontroller.value.text,
        'name_surname': namesurnamecontroller.value.text,
        'birthday': birthdaycontroller.value,
        'type': authType.value,
        'description': aboutcontroller.value.text.toString(),
        'language': 'az'
      };

      if (emailcontroller.value.text != null &&
          emailcontroller.value.text.trim().isNotEmpty) {
        body['email'] = emailcontroller.value.text;
      }
      var response = await GetAndPost.postData("auth/register", body, context);
      if (response != null) {
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          var data = Users.fromMap(response['data']);
          userdatas.value = data;
          CacheManager.setvaluetoprefences('language', 'az');

          CacheManager.setvaluetoprefences('auth_id', data.id);

          CacheManager.setvaluetoprefences('name_surname', data.nameSurname);

          CacheManager.setvaluetoprefences('phone', data.phone);

          CacheManager.setvaluetoprefences('authtype', data.type);

          CacheManager.setvaluetoprefences(
              'profilepicture', data.additionalinfo?.image ?? '');

          if (data.email != null && data.email != '' && data.email != ' ')
            CacheManager.setvaluetoprefences('email', data.email);

          authType.value = data.type ?? 'rider';
          Get.toNamed(
            'verificationcode',
            arguments: {'phoneNumber': phonecontroller.value.text},
          );
          showToastMSG(primarycolor, message, context);
        } else {
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        showToastMSG(errorcolor, "fillthefield".tr, context);
        refreshpage.value = false;
      }
    }
  }

  void login(context) async {
    if (phonecontroller.value.text != null &&
        phonecontroller.value.text.length > 0) {
      refreshpage.value = true;

      var body = {'phone': phonecontroller.value.text, 'language': 'az'};
      var response = await GetAndPost.postData("auth/login", body, context);
      if (response != null) {
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          var data = Users.fromMap(response['data']);
          userdatas.value = data;

          CacheManager.setvaluetoprefences('auth_id', data.id);
          CacheManager.setvaluetoprefences('name_surname', data.nameSurname);
          CacheManager.setvaluetoprefences('email', data.email);
          CacheManager.setvaluetoprefences('phone', data.phone);
          CacheManager.setvaluetoprefences('authtype', data.type);
          CacheManager.setvaluetoprefences('language', 'az');
          CacheManager.setvaluetoprefences(
              'profilepicture', data.additionalinfo?.image ?? '');
          authType.value = data.type ?? 'rider';
          Get.toNamed(
            'verificationcode',
            arguments: {'phoneNumber': phonecontroller.value.text},
          );
          showToastMSG(primarycolor, message, context);
        } else {
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
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

  void logout(context) async {
    refreshpage.value = true;
    var body = {};
    var response = await GetAndPost.postData("auth/logout", body, context);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        await CacheManager.cacheModel('authenticated', '');
        CacheManager.setvaluetoprefences('auth_id', '');

        CacheManager.setvaluetoprefences('name_surname', '');
        CacheManager.setvaluetoprefences('email', '');
        CacheManager.setvaluetoprefences('phone', '');
        CacheManager.setvaluetoprefences('authtype', '');
        CacheManager.setvaluetoprefences('profilepicture', '');
        authType.value = '';
        Get.offAllNamed(
          'login',
        );
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

  void verifycode(code, phoneNumber, context) async {
    refreshpage.value = true;

    if (code != null && code.length == 4) {
      var auth_id = await CacheManager.getvaluefromsharedprefences("auth_id");

      Map<String, dynamic> body = {
        'phone': phoneNumber,
        'auth_id': auth_id,
        'language': 'az',
        'code': code
      };

      var response = await GetAndPost.postData("auth/verifysms", body, context);
      print(response);
      if (response != null) {
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          showToastMSG(primarycolor, message, context);
          CacheManager.setvaluetoprefences('token', response['access_token']);
          Get.offAllNamed('mainscreen');
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

    Map<String, dynamic> body = {
      'phone': phoneNumber,
      'auth_id': auth_id,
      'language': 'az'
    };

    var response = await GetAndPost.fetchData("auth/resendcode", context, body);

    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
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
