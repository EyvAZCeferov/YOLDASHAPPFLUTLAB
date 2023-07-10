import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showToastMSG(bgcolor, text) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: bgcolor,
    textColor: Colors.white,
    fontSize: 16.0,
    webBgColor: bgcolor,
    webShowClose: true,
  );
}

const String appagid = "91e3453e50e543c6b520f7bfe0fa8b96";
const String appagcert1 = "3e389d68906643dea29aac81df9deb30";
const String appagcert2 = "5f93b97444044e53b97be9006828c102";
const String appcert1token =
    "007eJxTYGCJ8luUxbyzLDg4ym277AdVBa2W+qK4Ja8ehD+1kf5a9FGBwdIw1djE1DjV1CDV1MQ42SzJ1MggzTwpLdUgLdEiydJMz3BNSkMgI8NGASVWRgYIBPHZGSrzc1ISizMYGAAP2x6P";
