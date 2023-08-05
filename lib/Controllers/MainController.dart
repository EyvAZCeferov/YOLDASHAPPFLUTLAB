import 'package:get/get.dart';
import 'package:yoldash/Functions/CacheManager.dart';

class MainController extends GetxController {
  Future<dynamic> getstoragedat(type) async {
    var data = await CacheManager.getvaluefromsharedprefences(type);
    return data;
  }
}
