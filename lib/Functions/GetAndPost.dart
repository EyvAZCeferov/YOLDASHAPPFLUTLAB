import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../Controllers/MainController.dart';
import '../Theme/ThemeService.dart';
import 'helpers.dart';

const String baseapiurl = "https://sovqat369777.az/api";
final MainController _maincontroller = Get.put(MainController());

class GetAndPost {
  static String? token;
  static Future<dynamic> fetchData(
      String urlold, context, Map<String, dynamic> data) async {
    try {
      checkconnectionandsendresult(null);
      String params = '';
      if (data != null && data.isNotEmpty) {
        data.forEach((key, value) {
          params += '$key=${Uri.encodeQueryComponent(value.toString())}&';
        });
      }
      var url;
      if (params.length > 2) {
        url = Uri.parse('$baseapiurl/$urlold?$params');
      } else {
        url = Uri.parse('$baseapiurl/$urlold');
      }
      var headers = {'Content-Type': 'application/json'};

      if (token == null || token == '' || token == ' ' || token!.isEmpty) {
        token = await _maincontroller.getstoragedat('token') ?? '';
        headers['Authorization'] = 'Bearer $token';
      } else {
        headers['Authorization'] = 'Bearer $token';
      }

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var status = jsonData['status'];

        if (status == 'success') {
          return jsonData;
        } else if (status == 'error') {
          if (context != null) {
            // showToastMSG(errorcolor, "errordatanotfound".tr, context);
          }
        }
      } else {
        if (context != null) {
          // showToastMSG(errorcolor, "errordatanotfound".tr, context);
        }
      }
    } catch (e) {
      if (context != null) {}
    }
  }

  static Future<dynamic> fetcOtherhData(
      String urlold, context, Map<String, dynamic> data) async {
    try {
      checkconnectionandsendresult(null);
      String params = '';
      if (data != null && data.isNotEmpty) {
        data.forEach((key, value) {
          params += '$key=${Uri.encodeQueryComponent(value.toString())}&';
        });
      }
      var url;
      if (params.length > 2) {
        url = Uri.parse('$urlold?$params');
      } else {
        url = Uri.parse('$urlold');
      }

      var headers = {'Content-Type': 'application/json'};
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        if (context != null) {
          // showToastMSG(errorcolor, "errordatanotfound".tr, context);
        }
      }
    } catch (e) {
      if (context != null) {}
    }
  }

  static Future<dynamic> postData(
    String url,
    dynamic body,
    context,
  ) async {
    try {
      checkconnectionandsendresult(null);
      var apiUrl = Uri();
      if (url != "https://yoldash.app/contact") {
        apiUrl = Uri.parse('$baseapiurl/$url');
      } else {
        apiUrl = Uri.parse(url);
      }
      var headers = {'Content-Type': 'application/json'};
      var jsonBody = jsonEncode(body);

      if (token == null || token == '' || token == ' ' || token!.isEmpty) {
        token = await _maincontroller.getstoragedat('token') ?? '';
        headers['Authorization'] = 'Bearer $token';
      } else {
        headers['Authorization'] = 'Bearer $token';
      }

      var response = await http.post(apiUrl, headers: headers, body: jsonBody);
      var jsonData = jsonDecode(response.body);
      var status = jsonData['status'];

      if (status == 'success') {
        return jsonData;
      } else if (status == 'error') {
        if (context != null) {
          showToastMSG(errorcolor, jsonData['message'], context);
        }
      }
    } catch (e) {
      if (context != null) {}
    }
  }

  static Future<dynamic> patchData(
    String url,
    dynamic body,
    context,
  ) async {
    try {
      checkconnectionandsendresult(null);
      var apiUrl = Uri.parse('$baseapiurl/$url');
      var headers = {'Content-Type': 'application/json'};
      var jsonBody = jsonEncode(body);

      if (token == null || token == '' || token == ' ' || token!.isEmpty) {
        token = await _maincontroller.getstoragedat('token') ?? '';
        headers['Authorization'] = 'Bearer $token';
      } else {
        headers['Authorization'] = 'Bearer $token';
      }
      var response = await http.patch(apiUrl, headers: headers, body: jsonBody);
      var jsonData = jsonDecode(response.body);
      var status = jsonData['status'];

      if (status == 'success') {
        return jsonData;
      } else if (status == 'error') {
        showToastMSG(errorcolor, jsonData['message'], context);
      }
    } catch (e) {}
  }

  static Future<dynamic> uploadfile(
    String url,
    File file,
    context,
  ) async {
    try {
      checkconnectionandsendresult(null);
      var apiUrl = Uri.parse('$baseapiurl/$url');
      var headers = {'Content-Type': 'multipart/form-data'};

      if (token == null || token == '' || token == ' ' || token!.isEmpty) {
        token = await _maincontroller.getstoragedat('token') ?? '';
        headers['Authorization'] = 'Bearer $token';
      } else {
        headers['Authorization'] = 'Bearer $token';
      }
      var request = await http.MultipartRequest('POST', apiUrl);
      request.headers.addAll(headers);
      var multipartFile = await http.MultipartFile.fromPath('image', file.path);
      request.files.add(multipartFile);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonData = jsonDecode(responseString);
      return jsonData;
    } catch (e) {}
  }
}
