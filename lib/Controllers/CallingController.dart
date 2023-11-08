import 'package:get/get.dart';


class CallingController extends GetxController {
  Rx<String> type = Rx<String>("video");
  RxBool muted = false.obs;
  RxList<int?> users = <int?>[].obs;
  RxList<String?> infoStrings = <String?>[].obs;


  
}
