import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Functions/helpers.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class WebviewFunctions extends StatefulWidget {
  final String paymentUrl;
  final String title;

  WebviewFunctions({required this.paymentUrl, required this.title});

  @override
  _WebviewFunctionsState createState() => _WebviewFunctionsState();
}

class _WebviewFunctionsState extends State<WebviewFunctions> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodycolor,
      appBar: AppBar(
        title: StaticText(
          color: darkcolor,
          size: normaltextSize,
          text: widget.title,
          weight: FontWeight.w600,
          align: TextAlign.center,
          textOverflow: TextOverflow.ellipsis,
        ),
      ),
      body: WebView(
        initialUrl: widget.paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _webViewController = controller;
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains('https://sovqat369777.az/successpayment')) {
            showToastMSG(primarycolor, "success_payment".tr, context);
            Navigator.pop(context);
            return NavigationDecision.prevent;
          } else if (request.url
              .contains('https://sovqat369777.az/errorpayment')) {
            showToastMSG(primarycolor, "error_payment".tr, context);
            Navigator.pop(context);
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
      ),
    );
  }
}
