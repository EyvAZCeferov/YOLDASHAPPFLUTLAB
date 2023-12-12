import 'package:get/get.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:yoldashapp/Controllers/MessagesController.dart';

import '../Controllers/HistoryController.dart';

MessagesController messagecontroller = Get.put(MessagesController());
HistoryController historycontroller = Get.put(HistoryController());
// PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

class LaravelEcho {
  static LaravelEcho? _singleton;
  final String token;
  final String channel;

  LaravelEcho._({required this.token, required this.channel}) {
    createPusherClient(token, channel);
  }

  factory LaravelEcho.init({required String token, required String channel}) {
    if (_singleton == null || token != _singleton?.token) {
      _singleton = LaravelEcho._(token: token, channel: channel);
    }

    return _singleton!;
  }

  void createPusherClient(String token, String channel) async {
    try {
      print(
          "-------------------------------------------------PusherClient---------------------------------------");
      // await pusher.init(
      //   apiKey: PusherConfig.key,
      //   cluster: PusherConfig.cluster,
      //   authParams: {
      //     'headers': {
      //       'Authorization': "Bearer $token",
      //       "Content-Type": "application/json",
      //       "Accept": "application/json",
      //     }
      //   },
      //   authEndpoint: PusherConfig.hostAuthEndPoint,
      //   onConnectionStateChange: onConnectionStateChange,
      //   onError: onError,
      //   onSubscriptionSucceeded: onSubscriptionSucceeded,
      //   onEvent: onEvent,
      //   onSubscriptionError: onSubscriptionError,
      //   onDecryptionFailure: onDecryptionFailure,
      //   onMemberAdded: onMemberAdded,
      //   onMemberRemoved: onMemberRemoved,
      // );

      // await pusher.subscribe(channelName: channel);
      // await pusher.connect();
    } catch (e) {
      print(
          "-------------------Pusher Client ERROR -------------${e.toString()}");
      return null;
    }
  }

  void onEvent(event) {
    if(historycontroller.selectedRide?.value?.id!=null && historycontroller.selectedRide?.value?.id!='' && historycontroller.selectedRide?.value?.id!=' '){
      historycontroller.getRides(null, historycontroller.selectedRide?.value?.id, true);
    }
    if (event.channelName.contains('chat') &&
        event.eventName == 'new_message') {
          messagecontroller.getMessages(null, null);
      int chatId = int.parse(
          event.channelName.substring(event.channelName.indexOf('-') + 1));
      messagecontroller.getMessages(null, chatId);
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print(
        "------------------------------------onSubscriptionSucceeded:------------------------------- $channelName data: $data");
  }

  dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
    return {
      'headers': {
        'Authorization': "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      'Authorization': "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
      "channel_data": '{"Bearer": $token}',
      "shared_secret": PusherConfig.secret,
    };
  }

  void onSubscriptionError(String message, dynamic e) {
    print(
        "------------------------------onSubscriptionError:--------------------------------- $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    print(
        "------------------------------------onDecryptionFailure:-------------------------- $event reason: $reason");
  }

  // void onMemberAdded(String channelName, PusherMember member) {
  //   print(
  //       "-------------------------------onMemberAdded:----------------------- $channelName member: $member");
  // }

  // void onMemberRemoved(String channelName, PusherMember member) {
  //   print(
  //       "------------------------------onMemberRemoved:--------------------------- $channelName member: $member");
  // }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print(
        "--------------------------------Connection:--------------------------- $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    print(
        "-----------------------------------onError:------------------------------ $message code: $code exception: $e");
  }

  // void disconnect() async {
  //   await pusher.disconnect();
  // }

  // void pusherUnsubscribe(channelName) async {
  //   await pusher.unsubscribe(channelName: channelName);
  // }

  // Future<String> getSocketId() async {
  //   String socketId = await pusher.getSocketId();
  //   return socketId;
  // }
}

class PusherConfig {
  static const String appId = "1701569";
  static const String key = "b3749ed284858130b3e8";
  static const String secret = "2ce2af449910990e1968";
  static const String cluster = "ap1";
  static const String hostEndPoint = "https://sovqat369777.az/api";
  static const String hostAuthEndPoint = "$hostEndPoint/broadcasting/auth";
  static const int port = 6001;
}
