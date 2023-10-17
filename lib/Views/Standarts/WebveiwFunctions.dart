import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:yoldashapp/Constants/BaseAppBar.dart';
import 'package:yoldashapp/Controllers/BalanceController.dart';
import 'package:yoldashapp/Controllers/CardsController.dart';

import '../../Functions/helpers.dart';
import '../../Theme/ThemeService.dart';

class WebviewFunctions extends StatefulWidget {
  final String paymentUrl;
  final String title;

  const WebviewFunctions({required this.paymentUrl, required this.title});

  @override
  State<WebviewFunctions> createState() => _WebviewFunctionsState();
}

class _WebviewFunctionsState extends State<WebviewFunctions> {
  late final WebViewController _controller;
  final CardsController cardscontroller = Get.put(CardsController());
  final BalanceController balanceController = Get.put(BalanceController());

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            showToastMSG(primarycolor, "errordatanotfound".tr, context);
            cardscontroller.fetchDatas(context);
            balanceController.fetchData(context);
            Navigator.pop(context);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('https://sovqat369777.az/api/successpayment')) {
              showToastMSG(primarycolor, "success_payment".tr, context);
              cardscontroller.fetchDatas(context);
              balanceController.fetchData(context);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            } else if (request.url
                .startsWith('https://sovqat369777.az/api/errorpayment')) {
              cardscontroller.fetchDatas(context);
              balanceController.fetchData(context);
              showToastMSG(primarycolor, "error_payment".tr, context);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
          onUrlChange: (UrlChange change) {
            if (change.url == 'https://sovqat369777.az/api/successpayment') {
              showToastMSG(primarycolor, "success_payment".tr, context);
              cardscontroller.fetchDatas(context);
              balanceController.fetchData(context);
              return Navigator.pop(context);
            } else if (change.url ==
                'https://sovqat369777.az/api/errorpayment') {
              showToastMSG(primarycolor, "error_payment".tr, context);
              cardscontroller.fetchDatas(context);
              balanceController.fetchData(context);
              return Navigator.pop(context);
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          showToastMSG(bodycolor, message, context);
        },
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: BaseAppBar(
        backbutton: true,
        bgcolorheader: whitecolor,
        title: widget.title,
        titlebg: true,
        backFunction: () => cardscontroller.fetchDatas(context),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
