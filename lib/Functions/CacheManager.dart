import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoldash/models/settings.dart';

class CacheManager {
  static Future<bool> cacheModel(String key, dynamic model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = model.toJson();
      return await prefs.setString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  static Future<T?> getCachedModel<T>(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(key);
      if (jsonString != null) {
        var jsonData = jsonDecode(jsonString);
        return _fromJson<T>(jsonData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static T _fromJson<T>(dynamic jsonData) {
    if (T == Settings) {
      return Settings.fromMap(jsonData) as T;
    }
    throw ArgumentError('Unknown type');
  }
}

Future<String?> getvaluefromsharedprefences(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? data = prefs.getString(key);
  return data;
}

Future<bool> setvaluetoprefences(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(key, value);
}
