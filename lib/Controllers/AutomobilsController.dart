import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Models/Automobils.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class AutomobilsController extends GetxController {
  RxList<Automobils> data = <Automobils>[].obs;
  Rx<File?> suruculukvesiqesi = Rx<File?>(null);
  Rx<File?> idcard = Rx<File?>(null);
  Rx<File?> autotexpasport = Rx<File?>(null);

  @override
  void onInit() {
    fetchDatas();
    super.onInit();
  }

  void fetchDatas() {
    data = [
      Automobils(
          icon: FontAwesomeIcons.car,
          name: "Wolkswagen-CC",
          statebadge: "90-NR-190",
          value: true),
      Automobils(
          icon: FontAwesomeIcons.car,
          name: "Wolkswagen-AUTO",
          statebadge: "90-BA-190",
          value: false)
    ].obs;
  }

  void updateSelection(int index, bool value) {
    for (var i = 0; i < data.length; i++) {
      if (i == index) {
        data[i].value = value;
      } else {
        data[i].value = false;
      }
    }
    data.refresh();
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
          showToastMSG(primarycolor, 'imageuploaded'.tr);
        }
      }
    } else {
      if (galleryStatus.isDenied || cameraStatus.isDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr);
      } else if (galleryStatus.isPermanentlyDenied ||
          cameraStatus.isPermanentlyDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr);
      }
    }
  }
}
