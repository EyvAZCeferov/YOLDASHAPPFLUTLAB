import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yoldashapp/Constants/StaticText.dart';
import 'package:yoldashapp/Controllers/GoingController.dart';

import '../Functions/GetAndPost.dart';
import '../Functions/helpers.dart';
import '../Theme/ThemeService.dart';
import '../models/message_groups.dart';
import 'MainController.dart';

class MessagesController extends GetxController {
  var showattachmenu = false.obs;
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<TextEditingController> messagetextcontroller =
      Rx<TextEditingController>(TextEditingController());
  RxList<MessageGroups> data = <MessageGroups>[].obs;
  Rx<MessageGroups?> selectedMessageGroup = Rx<MessageGroups?>(null);
  RxList<Messages?> selectedMessageLists = RxList<Messages?>();
  List<String> quickreplies = [
    'replies.hi'.tr,
    'replies.iamcoming'.tr,
    'replies.iamwaiting'.tr
  ];
  late MainController _maincontroller = Get.put(MainController());
  final GoingController _goingController = Get.put(GoingController());
  ScrollController scrollController = new ScrollController();
  Rx<int?> auth_id = Rx<int?>(null);
  Rx<String?> authtype = Rx<String?>(null);
  Rx<String?> authtoken = Rx<String?>(null);
  final Completer<GoogleMapController> googlemapcontroller = Completer();
  Rx<GoogleMapController?> newgooglemapcontroller =
      Rx<GoogleMapController?>(null);
  RxSet<Marker?> markers = RxSet<Marker?>({});
  Rx<Position?> currentposition = Rx<Position?>(null);
  Rx<LatLng?> latLngPos = Rx<LatLng?>(null);
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(40.409264, 49.867092),
    zoom: 17.4746,
  );
  WebSocketChannel? channel;
  Rx<int> countunreadmessages = 0.obs;
  // LaravelEcho? laraecho;

  MessagesController() {
    getAuthId();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      firebaseMessagingBackgroundHandler(message);
    });
  }

  void dispose() {
    selectedMessageGroup.value = MessageGroups();
    selectedMessageLists.clear();
    getMessages(null, null);

    // laraecho?.disconnect();

    // if (selectedMessageGroup.value != null &&
    //     selectedMessageGroup.value?.id != null &&
    //     selectedMessageGroup.value?.id != '' &&
    //     selectedMessageGroup.value?.id != ' ') {
    //   leaveChatChannel(selectedMessageGroup.value!);
    // }

    Get.back();
  }

  void getcurrentposition(context) async {
    refreshpage.value = true;
    await handlepermissionreq(Permission.location, context);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentposition.value = position;
    latLngPos.value = LatLng(position.latitude, position.longitude);

    CameraPosition cameraposition =
        new CameraPosition(target: latLngPos.value!, zoom: 14);
    String language = await _maincontroller.getstoragedat('language');

    kGooglePlex = cameraposition;
    var response = await GetAndPost.fetcOtherhData(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapsApiKey&language=$language',
        context, {});
    refreshpage.value = false;

    newgooglemapcontroller.value
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
    if (response != null) {
      var nameaddress = response['results'][0]["address_components"][3]
              ['long_name'] +
          ", " +
          response['results'][0]["address_components"][2]['long_name'] +
          ", " +
          response['results'][0]["address_components"][1]['long_name'];

      markers.value.add(Marker(
          markerId: MarkerId("currentposition"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: nameaddress, snippet: 'mylocation'.tr),
          position: latLngPos.value!,
          draggable: true,
          onDrag: (newPosition) {
            currentposition.value = newPosition as Position?;
          },
          onDragEnd: ((newPosition) {
            currentposition.value = newPosition as Position?;
          })));
    }
  }

  void getAuthId() async {
    try {
      auth_id.value = await _maincontroller.getstoragedat('auth_id');
      authtype.value = await _maincontroller.getstoragedat('authtype');
      authtoken.value = await _maincontroller.getstoragedat('token');

      // if (selectedMessageGroup.value != null &&
      //     selectedMessageGroup.value?.id != null &&
      //     selectedMessageGroup.value?.id != '' &&
      //     selectedMessageGroup.value?.id != ' ') {
      //   listenChatChannel(selectedMessageGroup.value!);
      // }
    } catch (e) {
      print(
          "--------------------------SETTED NOT FOUND ---------------------- ${e.toString()}");
    }
  }

  Future<void> getMessages(context, int? selectedGroupId) async {
    try {
      if (context != null) {
        refreshpage.value = true;
      }
      Map<String, dynamic> body = {};
      var response;

      if (selectedGroupId != null && selectedGroupId > 0) {
        response =
            await GetAndPost.fetchData("chats/$selectedGroupId", context, body);
      } else {
        response = await GetAndPost.fetchData("chats", context, body);
      }

      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          countunreadmessages.value = 0;
          if (response['data'] != null) {
            if (selectedGroupId != null && selectedGroupId > 0) {
              selectedMessageGroup.value =
                  MessageGroups.fromMap(response['data']);
              selectedMessageLists.value =
                  selectedMessageGroup.value?.messages! ?? [];
              listenChatChannel(selectedMessageGroup.value!);
              scrollDown();
            } else {
              data.value = (response['data'] as List).map((dat) {
                MessageGroups messagegroup = MessageGroups.fromMap(dat);
                countunreadmessages.value += countMessageUnread(
                    messagegroup.messages as List<Messages>,
                    auth_id.value as int);
                return messagegroup;
              }).toList();
            }
          }
        } else {
          // if (context != null) {
          //   showToastMSG(errorcolor, message, context);
          // }
        }
        refreshpage.value = false;
      } else {
        refreshpage.value = false;
        data.value = [];
      }
    } catch (e) {
      refreshpage.value = false;
      print(
          "----------------------------------MESSAGES CONTROLLER GET MESSAGE------------------------${e.toString()}");
    }
  }

  void toggleattachmenu() {
    showattachmenu.value = !showattachmenu.value;
  }

  void getnewmark(LatLng latlng, context) async {
    markers.value = {};
    latLngPos.value = latlng;
    markers.value.add(Marker(
        markerId: MarkerId("currentposition"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow:
            InfoWindow(title: "mylocation".tr, snippet: 'mylocation'.tr),
        position: latlng,
        draggable: true,
        onDrag: (newPosition) {
          currentposition.value = newPosition as Position?;
        },
        onDragEnd: ((newPosition) {
          currentposition.value = newPosition as Position?;
        })));
  }

  void pickImage(context) async {
    await handlepermissionreq(Permission.photos, context);
    final picker = ImagePicker();
    final source = ImageSource.gallery;
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      refreshpage.value = true;
      var response = await GetAndPost.uploadfile(
          "messages/sendphoto/${selectedMessageGroup.value?.id}",
          image,
          context);
      refreshpage.value = false;
      if (response['status'] == "success") {
        getMessages(context, selectedMessageGroup.value?.id);
        scrollDown();
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
              Obx(
                () => Expanded(
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: GoogleMap(
                        mapType: MapType.terrain,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: kGooglePlex,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: true,
                        myLocationEnabled: true,
                        markers:
                            markers.isNotEmpty ? Set<Marker>.from(markers) : {},
                        onMapCreated: (GoogleMapController controller) {
                          googlemapcontroller.complete(controller);
                          newgooglemapcontroller.value = controller;
                          getcurrentposition(context);
                        },
                        onCameraMove: (cameraPosition) {
                          getnewmark(cameraPosition.target, context);
                        },
                        onLongPress: (LatLng latlng) {
                          getnewmark(latlng, context);
                        },
                      )),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  sendlocationviamessage(context);
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
    try {
      refreshpage.value = false;

      if (messagetextcontroller.value.text != null &&
          messagetextcontroller.value.text != '' &&
          messagetextcontroller.value.text != ' ') {
        MessageGroups oldmessagegroup = selectedMessageGroup.value!;
        var body = {
          'message_group_id': oldmessagegroup.id,
          'message': messagetextcontroller.value.text ?? '',
          'type': 'TEXT'
        };

        var response = await GetAndPost.postData("messages", body, context);
        if (response != null) {
          getMessages(context, oldmessagegroup.id);
          String status = response['status'];
          String message = "";
          if (response['message'] != null) message = response['message'];
          if (status == "success") {
            messagetextcontroller.value.text = '';
            refreshpage.value = false;
            scrollDown();
          } else {
            messagetextcontroller.value.text = '';
            showToastMSG(errorcolor, message, context);
          }
          refreshpage.value = false;
        } else {
          messagetextcontroller.value.text = '';
          refreshpage.value = false;
          // showToastMSG(errorcolor, "errordatanotfound".tr, context);
        }
      } else {
        refreshpage.value = false;
        showToastMSG(errorcolor, 'messageisnothavenull'.tr, context);
      }
    } catch (e) {
      print(
          "------------------------SEND TEXT MESSAGE------------------${e.toString()}");
    }
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 150,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendlocationviamessage(context) async {
    refreshpage.value = true;
    if (latLngPos.value?.latitude != null &&
        latLngPos.value?.longitude != null &&
        latLngPos.value!.latitude != '' &&
        latLngPos.value!.longitude != '') {
      MessageGroups oldmessagegroup = selectedMessageGroup.value!;
      var latlng = latLngPos.value!.latitude.toString() +
          ',' +
          latLngPos.value!.longitude.toString();
      var body = {
        'message_group_id': oldmessagegroup.id,
        'message': latlng.toString(),
        'type': 'LOCATION'
      };
      var response = await GetAndPost.postData("messages", body, context);
      if (response != null) {
        getMessages(context, oldmessagegroup.id);
        Get.back();
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          scrollDown();
          markers.value = {};
          refreshpage.value = false;
        }
        refreshpage.value = false;
      }
    } else {
      refreshpage.value = false;
      showToastMSG(errorcolor, "pleaseselectplaceandclick".tr, context);
    }
  }

  void callpageredirect(type, dynamic? value, context) async {
    try {
      var statusMic = await handlepermissionreq(Permission.microphone, context);
      if (type == "video") {
        var statusVid = await handlepermissionreq(Permission.camera, context);
        if (statusVid.isGranted) {
          Get.toNamed('/callpage/${type}', arguments: {type: type});
        }
      } else {
        launchUrlTOSITE("tel:$value");
      }
    } catch (error) {
      showToastMSG(errorcolor, error.toString(), context);
    }
  }

  void createandredirectchat(sender_id, receiver_id, context) async {
    try {
      _goingController.refreshpage.value = true;
      refreshpage.value = true;
      var body = {
        'sender_id': sender_id,
        'receiver_id': receiver_id,
      };
      var response = await GetAndPost.postData(
          "messages_createandredirectchat", body, context);
      if (response != null) {
        String status = response['status'];
        String message = "";
        if (response['message'] != null) message = response['message'];
        if (status == "success") {
          await getMessages(context, response['data']);
          refreshpage.value = false;
          _goingController.refreshpage.value = false;
          Get.toNamed('/messages/${response['data']}',
              arguments: selectedMessageGroup.value);
        }
      }
    } catch (e) {
      showToastMSG(errorcolor, e.toString(), context);
    }
  }

  void readmessage(int messageid, int user_id, int auth_id, context) async {
    if (user_id != auth_id) {
      var body = {};
      var response =
          await GetAndPost.patchData("messages/$messageid", body, context);
      if (response != null) {
        String status = response['status'];
        if (status == "success") {
        } else {
          showToastMSG(errorcolor, "pleaseselectplaceandclick".tr, context);
        }
      }
    }
  }

  void listenChatChannel(MessageGroups messageGroup) {
    // laraecho = LaravelEcho.init(
    //     token: authtoken.value!,
    //     channel: 'chat-${selectedMessageGroup.value!.id}');
  }

  void leaveChatChannel(MessageGroups messageGroup) {
    try {
      // laraecho?.pusherUnsubscribe('chat.${messageGroup.id}');
    } catch (e) {
      print(
          "----------------Leaving Error Channel-----------------------${e.toString()}");
    }
  }
}
