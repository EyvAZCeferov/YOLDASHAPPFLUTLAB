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
  Rx<TextEditingController?> marka =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController?> model =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController?> color =
      Rx<TextEditingController>(TextEditingController());
  Rx<String?> driving_licence = Rx<String?>(null);
  Rx<String?> id_card = Rx<String?>(null);
  Rx<String?> technical_passport = Rx<String?>(null);
  Rx<TextEditingController> licensePlateController =
      Rx<TextEditingController>(TextEditingController());
  RxList<AutoType?> autotype = <AutoType?>[].obs;
  Rx<AutoType?> selectedAutotype = Rx<AutoType?>(null);
  RxList<String> autoimages = RxList<String>(['', '', '', '', '']);

  Future<void> fetchDatas(context) async {
    try {
      refreshpage.value = true;
      Map<String, dynamic> body = {};
      var response = await GetAndPost.fetchData("automobils", context, body);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          refreshpage.value = false;
          if (response['data'] != null && response['data'].length>0 && response['data'] !='' && response['data'] !=' ') {
            data.value = (response['data'] as List).map((dat) {
              return Automobils.fromMap(dat);
            }).toList();

            if (data != null && data.length>0) {
              selectedAutomobil.value = data.firstWhere(
                  (automobil) => automobil.selected == true,
                  orElse: () => Automobils());
            } else {
              selectedAutomobil.value = Automobils();
            }
            refreshpage.value = false;
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
    } catch (e) {
      refreshpage.value = false;
      print("AUTOMOBILS ERROR");
      print(e.toString());
      showToastMSG(errorcolor, e.toString(), context);
    }
  }

  Future<void> fetchModels(BuildContext context, String type) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response =
        await GetAndPost.fetchData("automobils_data/" + type, context, body);
    if (response != null) {
      String status = response['status'];
      String message = "";
      if (response['message'] != null) message = response['message'];
      if (status == "success") {
        if (response['data'] != null) {
          if (type == "types") {
            autotype.value = (response['data'] as List).map((dat) {
              return AutoType.fromMap(dat);
            }).toList();
          }
        }

        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, message, context);
      }

      refreshpage.value = false;
    } else {
      refreshpage.value = false;
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
    refreshpage.value = false;
    await handlepermissionreq(Permission.photos, context);
    final picker = ImagePicker();
    final source = ImageSource.gallery;
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      refreshpage.value = false;

      final image = File(pickedFile.path);
      var response = await GetAndPost.uploadfile(
          "automobils/sendphoto/{$type}", image, context);
      print(response);
      print(type);
      if (type == "id_card") {
        id_card.value = response['data'];
      } else if (type == "driving_licence") {
        driving_licence.value = response['data'];
      } else if (type == "technical_passport") {
        technical_passport.value = response['data'];
      } else if (type.contains("types_")) {
        RegExp regex = RegExp(r'types_(\d+)');
        Match? match = regex.firstMatch(type);

        if (match != null) {
          int index = int.parse(match.group(1)!);
          autoimages[index] = response['data'];
        }
      }
    }
  }

  void addCar(context) async {
    refreshpage.value = true;
    if ((marka.value?.text != null &&
            marka.value?.text != '' &&
            marka.value?.text != ' ') &&
        (model.value?.text != null &&
            model.value?.text != '' &&
            model.value?.text != ' ') &&
        (color.value?.text != null &&
            color.value?.text != '' &&
            color.value?.text != ' ') &&
        (driving_licence.value != null &&
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
        selectedAutotype.value != null &&
        autoimages.value != null &&
        autoimages.value[0] != null &&
        autoimages.value[0] != '' &&
        autoimages.value[0] != ' ' &&
        autoimages.value[1] != null &&
        autoimages.value[1] != '' &&
        autoimages.value[1] != ' ' &&
        autoimages.value[2] != null &&
        autoimages.value[2] != '' &&
        autoimages.value[2] != ' ' &&
        autoimages.value[3] != null &&
        autoimages.value[3] != '' &&
        autoimages.value[3] != ' ') {
      Map<String, dynamic> body = {
        'driving_licence': driving_licence.value,
        'id_card': id_card.value,
        'technical_passport': technical_passport.value,
        'auto_serial_number': licensePlateController.value.text,
        'auto_type_id': selectedAutotype.value!.id,
        'marka': marka.value?.text ?? '',
        'model': model.value?.text ?? '',
        'color': color.value?.text ?? '',
        'images': autoimages.value ?? []
      };
      var response = await GetAndPost.postData("automobils", body, context);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          refreshpage.value = false;
          fetchDatas(context);
          Get.back();
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

  void getautomobildata(id, context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response = await GetAndPost.fetchData("automobils/$id", context, body);
    if (response != null) {
      String status = response['status'];
      String message = "";
      if (response['message'] != null) message = response['message'];
      if (status == "success") {
        selectedAutomobil.value = Automobils();
        if (response['data'] != null) {
          refreshpage.value = false;
          selectedAutomobil.value = Automobils.fromMap(response['data']);
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, message, context);
      }
    }
  }
}
