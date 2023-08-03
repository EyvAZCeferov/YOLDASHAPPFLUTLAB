import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoldash/models/settings.dart';
import 'package:yoldash/models/users.dart';

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

  static T? _fromJson<T>(dynamic jsonData) {
    if (T == Settings) {
      return Settings.fromMap(jsonData) as T?;
    } else if (T == Users) {
      return Users.fromMap(jsonData) as T?;
    }
    return null;
  }

  static Future<dynamic> getvaluefromsharedprefences(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic data = prefs.getString(key) ?? ("");
      print('getvaluefromsharedprefences - Key: $key, Value: $data');
      if (data is int) {
        return await prefs.getInt(key);
      } else if (data is String) {
        return await prefs.getString(key);
      } else if (data is bool) {
        return await prefs.getBool(key);
      } else if (data is double) {
        return await prefs.getDouble(key);
      } else {
        throw ArgumentError('Unsupported data type');
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }

  static Future<dynamic> setvaluetoprefences(String key, dynamic value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value is int) {
        return await prefs.setInt(key, value);
      } else if (value is String) {
        return await prefs.setString(key, value);
      } else if (value is bool) {
        return await prefs.setBool(key, value);
      } else if (value is double) {
        return await prefs.setDouble(key, value);
      } else {
        throw ArgumentError('Unsupported data type');
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }
}
