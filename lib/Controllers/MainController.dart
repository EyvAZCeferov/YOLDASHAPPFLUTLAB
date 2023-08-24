import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Controllers/AuthController.dart';

import '../Functions/CacheManager.dart';

class MainController extends GetxController {
  late AuthController _authController = Get.put(AuthController());

  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<String> currentlang = ''.obs;
  Rx<String> authtype = ''.obs;
  Rx<dynamic> auth_id = Rx<dynamic>(null);
  Rx<String> token = ''.obs;
  Rx<String> name_surname = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String> phone = ''.obs;
  Rx<String> profilepicture = ''.obs;

  Future<dynamic?> getstoragedat(String type) async {
    try {
      var data;
      if (type == "language") {
        data = currentlang.value;
        currentlang.value =
            data != null && data.isNotEmpty && data != '' && data != ' '
                ? data.trim()
                : await CacheManager.getvaluefromsharedprefences(type);
        data = currentlang.value;
      } else if (type == "authtype") {
        data = authtype.value;
        authtype.value =
            data != null && data.isNotEmpty && data != '' && data != ' '
                ? data.trim()
                : await CacheManager.getvaluefromsharedprefences(type);

        data = authtype.value;
      } else if (type == "token") {
        data = token.value;
        token.value =
            data != null && data.isNotEmpty && data != '' && data != ' '
                ? data.trim()
                : await CacheManager.getvaluefromsharedprefences(type);
        data = token.value;
      } else if (type == "auth_id") {
        data = auth_id.value;
        auth_id.value =
            data != null && data.isNotEmpty && data != '' && data != ' '
                ? data.trim()
                : await CacheManager.getvaluefromsharedprefences(type);

        data = auth_id.value;
      } else if (type == "name_surname") {
        data = name_surname.value;
        name_surname.value =
            data != null && data.isNotEmpty && data != '' && data != ' '
                ? data.trim()
                : await CacheManager.getvaluefromsharedprefences(type);
        data = name_surname.value;
      } else if (type == "email") {
        data = email.value;
        email.value =
            data != null && data.isNotEmpty && data != '' && data != ' '
                ? data.trim()
                : await CacheManager.getvaluefromsharedprefences(type);
        data = email.value;
      } else if (type == "phone") {
        data = phone.value;
        phone.value =
            data != null && data.isNotEmpty && data != '' && data != ' '
                ? data.trim()
                : await CacheManager.getvaluefromsharedprefences(type);
        data = phone.value;
      } else if (type == "profilepicture") {
        data = profilepicture.value;
        profilepicture.value =
            data != null && data.isNotEmpty && data != '' && data != ' '
                ? data.trim()
                : await CacheManager.getvaluefromsharedprefences(type);
        data = profilepicture.value;
      }

      return data ?? null;
    } catch (e) {
      print("Main controller error: $e");
    }
  }

  Future<void> restartapp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }
}
