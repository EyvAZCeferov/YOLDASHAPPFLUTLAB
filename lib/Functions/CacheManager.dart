
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
        return jsonData != null ? _getModelFromJson<T>(jsonData) : null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static T _getModelFromJson<T>(Map<String, dynamic> json) {
    if (T == Settings) {
      return Settings.fromMap(json) as T;
    }
    // Add other model mappings here
    throw Exception("Invalid model type");
  }
}
