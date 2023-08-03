import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:yoldash/Functions/CacheManager.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';
import 'package:yoldash/models/settings.dart';

const String baseapiurl = "https://sovqat369777.az/api";

class GetAndPost {
  static Future<void> fetchData(String urlold, context) async {
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
            var cachedSettings =
                await CacheManager.getCachedModel<Settings>(model);
            if (cachedSettings == null) {
              var settings = Settings.fromMap(data);
              await CacheManager.cacheModel(model, settings);

              cachedSettings =
                  await CacheManager.getCachedModel<Settings>(model);
            }
          }
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

      var bearerToken =
          await CacheManager.getvaluefromsharedprefences('bearertoken');
      if (bearerToken != null && bearerToken.length > 0) {
        headers['Authorization'] = 'Bearer $bearerToken';
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
