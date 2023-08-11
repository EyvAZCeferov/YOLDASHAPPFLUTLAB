import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

String? getLocalizedValue(dynamic data, String type) {
  var lang = Get.locale?.languageCode ?? 'az';

  if (data != null && data.azName != null && type == 'name' && lang == 'az') {
    return data.azName;
  } else if (data != null &&
      data.ruName != null &&
      type == 'name' &&
      lang == 'ru') {
    return data.ruName;
  } else if (data != null &&
      data.enName != null &&
      type == 'name' &&
      lang == 'en') {
    return data.enName;
  } else if (data != null &&
      data.trName != null &&
      type == 'name' &&
      lang == 'tr') {
    return data.trName;
  } else if (data != null &&
      data.azSlug != null &&
      type == 'slug' &&
      lang == 'az') {
    return data.azSlug;
  } else if (data != null &&
      data.ruSlug != null &&
      type == 'slug' &&
      lang == 'ru') {
    return data.ruSlug;
  } else if (data != null &&
      data.enSlug != null &&
      type == 'slug' &&
      lang == 'en') {
    return data.enSlug;
  } else if (data != null &&
      data.trSlug != null &&
      type == 'slug' &&
      lang == 'tr') {
    return data.trSlug;
  } else if (data != null &&
      data.azDescription != null &&
      type == 'description' &&
      lang == 'az') {
    return data.azDescription;
  } else if (data != null &&
      data.ruDescription != null &&
      type == 'description' &&
      lang == 'ru') {
    return data.ruDescription;
  } else if (data != null &&
      data.enDescription != null &&
      type == 'description' &&
      lang == 'en') {
    return data.enDescription;
  } else if (data != null &&
      data.trDescription != null &&
      type == 'description' &&
      lang == 'tr') {
    return data.trDescription;
  }

  return null;
}

String maskLastFourDigits(String text) {
  if (text.length <= 4) {
    return text;
  }
  String lastFourDigits = text.substring(text.length - 4);
  String maskedDigits = '*' * 4;
  return maskedDigits + lastFourDigits;
}

IconData fontawesome(String type) {
  if (type == "visa") {
    return FontAwesomeIcons.ccVisa;
  } else if (type == "master") {
    return FontAwesomeIcons.ccMastercard;
  } else if (type == "american express") {
    return FontAwesomeIcons.ccAmex;
  } else {
    return FontAwesomeIcons.ccVisa;
  }
}
