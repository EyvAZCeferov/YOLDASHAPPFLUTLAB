import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Functions/CacheManager.dart';
import 'package:yoldash/models/settings.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

const String appagid = "91e3453e50e543c6b520f7bfe0fa8b96";
const String appagcert1 = "3e389d68906643dea29aac81df9deb30";
const String appagcert2 = "5f93b97444044e53b97be9006828c102";
const String appcert1token =
    "007eJxTYGCJ8luUxbyzLDg4ym277AdVBa2W+qK4Ja8ehD+1kf5a9FGBwdIw1djE1DjV1CDV1MQ42SzJ1MggzTwpLdUgLdEiydJMz3BNSkMgI8NGASVWRgYIBPHZGSrzc1ISizMYGAAP2x6P";
const String baseapiurl = "https://sovqat369777.az/api";

void fetchData(String urlold) async {
  try {
    var url = Uri.parse('$baseapiurl/$urlold');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var status = jsonData['status'];
      var data = jsonData['data'];
      var model = jsonData['model'];

      if (status == 'success') {
        if (model == "settings") {
          var settings = Settings.fromJson(data);

          await CacheManager.cacheModel(model, settings);

          var cachedSettings =
              await CacheManager.getCachedModel<Settings>(model);
          if (cachedSettings != null) {
            print(cachedSettings.name?.azName);
            print(cachedSettings.id);
          }
        }
      } else if (status == 'error') {
        // error toaster
      }
    } else {
      // error toaster
    }
  } catch (e) {
    // error toaster
  }
}
