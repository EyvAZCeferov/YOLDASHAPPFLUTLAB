import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Controllers/MainController.dart';
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
  Rx<TextEditingController> messagetextcontroller =
      Rx<TextEditingController>(TextEditingController());
  RxList<MessageGroups> data = <MessageGroups>[].obs;
  Rx<MessageGroups?> selectedMessageGroup = Rx<MessageGroups?>(null);
  List<String> quickreplies = [
    'replies.hi'.tr,
    'replies.iamcoming'.tr,
    'replies.iamwaiting'.tr
  ];
  late MainController _maincontroller = Get.put(MainController());

  Future<void> getMessages(context) async {
    refreshpage.value = true;
    Map<String, dynamic> body = {};
    var response = await GetAndPost.fetchData("chats", context, body);
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
                child: Directionality(
                  textDirection: TextDirection.ltr,
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

  void sendtextmessage(context) async {
    refreshpage.value = true;

    if (messagetextcontroller.value.text != null) {
      var auth_id = await _maincontroller.getstoragedat('auth_id');
      MessageGroups oldmessagegroup = selectedMessageGroup.value!;
      var body = {
        'message_group_id': oldmessagegroup.id,
        'message': messagetextcontroller.value.text,
        'type': 'TEXT'
      };
      var response = await GetAndPost.postData("messages", body, context);
      if (response != null) {
        String status = response['status'];
        String message = response['message'];
        if (status == "success") {
          List<Messages>? messages = oldmessagegroup.messages;
          messages?.add(Messages(
            messageGroupId: oldmessagegroup.id,
            message: messagetextcontroller.value.text,
            userId: auth_id,
            messageelementtype: "TEXT",
            status: true,
          ));
          selectedMessageGroup.value = null;
          selectedMessageGroup.value = MessageGroups(
            id: oldmessagegroup.id,
            receiverId: oldmessagegroup.receiverId,
            senderId: oldmessagegroup.senderId,
            count: oldmessagegroup.count,
            receiverName: oldmessagegroup.receiverName,
            senderName: oldmessagegroup.senderName,
            receiverImage: oldmessagegroup.receiverImage,
            senderImage: oldmessagegroup.senderImage,
            messages: messages,
          );

          messagetextcontroller.value.text = '';
          getMessages(context);
        } else {
          messagetextcontroller.value.text = '';
          showToastMSG(errorcolor, message, context);
        }
        refreshpage.value = false;
      } else {
        messagetextcontroller.value.text = '';
        refreshpage.value = false;
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } else {
      refreshpage.value = false;
      showToastMSG(errorcolor, 'messageisnothavenull'.tr, context);
    }
  }

  void callpageredirect(type, context) async {
    try {
      if (type == "video") {
        handlepermissionreq(Permission.camera, context);
      }

      handlepermissionreq(Permission.microphone, context);

      Get.toNamed('/callpage/${type}', arguments: {type: type});
    } catch (error) {
      showToastMSG(errorcolor, error, context);
    }
  }
}
