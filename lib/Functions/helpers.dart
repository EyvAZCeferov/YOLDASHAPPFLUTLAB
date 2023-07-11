import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Theme/ThemeService.dart';

void showToastMSG(bgcolor, text, context) {
  print(text);
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

Future<void> getandsetkey(String key, newval) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (newval == null) {
    final String? val = prefs.getString(key);
  } else {
    await prefs.setInt(key, newval);
  }
}

const String appagid = "91e3453e50e543c6b520f7bfe0fa8b96";
const String appagcert1 = "3e389d68906643dea29aac81df9deb30";
const String appagcert2 = "5f93b97444044e53b97be9006828c102";
const String appcert1token =
    "007eJxTYGCJ8luUxbyzLDg4ym277AdVBa2W+qK4Ja8ehD+1kf5a9FGBwdIw1djE1DjV1CDV1MQ42SzJ1MggzTwpLdUgLdEiydJMz3BNSkMgI8NGASVWRgYIBPHZGSrzc1ISizMYGAAP2x6P";
