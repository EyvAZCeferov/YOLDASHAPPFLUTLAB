import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Theme/ThemeService.dart';

void showToastMSG(bgcolor, text, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: bgcolor,
    content: StaticText(
      color: whitecolor,
      size: smalltextSize,
      text: text,
      weight: FontWeight.w500,
      align: TextAlign.center,
    ),
  ));
}

const String appagid = "91e3453e50e543c6b520f7bfe0fa8b96";
const String appagcert1 = "3e389d68906643dea29aac81df9deb30";
const String appagcert2 = "5f93b97444044e53b97be9006828c102";
const String appcert1token =
    "007eJxTYGCJ8luUxbyzLDg4ym277AdVBa2W+qK4Ja8ehD+1kf5a9FGBwdIw1djE1DjV1CDV1MQ42SzJ1MggzTwpLdUgLdEiydJMz3BNSkMgI8NGASVWRgYIBPHZGSrzc1ISizMYGAAP2x6P";
const String imageurl = 'https://sovqat369777.az/uploads/';

Future<void> launchUrlTOSITE(url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}

String formatDateTime(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);
  if (difference.inSeconds < 60) {
    return "differenceinSeconds"
        .trParams({'timevar': difference.inSeconds.toString()});
  } else if (difference.inMinutes < 60) {
    return "differenceinMinutes"
        .trParams({'timevar': difference.inMinutes.toString()});
  } else if (difference.inHours < 24) {
    return "differenceinHours"
        .trParams({'timevar': difference.inHours.toString()});
  } else if (difference.inDays < 30) {
    return "differenceinDays"
        .trParams({'timevar': difference.inDays.toString()});
  } else {
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }
}

void handlepermissionreq(Permission permission, context) async {
  final status = await permission.request();
  if (status.isDenied) {
    showToastMSG(errorcolor, "permissiondenied".tr, context);
  }
}
