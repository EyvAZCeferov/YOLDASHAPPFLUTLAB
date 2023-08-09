import 'package:get/get.dart';
import 'package:yoldash/Functions/CacheManager.dart';

class MainController extends GetxController {
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<String> currentlang = ''.obs;
  Rx<String> authtype = ''.obs;
  Rx<dynamic> auth_id = Rx<dynamic>(null);
  Rx<String> token = ''.obs;

  Future<dynamic> getstoragedat(String type) async {
    var data;
    if (type == "language") {
      data = currentlang.value;
      currentlang.value = data != null && data.length > 0
          ? data.trim()
          : await CacheManager.getvaluefromsharedprefences(type);
      data = currentlang.value;
    } else if (type == "authtype") {
      data = authtype.value;
      authtype.value = data != null && data.length > 0
          ? data.trim()
          : await CacheManager.getvaluefromsharedprefences(type);

      data = authtype.value;
    } else if (type == "token") {
      data = token.value;
      token.value = data != null && data.length > 0
          ? data.trim()
          : await CacheManager.getvaluefromsharedprefences(type);
      data = token.value;
    } else if (type == "auth_id") {
      data = auth_id.value;
      auth_id.value = data != null && data.length > 0
          ? data.trim()
          : await CacheManager.getvaluefromsharedprefences(type);
      data = auth_id.value;
    }
    return data;
  }
}
