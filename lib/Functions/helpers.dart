import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoldashapp/Controllers/MessagesController.dart';
import 'package:yoldashapp/Functions/GetAndPost.dart';
import 'package:yoldashapp/Functions/PusherClient.dart';

import '../Constants/StaticText.dart';
import '../Theme/ThemeService.dart';
import '../models/message_groups.dart';

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
const String mapsApiKey = "AIzaSyCIiz_JtpZCDCgBUQeh_lgVILNEH88zUY4";

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

String differenceintwotimes(DateTime starttime, DateTime endtime) {
  Duration difference = endtime.difference(starttime);
  if (difference.inDays < 30) {
    return "inDays".trParams({'timevar': difference.inDays.toString()});
  } else if (difference.inDays >= 30) {
    return "inMonths".trParams({'timevar': "1"});
  } else {
    return DateFormat('dd.MM.yyyy HH:mm').format(starttime);
  }
}

Future<PermissionStatus> handlepermissionreq(
    Permission permission, context) async {
  try {
    final status = await permission.request();
    return status;
  } catch (e) {
    if (context != null) {
      showToastMSG(errorcolor, "permissiondenied".tr, context);
    }
    return PermissionStatus.denied;
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
  } else if (type == "nagd") {
    return FontAwesomeIcons.moneyBill;
  } else {
    return FontAwesomeIcons.ccVisa;
  }
}

String getimageurl(String type, String clasore, String? path) {
  try {
    if (type == "user") {
      if (path != null && path != '' && path != ' ' && path.length > 0) {
        return imageurl + clasore + '/' + path;
      } else {
        return imageurl + clasore + '/' + 'noprofilepicture.webp';
      }
    } else {
      return imageurl + clasore + '/' + path!;
    }
  } catch (e) {
    return e.toString();
  }
}

int countMessageUnread(List<Messages>? messages, int authId) {
  if (messages != null && messages.isNotEmpty) {
    int unreadCount = 0;

    for (var message in messages) {
      if (message.userId != authId && message.status == false) {
        unreadCount++;
      }
    }

    return unreadCount;
  } else {
    return 0;
  }
}

Color fromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

String converttimedayandmonth(DateTime dateTime) {
  String day = dateTime.day.toString();
  String month = DateFormat.MMM().format(dateTime);
  return '$day $month';
}

String convertStringToTime(timestamp) {
  if (timestamp != null && timestamp != '' && timestamp != ' ') {
    DateTime dateTime = DateTime.parse(timestamp);
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    return "${day}.${month}.${year}";
  } else {
    return "";
  }
}

String convertfromintToTime(timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  int year = dateTime.year;
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  return "${day}.${month}.${year} ${hour}:${minute}";
}

String convertToSlug(String text) {
  text = text.toLowerCase();
  text = text.replaceAll(RegExp(r'[^a-z0-9\s-]'), '');
  text = text.replaceAll(RegExp(r'\s+'), '-');
  text = text.replaceAll(RegExp(r'-+'), '-');
  return text;
}

void FirebaseMessageCall(BuildContext context) {
  try {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    firebaseMessaging.getToken().then((value) async {
      Map<String, dynamic> body = {
        'token': value,
      };
      var response = await GetAndPost.postData("auth/set_token", body, context);
    });
  } catch (e) {
    e.toString();
  }
}

final MessagesController messageController = Get.put(MessagesController());
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message);
  if (messagecontroller.selectedMessageGroup.value != null &&
      messagecontroller.selectedMessageGroup.value?.id != null) {
        print("i get up message ${messagecontroller.selectedMessageGroup.value?.id}");
    messagecontroller.getMessages(
        null, messagecontroller.selectedMessageGroup.value!.id);
  }

  messageController.getMessages(null, null);

}
