import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldashapp/Controllers/CallingController.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoAndVoiceCall extends StatelessWidget {
final CallingController callingcontroller = Get.put(CallingController());

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 978230645,
        appSign:
            'f0f1338574fbcd3846c49c5f766772e41042b518ba9eaa6b4c366efa6abd0947',
        userID: callingcontroller.sender_id.value.toString(),
        userName: callingcontroller.sender_name.value??' ',
        callID: callingcontroller.callid.value.toString()??'1',   
        onDispose: () => callingcontroller.hangup(context),
        config: callingcontroller.typecalling.value=="video"?ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall():ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
