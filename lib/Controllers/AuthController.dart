import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldashapp/Controllers/GoingController.dart';

import '../Functions/CacheManager.dart';
import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../models/users.dart';
import 'MainController.dart';
import '../Constants/StaticText.dart';
import '../Constants/Devider.dart';

class AuthController extends GetxController {
  final MainController _maincontroller = Get.put(MainController());
  final GoingController goingcontroller = Get.put(GoingController());
  Rx<TextEditingController> namesurnamecontroller =
      Rx<TextEditingController>(TextEditingController());
  RxInt gender = RxInt(1);
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
  RxBool agreeterms = RxBool(false);
  Rx<Users?> driverpage = Rx<Users?>(null);
  Map<int, String> items = {
    1: 'male',
    2: 'female',
  };
  List social_statuses = ['sehid', 'telebe', ''];
  Rx<String?> socialstatus = Rx<String>('');
  Rx<String?> submitting_document = Rx<String?>(null);
  Rx<String?> human_document = Rx<String?>(null);
  
  AuthController() {
    init();
  }

  void init() async {
    var auth_id = await _maincontroller.getstoragedat('auth_id');
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
        authType.value = data.statusActions!.first.type!;
        namesurnamecontroller.value.text = data.nameSurname!;
        emailcontroller.value.text = data.email ?? '';
        phonecontroller.value.text = data.phone!;

        CacheManager.setvaluetoprefences('auth_id', data.id);

        CacheManager.setvaluetoprefences('name_surname', data.nameSurname);

        CacheManager.setvaluetoprefences('phone', data.phone);

        CacheManager.setvaluetoprefences(
            'authtype', data.statusActions?.first.type);

        CacheManager.setvaluetoprefences(
            'profilepicture', data.additionalinfo?.image ?? '');
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

        CacheManager.setvaluetoprefences('auth_id', data.id);

        CacheManager.setvaluetoprefences('name_surname', data.nameSurname);

        CacheManager.setvaluetoprefences('phone', data.phone);

        CacheManager.setvaluetoprefences(
            'authtype', data.statusActions?.first.type);

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

  void pickImageTesdigleyici(type, context) async {
    refreshpage.value = false;
    await handlepermissionreq(Permission.photos, context);
    final picker = ImagePicker();
    final source = ImageSource.gallery;
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      refreshpage.value = false;

      final image = File(pickedFile.path);
      var response = await GetAndPost.uploadfile(
          "users_sendphoto/{$type}", image, context);

      if (type == "submitting_document") {
        submitting_document.value = response['data'];
      }else if (type == "human_document") {
        human_document.value = response['data'];
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

  void changeprofpage(context) async {
    refreshpage.value = true;

    var body = {};
    if (authType.value == "rider") {
      body['type'] = "driver";
    } else {
      body['type'] = "rider";
    }

    var response = await GetAndPost.postData("auth/change_type", body, context);
    if (response != null) {
      String status = response['status'];
      String message = '';
      if (response['message'] != null &&
          response['message'] != '' &&
          response['message'] != ' ') message = response['message'];
      if (status == "success") {
        
        getalldataoncache(context);
        goingcontroller.getcurrentrides(context);
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, message, context);
      }
    } else {
      refreshpage.value = false;
    }
  }

  void selectlangknowns(lang, context) {
    refreshpage.value = true;
    bool exists = selectedlang.value.contains(lang);
    if (exists == true) {
      selectedlang.value.remove(lang);
    } else {
      selectedlang.value.add(lang);
    }
    refreshpage.value = false;
  }

  void register(context) async {
    refreshpage.value = true;

    if (agreeterms.value == true) {
      if ((namesurnamecontroller.value.text != null &&
              namesurnamecontroller.value.text.length > 0) &&
          (birthdaycontroller.value != null &&
              birthdaycontroller.value.length > 0) &&
          (phonecontroller.value.text != null &&
              phonecontroller.value.text.length > 0)) {
        Map<String, dynamic> body = {
          'phone': phonecontroller.value.text,
          'name_surname': namesurnamecontroller.value.text,
          'birthday': birthdaycontroller.value,
          'type': authType.value,
          'socialstatus':socialstatus.value??'',
          'submitting_document':submitting_document.value??'',
          'human_document':human_document.value??'',
          'language': 'az',
        };

        if (emailcontroller.value.text != null &&
            emailcontroller.value.text.trim().isNotEmpty &&
            emailcontroller.value.text != '' &&
            emailcontroller.value.text != ' ') {
          body['email'] = emailcontroller.value.text;
        }

        if (aboutcontroller.value.text != null &&
            aboutcontroller.value.text.trim().isNotEmpty &&
            aboutcontroller.value.text != '' &&
            aboutcontroller.value.text != ' ') {
          body['description'] = aboutcontroller.value.text;
        }

        if (selectedlang.value != null && selectedlang.value.length > 0) {
          body['known_languages'] = selectedlang.value ?? [];
        }

        refreshpage.value = false;

        var response =
            await GetAndPost.postData("auth/register", body, context);
        if (response != null) {
          String status = response['status'];
          String message = '';
          if (response['message'] != null &&
              response['message'] != '' &&
              response['message'] != ' ') message = response['message'];
          if (status == "success") {
            var data = Users.fromMap(response['data']);
            userdatas.value = data;
            CacheManager.setvaluetoprefences('language', 'az');

            CacheManager.setvaluetoprefences('auth_id', data.id);

            CacheManager.setvaluetoprefences('name_surname', data.nameSurname);

            CacheManager.setvaluetoprefences('phone', data.phone);

            CacheManager.setvaluetoprefences(
                'authtype', data.statusActions?.first.type);

            CacheManager.setvaluetoprefences(
                'profilepicture', data.additionalinfo?.image ?? '');

            if (data.email != null && data.email != '' && data.email != ' ')
              CacheManager.setvaluetoprefences('email', data.email);

            authType.value = data.statusActions?.first.type ?? 'rider';
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
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, "fillthefield".tr, context);
      }
    } else {
      refreshpage.value = false;
      showToastMSG(errorcolor, "checkagree".tr, context);
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
          CacheManager.setvaluetoprefences(
              'authtype', data.statusActions?.first.type);
          CacheManager.setvaluetoprefences('language', 'az');
          CacheManager.setvaluetoprefences(
              'profilepicture', data.additionalinfo?.image ?? '');
          authType.value = data.statusActions?.first.type ?? 'rider';
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
    try {
      refreshpage.value = true;
      var body = {};
      var response = await GetAndPost.postData("auth/logout", body, context);
      if (response != null) {
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          CacheManager.removevaluefromprefences('auth_id');
          CacheManager.removevaluefromprefences('token');
          CacheManager.removevaluefromprefences('name_surname');
          CacheManager.removevaluefromprefences('email');
          CacheManager.removevaluefromprefences('phone');
          CacheManager.removevaluefromprefences('authtype');
          CacheManager.removevaluefromprefences('profilepicture');
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
    } catch (e) {
      refreshpage.value = false;
      print(e.toString());
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

  void showgendermodal(BuildContext context) {
    showModalBottomSheet(
      barrierColor: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 240,
          color: Colors.white,
          child: Column(
            children: [
              Devider(),
              StaticText(
                color: secondarycolor,
                size: buttontextSize,
                text: "gender".tr,
                weight: FontWeight.w500,
                align: TextAlign.center,
              ),
              Devider(),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var keysList = items.keys.toList();
                    var valuesList = items.values.toList();

                    var key = keysList[index];

                    var value = valuesList[index];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          title: StaticText(
                            color: darkcolor,
                            size: normaltextSize,
                            text: "gender_$value".tr,
                            weight: FontWeight.w500,
                            align: TextAlign.left,
                          ),
                          trailing: Radio<bool>(
                            value: true,
                            activeColor: primarycolor,
                            focusColor: primarycolor,
                            hoverColor: primarycolor,
                            toggleable: true,
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                            groupValue: gender.value == key ? true : false,
                            onChanged: (value) {
                              gender.value = key;
                              Get.back();
                            },
                          ),
                        ),
                        Devider(),
                      ],
                    );
                  },
                ),
              ),
              Devider(),
            ],
          ),
        );
      },
    );
  }
}
