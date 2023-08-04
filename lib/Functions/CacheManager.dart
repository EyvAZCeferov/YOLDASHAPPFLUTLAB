import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:yoldash/models/settings.dart';
import 'package:yoldash/models/users.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheManager {
  static final _boxName = 'cache';

  static Future<void> createSharedPref() async {
    try {
      await Hive.initFlutter();
    } catch (e) {
      print('Error initializing Hive: $e');
    }
  }

  static Future<Box> _getBox() async {
    return await Hive.openBox(_boxName);
  }

  static Future<void> cacheModel(String key, dynamic model) async {
    try {
      var box = await _getBox();
      String jsonString = jsonEncode(model.toJson());
      await box.put(key, jsonString);
    } catch (e) {
      print("Error Caching Model");
      print(e.toString());
    }
  }

  static Future<T?> getCachedModel<T>(String key) async {
    try {
      var box = await _getBox();
      String? jsonString = box.get(key);
      if (jsonString != null) {
        var jsonData = jsonDecode(jsonString);
        return _fromJson<T>(jsonData);
      }
      return null;
    } catch (e) {
      print("Error getting Caching Model");
      print(e.toString());
    }
  }

  static T? _fromJson<T>(dynamic jsonData) {
    if (jsonData is Map<String, dynamic>) {
      if (T == Settings) {
        return Settings.fromMap(jsonData) as T?;
      } else if (T == Users) {
        return Users.fromMap(jsonData) as T?;
      }
    }
    return null;
  }

  static dynamic getvaluefromsharedprefences(String key) async {
    try {
      var box = await _getBox();
      dynamic data = box.get(key) ?? ("");
      return data;
    } catch (e) {
      print("Error Getting Value");
      print(e.toString());
    }
  }

  static Future<void> setvaluetoprefences(String key, dynamic value) async {
    try {
      var box = await _getBox();
      await box.put(key, value);
    } catch (e) {
      print("Error Setting Value");
      print(e.toString());
    }
  }

  static Future<bool> containsKeyOnPref(String key) async {
    try {
      var box = await _getBox();
      return box.containsKey(key);
    } catch (e) {
      print('Error Contains Value');
      print(e.toString());
      return false;
    }
  }
}
