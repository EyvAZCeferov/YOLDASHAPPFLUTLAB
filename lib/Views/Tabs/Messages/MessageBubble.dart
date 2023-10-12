import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../../Constants/ImageClass.dart';
import '../../../Functions/helpers.dart';

import '../../../Constants/StaticText.dart';
import '../../../Theme/ThemeService.dart';

class MessageBubble extends StatelessWidget {
  final String type;
  final String message;
  final bool isMine;

  const MessageBubble({
    Key? key,
    required this.type,
    required this.message,
    required this.isMine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: isMine ? primarycolor : Colors.white,
        borderRadius: get_border_radius(isMine),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Align(
        alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: createmessagecontent(context, type, message, isMine),
      ),
    );
  }

  BorderRadius get_border_radius(bool type) {
    if (type == true) {
      return BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(0),
      );
    } else {
      return BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(15),
      );
    }
  }

  openMapsSheet(context, latitude, longitude) async {
    try {
      final coords = Coords(latitude, longitude);
      final title = "Gedəcəyim məkan";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: StaticText(color: darkcolor, size: normaltextSize, text: map.mapName, weight: FontWeight.bold),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  createmessagecontent(context, type, message, isMine) {
    final Completer<GoogleMapController> googlemapcontroller = Completer();
    GoogleMapController newgooglemapcontroller;
    try {
      if (type == "TEXT") {
        return StaticText(
          text: message,
          color: isMine ? whitecolor : darkcolor,
          size: normaltextSize,
          align: isMine ? TextAlign.right : TextAlign.left,
          weight: FontWeight.w400,
        );
      } else if (type == "IMAGE") {
        return SizedBox(
            width: Get.width / 2,
            height: Get.width / 2,
            child: ImageClass(
              url: getimageurl(
                "messages",
                "messages",
                message,
              ),
              type: true,
              boxfit: BoxFit.contain,
              radius: 0,
            ));
      } else if (type == "LOCATION") {
        var position = message.split(',');
        var latitude = double.parse(position[0]);
        var longitude = double.parse(position[1]);

        Set<Marker> markers = {
          Marker(
            markerId: MarkerId("pickup"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            infoWindow:
                InfoWindow(title: "mylocation".tr, snippet: 'mylocation'.tr),
            position: LatLng(latitude, longitude),
            draggable: true,
          )
        };

        return SizedBox(
          width: Get.width / 2,
          height: Get.width / 3,
          child: GestureDetector(
            onTap: () async {
              await openMapsSheet(context, latitude, longitude);
            },
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationEnabled: false,
              markers: markers.isNotEmpty ? Set<Marker>.from(markers) : {},
              onMapCreated: (GoogleMapController controller) {
                googlemapcontroller.complete(controller);
                newgooglemapcontroller = controller;
              },
              initialCameraPosition:
                  CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
              onTap: (LatLng latlng) async {
                await openMapsSheet(context, latlng.latitude, latlng.longitude);
              },
            ),
          ),
        );
      } else {
        return StaticText(
          text: message,
          color: isMine ? whitecolor : darkcolor,
          size: normaltextSize,
          align: isMine ? TextAlign.right : TextAlign.left,
          weight: FontWeight.w400,
        );
      }
    } catch (e) {
      print("ERROR: ${e.toString()}");
    }
  }
}
