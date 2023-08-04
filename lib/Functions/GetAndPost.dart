import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:yoldash/Functions/CacheManager.dart';
import 'package:yoldash/Functions/ProviderContext.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

const String baseapiurl = "https://sovqat369777.az/api";

class GetAndPost {
  static Future<dynamic> fetchData(
      String urlold, context, Map<String, dynamic> data) async {
    try {
      String params = '';
      data.forEach((key, value) {
        params += '$key=${Uri.encodeQueryComponent(value.toString())}&';
      });

      var url = Uri.parse('$baseapiurl/$urlold?$params');

      var headers = {'Content-Type': 'application/json'};
      var token = await CacheManager.getvaluefromsharedprefences("token");
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
      showToastMSG(errorcolor, e.toString(), context);
    }
  }

  static Future<dynamic> postData(String url, dynamic body, context) async {
    try {
      var apiUrl = Uri.parse('$baseapiurl/$url');
      var headers = {'Content-Type': 'application/json'};
      var jsonBody = jsonEncode(body);
      var token = await CacheManager.getvaluefromsharedprefences("token");
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
}
