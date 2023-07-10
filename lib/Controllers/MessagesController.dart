import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class MessagesController extends GetxController {
  var showattachmenu = false.obs;
  Rx<File?> imageFile = Rx<File?>(null);
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  LatLng? selectedCoordinate;

  void toggleattachmenu() {
    showattachmenu.value = !showattachmenu.value;
  }

  void pickImage() async {
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
        showToastMSG(errorcolor, 'permissiondenied'.tr);
      } else if (status.isPermanentlyDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr);
      }
    }
  }

  void showmap(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(37.7749, -122.4194), // Başlangıç koordinatları
                    zoom: 12, // Yakınlaştırma seviyesi
                  ),
                  onMapCreated: (controller) {
                    googleMapController.value = controller;
                  },
                  onTap: (LatLng latLng) {
                    selectedCoordinate = latLng;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: StaticText(
                    color: secondarycolor,
                    size: normaltextSize,
                    weight: FontWeight.w500,
                    align: TextAlign.center,
                    text: "choise".tr),
              ),
            ],
          ),
        );
      },
    );
  }
}
