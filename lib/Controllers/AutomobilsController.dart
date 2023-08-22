import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../models/automobils.dart';

class AutomobilsController extends GetxController {
  Rx<bool> refreshpage = Rx<bool>(false);
  RxList<Automobils> data = RxList<Automobils>();
  Rx<Automobils?> selectedAutomobil = Rx<Automobils?>(null);
  Rx<String?> driving_licence = Rx<String?>(null);
  Rx<String?> id_card = Rx<String?>(null);
  Rx<String?> technical_passport = Rx<String?>(null);
  Rx<TextEditingController> licensePlateController =
      Rx<TextEditingController>(TextEditingController());
  RxList<Automodels?> automodels = <Automodels>[].obs;
  RxList<Autocolors?> autocolors = <Autocolors?>[].obs;
  RxList<Automark?> automarks = <Automark?>[].obs;
  Rx<Automodels?> selectedAutomodel = Rx<Automodels?>(null);
  Rx<Automark?> selectedAutomark = Rx<Automark?>(null);
  Rx<Autocolors?> selectedAutocolor = Rx<Autocolors?>(null);

  Future<void> fetchDatas(context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};

    var response = await GetAndPost.fetchData("automobils", context, body);
     if (response != null) {
      String status = response['status'];
      String message = "";
      if (response['message'] != null) message = response['message'];
      if (status == "success") {
        if (response['data'] != null) {
          data.value = (response['data'] as List).map((dat) {
            return Automobils.fromMap(dat);
          }).toList();

          selectedAutomobil.value = data.firstWhere(
              (automobil) => automobil.selected == true,
              orElse: () => Automobils());
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      data.value = [];
      selectedAutomobil.value = Automobils();
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }

  void fetchModels(BuildContext context, String type) async {
    
    Map<String, dynamic> body = {};
    var response =
        await GetAndPost.fetchData("automobils_data/" + type, context, body);
        print(response);
    if (response != null) {
      String status = response['status'];
      String message = "";
      if (response['message'] != null) message = response['message'];
      if (status == "success") {
        
        if (response['data'] != null) {
          if (type == "marks") {
            automarks.value = (response['data'] as List).map((dat) {
              return Automark.fromMap(dat);
            }).toList();
          } else if (type == "models" || type.contains("models")) {
            automodels.value = (response['data'] as List).map((dat) {
              return Automodels.fromMap(dat);
            }).toList();
          } else if (type == "colors") {
            autocolors.value = (response['data'] as List).map((dat) {
              return Autocolors.fromMap(dat);
            }).toList();
          }
          
        } else {
          
        }
      } else {
        
        showToastMSG(errorcolor, message, context);
      }
    }
  }

  Future<void> updateSelection(int index, bool value, context) async {
    refreshpage.value = true;
    var selectedelement;

    selectedelement = data.firstWhere((automobil) => automobil.id == index,
        orElse: () => Automobils());

    var body = {};
    var response = await GetAndPost.patchData(
        "automobils/${selectedelement.id}", body, context);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        fetchDatas(context);
      } else {
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      data.value = [];
      selectedAutomobil.value = Automobils();
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }

  void pickImage(type, context) async {
    await handlepermissionreq(Permission.photos, context);
    final picker = ImagePicker();
    final source = ImageSource.gallery;
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      var response = await GetAndPost.uploadfile(
          "automobils/sendphoto/{$type}", image, context);
      if (type == "id_card") {
        id_card.value = response['data'];
      } else if (type == "driving_licence") {
        driving_licence.value = response['data'];
      } else if (type == "technical_passport") {
        technical_passport.value = response['data'];
      }
    }
  }

  void addCar(context) async {
    refreshpage.value = true;
    if ((driving_licence.value != null &&
            driving_licence.value != '' &&
            driving_licence.value != ' ') &&
        (id_card.value != null &&
            id_card.value != '' &&
            id_card.value != ' ') &&
        (technical_passport.value != null &&
            technical_passport.value != '' &&
            technical_passport.value != ' ') &&
        (licensePlateController.value.text != null &&
            licensePlateController.value.text != '' &&
            licensePlateController.value.text != ' ') &&
        selectedAutocolor.value != null &&
        selectedAutomark.value != null &&
        selectedAutomodel.value != null) {
      Map<String, dynamic> body = {
        'driving_licence': driving_licence.value,
        'id_card': id_card.value,
        'technical_passport': technical_passport.value,
        'auto_serial_number': licensePlateController.value.text,
        'auto_mark_id': selectedAutomark.value!.id,
        'auto_model_id': selectedAutomodel.value!.id,
        'auto_color_id': selectedAutocolor.value!.id,
      };
      print(body);
      var response = await GetAndPost.postData("automobils", body, context);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          refreshpage.value = false;
          fetchDatas(context);
          Get.offAllNamed('/mainscreen');
        } else {
          refreshpage.value = false;
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        data.value = [];
        selectedAutomobil.value = Automobils();
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } else {
      refreshpage.value = false;
      showToastMSG(errorcolor, "fillthefield".tr, context);
    }
  }
}
