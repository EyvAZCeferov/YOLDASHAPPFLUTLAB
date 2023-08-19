import 'package:get/get.dart';

class CallingController extends GetxController {
  Rx<String> type = Rx<String>("calling");
  RxBool muted = false.obs;
}
