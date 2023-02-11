import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/web_view_controller/web_view_controller.dart';
import 'loading_widget.dart';

class CustomWebViewWidget extends StatefulWidget {
  final String url;

  const CustomWebViewWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<CustomWebViewWidget> createState() => _CustomWebViewWidgetState();
}

class _CustomWebViewWidgetState extends State<CustomWebViewWidget> {
  /// WebViewController
  late WebViewController controller;

  /// loading status
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebController(url: widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return _showLoading
        ? const Center(child: LoadingWidget())
        : SizedBox(
            width: double.infinity,
            child: WebViewWidget(
              controller: controller,
            ));
  }

  /// to toggle showing loading
  void _toggleLoading(bool showLoading) {
    if (mounted) {
      setState(() {
        _showLoading = showLoading;
      });
    }
  }

  void _initWebController({required String url}) {
    controller = initWebViewController(
      url: url,
      // url: "https://yamaitre.com/about-us",
      onPageStarted: (_)  {
        log("onPageStarted");
        //_toggleLoading(true);
        },
      onPageFinished: (_) {
        log("onPageStarted");
        _toggleLoading(false);
      },
      onError: (_) => _toggleLoading(false),
    );
  }
}
