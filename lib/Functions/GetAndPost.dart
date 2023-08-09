import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:yoldash/Controllers/MainController.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

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
          showToastMSG(errorcolor, "errordatanotfound".tr, context);
        }
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
      var apiUrl = Uri.parse('$baseapiurl/$url');
      var headers = {'Content-Type': 'application/json'};
      var jsonBody = jsonEncode(body);
      var token = await _maincontroller.getstoragedat('token');

      if (token != null && token.length > 0) {
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
}
