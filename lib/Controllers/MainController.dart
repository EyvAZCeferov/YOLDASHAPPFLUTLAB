import 'package:get/get.dart';
import 'package:yoldash/Functions/CacheManager.dart';

class MainController extends GetxController {
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<String> currentlang = 'az'.obs;
  Rx<String> authtype = 'rider'.obs;
  dynamic getstoragedat(type) async {
    var data = await CacheManager.getvaluefromsharedprefences(type);
    if (type == "language") {
      currentlang.value = data;
    } else if (type == "authtype") {
      authtype.value = data;
    }
    return data;
  }
}
