import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Functions/GetAndPost.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/models/message_groups.dart';

class MessagesController extends GetxController {
  var showattachmenu = false.obs;
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<File?> imageFile = Rx<File?>(null);
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  LatLng? selectedCoordinate;
  late TextEditingController messagetextcontroller = TextEditingController();
  RxList<MessageGroups> data = <MessageGroups>[].obs;
  MessageGroups? selectedMessageGroup;

  Future<void> getMessages(context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response = await GetAndPost.fetchData("chats/messages", context, body);
    if (response != null) {
      String status = response['status'];
      String message = response['message'];
      if (status == "success") {
        data.value = (response['data'] as List).map((dat) {
          List<Messages> messages = (dat['messages'] as List)
              .map((messageData) => Messages.fromJson(messageData))
              .toList();

          return MessageGroups(
            id: dat["id"],
            receiverId: dat["receiver_id"],
            senderId: dat["sender_id"],
            messagegroupCreatedAt: dat["messagegroup_created_at"],
            count: dat["count"],
            receiverName: dat["receiver_name"],
            senderName: dat["sender_name"],
            receiverImage: dat["receiver_image"],
            senderImage: dat["sender_image"],
            messages: messages,
          );
        }).toList();
      } else {
        showToastMSG(errorcolor, message, context);
      }
      refreshpage.value = false;
    } else {
      refreshpage.value = false;
      data.value = [];
      showToastMSG(errorcolor, "errordatanotfound".tr, context);
    }
  }

  void toggleattachmenu() {
    showattachmenu.value = !showattachmenu.value;
  }

  void pickImage(context) async {
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
        showToastMSG(errorcolor, 'permissiondenied'.tr, context);
      } else if (status.isPermanentlyDenied) {
        showToastMSG(errorcolor, 'permissiondenied'.tr, context);
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

  void sendmessage(context) {
    if (messagetextcontroller.value != null) {
      print(messagetextcontroller.value);
    } else {
      showToastMSG(errorcolor, 'messageisnothavenull'.tr, context);
    }
  }

  void callpageredirect(type, context) async {
    try {
      if (type == "video") {
        _handlecameraandmic(Permission.camera, context);
      } else {
        print("calling");
      }

      _handlecameraandmic(Permission.microphone, context);

      Get.toNamed('/callpage/${type}', arguments: {type: type});
    } catch (error) {
      showToastMSG(errorcolor, error, context);
    }
  }

  void _handlecameraandmic(Permission permission, context) async {
    final status = await permission.request();
    if (status.isDenied) {
      showToastMSG(errorcolor, "permissiondenied".tr, context);
    }
  }
}
