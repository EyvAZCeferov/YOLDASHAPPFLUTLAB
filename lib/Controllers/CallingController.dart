import 'package:get/get.dart';

import '../Functions/GetAndPost.dart';

class CallingController extends GetxController {
  Rx<String> typecalling = Rx<String>("video");
  RxBool muted = false.obs;
  Rx<bool> refreshpage = Rx<bool>(false);
  Rx<int> callid = Rx<int>(1);
  Rx<dynamic> sender_id = Rx<dynamic>(0);
  Rx<dynamic> receiver_id = Rx<dynamic>(0);
  Rx<String?> sender_name = Rx<String?>(null);
  Rx<String?> receiver_name = Rx<String?>(null);

  void callcreate(context) async {
    try {
      refreshpage.value = true;
      Map<String, dynamic> body = {
        'sender_id': sender_id.value,
        'receiver_id': receiver_id.value,
        'typecalling': typecalling.value,
      };
      var response = await GetAndPost.postData("createcalling", body, context);
      refreshpage.value = false;
      if (response['status'] == "success") {
        callid.value = response['call_id'];
      }
    } catch (e) {
      refreshpage.value = false;
      print("Call Page Error: $e");
    }
  }

  void hangup(context) {}
}
