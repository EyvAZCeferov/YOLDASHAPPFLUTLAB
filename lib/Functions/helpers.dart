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
