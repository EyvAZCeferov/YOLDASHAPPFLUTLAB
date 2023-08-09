import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Functions/GetAndPost.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/models/automobils.dart';

class AutomobilsController extends GetxController {
  Rx<bool> refreshpage = Rx<bool>(false);
  RxList<Automobils> data = RxList<Automobils>();
  Rx<Automobils?> selectedAutomobil = Rx<Automobils?>(null);

  Rx<File?> suruculukvesiqesi = Rx<File?>(null);
  Rx<File?> idcard = Rx<File?>(null);
  Rx<File?> autotexpasport = Rx<File?>(null);
  Rx<TextEditingController> licensePlateController =
      Rx<TextEditingController>(TextEditingController());

  Future<void> fetchDatas(context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response = await GetAndPost.fetchData("automobils", context, body);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        data.value = (response['data'] as List).map((dat) {
          return Automobils(
              id: dat["id"],
              userId: dat["user_id"],
              drivingLicence: dat["driving_licence"],
              idCard: dat["id_card"],
              technicalPassport: dat["technical_passport"],
              autoSerialNumber: dat["auto_serial_number"],
              selected: dat["selected"],
              autoMarkId: dat["auto_mark_id"],
              autoModelId: dat["auto_model_id"],
              autoColorId: dat["auto_color_id"],
              createdAt: dat["created_at"],
              updatedAt: dat["updated_at"],
              deletedAt: dat["deleted_at"],
              automark: dat["automark"] == null
                  ? null
                  : Automark.fromMap(dat["automark"]),
              automodels: dat["automodels"] == null
                  ? null
                  : Automodels.fromMap(dat["automodels"]),
              autocolors: dat["autocolors"] == null
                  ? null
                  : Autocolors.fromMap(dat["autocolors"]),
              images: dat["images"].length == 0
                  ? null
                  : List<Images>.from(
                      dat["images"].map((e) => Images.fromMap(e))));
        }).toList();

        selectedAutomobil.value = data.firstWhere(
            (automobil) => automobil.selected == true,
            orElse: () => Automobils());
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
    final galleryStatus = await Permission.photos.request();
    final cameraStatus = await Permission.camera.request();

    if (galleryStatus.isGranted && cameraStatus.isGranted) {
      final picker = ImagePicker();
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: StaticText(
                text: "uploadimage".tr,
                color: darkcolor,
                size: buttontextSize,
                weight: FontWeight.w500,
                align: TextAlign.center),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                child: StaticText(
                    text: "gallery".tr,
                    color: darkcolor,
                    size: normaltextSize,
                    weight: FontWeight.w500,
                    align: TextAlign.center),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                child: StaticText(
                    text: "camera".tr,
                    color: darkcolor,
                    size: normaltextSize,
                    weight: FontWeight.w500,
                    align: TextAlign.center),
              ),
            ],
          );
        },
      );

      if (source != null) {
        final pickedFile = await picker.getImage(source: source);
        if (pickedFile != null) {
          final file = File(pickedFile.path);
          if (type == "suruculuk") {
            suruculukvesiqesi.value = file;
          } else if (type == "idcard") {
            idcard.value = file;
          } else if (type == "autotexpasport") {
            autotexpasport.value = file;
          }
          showToastMSG(primarycolor, 'imageuploaded'.tr, context);
        }
      }
    } else {
      if (galleryStatus.isDenied || cameraStatus.isDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr, context);
      } else if (galleryStatus.isPermanentlyDenied ||
          cameraStatus.isPermanentlyDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr, context);
      }
    }
  }
}
