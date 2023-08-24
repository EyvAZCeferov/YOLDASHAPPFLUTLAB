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
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('https://sovqat369777.az/api/successpayment')) {
              showToastMSG(primarycolor, "success_payment".tr, context);
              Navigator.pop(context);
              return NavigationDecision.prevent;
            } else if (request.url
                .startsWith('https://sovqat369777.az/api/errorpayment')) {
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
              return Navigator.pop(context);
            } else if (change.url ==
                'https://sovqat369777.az/api/errorpayment') {
              showToastMSG(primarycolor, "error_payment".tr, context);
              return Navigator.pop(context);
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
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
      backgroundColor: Colors.green,
      appBar: BaseAppBar(
        backbutton: true,
        bgcolorheader: whitecolor,
        title: widget.title,
        titlebg: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
