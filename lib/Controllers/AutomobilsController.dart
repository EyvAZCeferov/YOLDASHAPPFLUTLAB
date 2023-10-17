import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../Constants/ButtonElement.dart';
import '../Constants/Devider.dart';
import '../Constants/StaticText.dart';
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
  Rx<Automobils?> driverautomobil = Rx<Automobils?>(null);
  Rx<bool?> really_delete = Rx<bool>(false);

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
          if (response['data'] != null &&
              response['data'].length > 0 &&
              response['data'] != '' &&
              response['data'] != ' ') {
            data.value = (response['data'] as List).map((dat) {
              return Automobils.fromMap(dat);
            }).toList();

            if (data != null && data.length > 0) {
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
          // showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        data.value = [];
        selectedAutomobil.value = Automobils();
        // showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } catch (e) {
      refreshpage.value = false;
      print("AUTOMOBILS ERROR");
      print(e.toString());
      // showToastMSG(errorcolor, e.toString(), context);
    }
  }

  Future<void> fetchUserCar(context, userId) async {
    try {
      refreshpage.value = true;
      Map<String, dynamic> body = {
        'user_id': userId,
      };
      var response =
          await GetAndPost.fetchData("automobils_getby_user", context, body);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          refreshpage.value = false;
          if (response['data'] != null) {
            driverautomobil.value = Automobils.fromMap(response['data']);
          } else {
            refreshpage.value = false;
          }
        } else {
          refreshpage.value = false;
        }
      } else {
        refreshpage.value = false;
        driverautomobil.value = Automobils();
      }
    } catch (e) {
      refreshpage.value = false;
      print(
          "-------------------------------------------AUTOMOBILS BY USER ERROR-------------------------------------");
      print(e.toString());
    }
  }

  void removeAutomobil(id, context) async {
    refreshpage.value = true;
    if (really_delete.value == false) {
      refreshpage.value = false;
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 140,
              color: Colors.white,
              child: Column(
                children: [
                  Devider(),
                  StaticText(
                    color: secondarycolor,
                    size: buttontextSize,
                    text: "really_delete".tr,
                    weight: FontWeight.w500,
                    align: TextAlign.center,
                    maxline: 3,
                    textOverflow: TextOverflow.clip,
                  ),
                  Devider(size: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonElement(
                        text: "really_delete_no".tr,
                        bgColor: errorcolor,
                        fontsize: 14,
                        textColor: whitecolor,
                        onPressed: () => Get.back(),
                        width: Get.width / 3,
                        height: 50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      SizedBox(width: 25),
                      ButtonElement(
                        text: "really_delete_yes".tr,
                        bgColor: primarycolor,
                        fontsize: 14,
                        textColor: whitecolor,
                        onPressed: () {
                          really_delete.value = true;
                          refreshpage.value = false;
                          Get.back();
                          removeAutomobil(id, context);
                        },
                        width: Get.width / 3,
                        height: 50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    } else {
      Map<String, dynamic> body = {
        "id": id,
      };
      var response = await GetAndPost.postData("removeAutomobil", body, context);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          really_delete.value = false;
          fetchDatas(context);
          refreshpage.value = false;
        } else {
          showToastMSG(errorcolor, message, context);
          refreshpage.value = false;
        }
      } else {
        refreshpage.value = false;
      }
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
