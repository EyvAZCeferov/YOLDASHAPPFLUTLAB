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
  static Future<dynamic> fetchData(
      String urlold, context, Map<String, dynamic> data) async {
    try {
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
      var token = await _maincontroller.getstoragedat('token');
      if (token != null && token.length > 0) {
        headers['Authorization'] = 'Bearer $token';
      }

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var status = jsonData['status'];

        if (status == 'success') {
          return jsonData;
        } else if (status == 'error') {
          if(context!=null){
            showToastMSG(errorcolor, "errordatanotfound".tr, context);
          }
        }
      } else {
        if(context!=null){
          showToastMSG(errorcolor, "errordatanotfound".tr, context);
        }
      }
    } catch (e) {
      print(e.toString());
      if(context!=null){
        showToastMSG(errorcolor, e.toString(), context);
      }
    }
  }

  static Future<dynamic> fetcOtherhData(
      String urlold, context, Map<String, dynamic> data) async {
    try {
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
     print("-----------------------------------BAREAR TOKEN--------------------------");


      var headers = {'Content-Type': 'application/json'};
      var token = await _maincontroller.getstoragedat('token');
      print(token);
      if (token != null && token.length > 0) {
        headers['Authorization'] = 'Bearer $token';
      }
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        showToastMSG(errorcolor, "errordatanotfound".tr, context);
      }
    } catch (e) {
      print(e.toString());
      showToastMSG(errorcolor, e.toString(), context);
    }
  }

  static Future<dynamic> postData(
    String url,
    dynamic body,
    context,
  ) async {
    try {
      var apiUrl = Uri();
      if (url != "https://yoldash.app/contact") {
        apiUrl = Uri.parse('$baseapiurl/$url');
      } else {
        apiUrl = Uri.parse(url);
      }
      var headers = {'Content-Type': 'application/json'};
      var jsonBody = jsonEncode(body);

      var token = await _maincontroller.getstoragedat('token');

      if (token != null && token != '' && token != ' ' && token.length > 0) {
        headers['Authorization'] = 'Bearer $token';
      }

      var response = await http.post(apiUrl, headers: headers, body: jsonBody);
      var jsonData = jsonDecode(response.body);
      var status = jsonData['status'];

      if (status == 'success') {
        return jsonData;
      } else if (status == 'error') {
        showToastMSG(errorcolor, jsonData['message'], context);
      }
    } catch (e) {
      showToastMSG(errorcolor, e.toString(), context);
      print(e.toString());
    }
  }

  static Future<dynamic> patchData(
    String url,
    dynamic body,
    context,
  ) async {
    try {
      var apiUrl = Uri.parse('$baseapiurl/$url');
      var headers = {'Content-Type': 'application/json'};
      var jsonBody = jsonEncode(body);
      var token = await _maincontroller.getstoragedat('token');
      if (token != null && token.length > 0) {
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
    } catch (e) {
      showToastMSG(errorcolor, e.toString(), context);
    }
  }

  static Future<dynamic> uploadfile(
    String url,
    File file,
    context,
  ) async {
    try {
      var apiUrl = Uri.parse('$baseapiurl/$url');
      var headers = {'Content-Type': 'multipart/form-data'};
      var token = await _maincontroller.getstoragedat('token');

      if (token != null && token.length > 0) {
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
    } catch (e) {
      print(e.toString());
      showToastMSG(errorcolor, e.toString(), context);
    }
  }
}
