import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/settings.dart';
import '../models/users.dart';

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

  static Future<dynamic?> getvaluefromsharedprefences(String key) async {
    try {
      var box = await _getBox();
      return box.get(key);
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic?> removevaluefromprefences(String key) async {
    try {
      var box = await _getBox();
      return box.delete(key);
    } catch (e) {
      print("Error Deleting Value: $e");
      return null;
    }
  }

  static Future<void> setvaluetoprefences(String key, dynamic value) async {
    try {
      var box = await _getBox();

      if (box.containsKey(key)) {
        await box.delete(key);
      }

      await box.put(key, value);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> containsKeyOnPref(String key) async {
    try {
      var box = await _getBox();
      return box.containsKey(key);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
