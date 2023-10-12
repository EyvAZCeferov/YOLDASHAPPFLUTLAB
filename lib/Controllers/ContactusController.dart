import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../models/settings.dart';

class ContactusController extends GetxController {
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<Settings?> settingModel = Rx<Settings?>(null);
  Rx<TextEditingController> emailcontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> phonecontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> namesurnamecontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> subjectcontroller =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> messagecontroller =
      Rx<TextEditingController>(TextEditingController());
      Rx<String> responseanswer=Rx<String>('');

  Future<void> fetchSettings() async {
    try {
      refreshpage.value = true;
      Map<String, dynamic> body = {};
      var response = await GetAndPost.fetchData("setting", null, body);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          if (response['data'] != null) {
            settingModel.value = Settings.fromMap(response['data']);
            refreshpage.value = false;
          } else {
            refreshpage.value = false;
            
          }
          refreshpage.value = false;
        } else {
          refreshpage.value = false;
        }
      }
    } catch (e) {
      refreshpage.value = false;
      print(e.toString());
    }
  }

  Future<void> sendmessage(context) async {
    refreshpage.value = true;
    
    if ((namesurnamecontroller.value.text != null &&
            namesurnamecontroller.value.text.length > 0) &&
        (phonecontroller.value.text != null &&
            phonecontroller.value.text.length > 0)) {
      Map<String, dynamic> body = {
        'language': 'az',
        'viewtype':'json'
      };

      if (emailcontroller.value.text != null &&
          emailcontroller.value.text.trim().isNotEmpty &&
          emailcontroller.value.text != '' &&
          emailcontroller.value.text != ' ') {
        body['email'] = emailcontroller.value.text;
      }

       if (phonecontroller.value.text != null &&
          phonecontroller.value.text.trim().isNotEmpty &&
          phonecontroller.value.text != '' &&
          phonecontroller.value.text != ' ') {
        body['phone'] = phonecontroller.value.text;
      }

      if (subjectcontroller.value.text != null &&
          subjectcontroller.value.text.trim().isNotEmpty &&
          subjectcontroller.value.text != '' &&
          subjectcontroller.value.text != ' ') {
        body['subject'] = subjectcontroller.value.text;
      }

      if (namesurnamecontroller.value.text != null &&
          namesurnamecontroller.value.text.trim().isNotEmpty &&
          namesurnamecontroller.value.text != '' &&
          namesurnamecontroller.value.text != ' ') {
        body['namesurname'] = namesurnamecontroller.value.text;
      }

      if (messagecontroller.value.text != null &&
          messagecontroller.value.text.trim().isNotEmpty &&
          messagecontroller.value.text != '' &&
          messagecontroller.value.text != ' ') {
        body['message'] = messagecontroller.value.text;
      }

    
      

      var response = await GetAndPost.postData("https://yoldash.app/contact", body, context);
      if (response != null) {
        String status = response['status'];
        String message = '';
        if (response['message'] != null &&
            response['message'] != '' &&
            response['message'] != ' ') message = response['message'];
        if (status == "success") {
          refreshpage.value = false;
          responseanswer.value=response['message'];
          showToastMSG(primarycolor, message, context);
          namesurnamecontroller.value.text='';
          emailcontroller.value.text='';
          phonecontroller.value.text='';
          subjectcontroller.value.text='';
          messagecontroller.value.text='';
          
          Future.delayed(Duration(seconds: 2), () {
              responseanswer.value='';
            });

        } else {
          refreshpage.value = false;
          showToastMSG(errorcolor, message, context);
        }
      } else {
        showToastMSG(errorcolor, "fillthefield".tr, context);
        refreshpage.value = false;
      }
    } else {
      refreshpage.value = false;
      showToastMSG(errorcolor, "fillthefield".tr, context);
    }
  }
}
