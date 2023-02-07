import 'dart:developer';
import 'dart:ui';

import 'package:webview_flutter/webview_flutter.dart';

WebViewController initWebViewController({
  required String url,
  Function(String)? onPageStarted,
  Function(String)? onPageFinished,
  Function(int)? onProgress,
  Function(WebResourceError)? onError,
}) {
  try {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      //..addJavaScriptChannel(name, onMessageReceived: onMessageReceived)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: onProgress,
          onPageStarted: onPageStarted,
          onPageFinished: onPageFinished,
          onWebResourceError: onError,
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(url),
      );
  } catch (e) {
    log("initWebViewController >> Error: $e");
    throw Exception("initWebViewController >> Error: $e");
  }
}
