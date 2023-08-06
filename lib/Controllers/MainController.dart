import 'package:get/get.dart';
import 'package:yoldash/Functions/CacheManager.dart';

class MainController extends GetxController {
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<String> currentlang = 'az'.obs;
  Rx<String> authtype = 'rider'.obs;
  Rx<String> auth_id = ''.obs;

  Future<dynamic> getstoragedat(type) async {
    var data = await CacheManager.getvaluefromsharedprefences(type);
    if (type == "language") {
      currentlang.value = data ?? 'az';
    } else if (type == "authtype") {
      authtype.value = data ?? 'rider';
    } else if (type == "auth_id") {
      auth_id.value = data.toString();
    }
    return data;
  }
}
