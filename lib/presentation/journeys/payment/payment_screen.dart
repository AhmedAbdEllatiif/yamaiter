import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yamaiter/domain/entities/screen_arguments/payment_args.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

class PaymentScreen extends StatefulWidget {
  final PaymentArguments paymentArguments;

  const PaymentScreen({Key? key, required this.paymentArguments})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String widthAndHeight = "width='100%' height='100%'";

  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      //..addJavaScriptChannel(name, onMessageReceived: onMessageReceived)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    try{
      controller.loadRequest(Uri.dataFromString(
          '<html><body><iframe src="${widget.paymentArguments.link}" " height=\'100%\' width=\'100%\' "></iframe></body></html>',
          mimeType: 'text/html'));
    }catch (e){
      print("Error: $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "CheckPaymentStatus");
          },
          icon: Icon(
            Icons.close,
            color: AppColor.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: Icon(
                Icons.refresh,
                color: AppColor.white,
              ))
        ],
      ),
      body: Container(
          width: double.infinity,
          child: WebViewWidget(
            controller: controller,
            /*   onPageFinished: (value){

              print("onPageFinished >>> $value");
            },
            onProgress: (value){

              print("onProgress >>> $value");
            },
            onPageStarted: (value){
              print("Statred >>> $value");
            },
            onWebResourceError: (error){
              print("onWebResourceError >>> ${error.description}");
            },
            gestureNavigationEnabled: true,
           gestureRecognizers: ,
            initialUrl: Uri.dataFromString(
                    '<html><body><iframe src="https://accept.paymob.com/api/'
                    'acceptance/iframes/710541?'
                    'payment_token=ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNa'
                    'Uo5LmV5SmhiVzkxYm5SZlkyVnVkSE1pT2pZd01EQXdMQ0p2Y21SbGNsOXBaQ'
                    '0k2T0RjME1ESXpNREFzSW1sdWRHVm5jbUYwYVc5dVgybGtJam96TVRnMk5qQ'
                    'TJMQ0p6YVc1bmJHVmZjR0Y1YldWdWRGOWhkSFJsYlhCMElqcG1ZV3h6WlN3aV'
                    'pYaDBjbUVpT250OUxDSmxlSEFpT2pFMk56RXlNRFkzTkRrc0lteHZZMnRmYjNK'
                    'a1pYSmZkMmhsYmw5d1lXbGtJanBtWVd4elpTd2lZM1Z5Y21WdVkza2lPaUpGUj'
                    'FBaUxDSmlhV3hzYVc1blgyUmhkR0VpT25zaVptbHljM1JmYm1GdFpTSTZJa3h'
                    'oZDNsbGNpSXNJbXhoYzNSZmJtRnRaU0k2SWt4aGQzbGxjaUlzSW5OMGNtV'
                    'mxkQ0k2SWs1Qklpd2lZblZwYkdScGJtY2lPaUpPUVNJc0ltWnNiMjl5SWpv'
                    'aVRrRWlMQ0poY0dGeWRHMWxiblFpT2lKT1FTSXNJbU5wZEhraU9pSkJiR1Y0S'
                    'Wl3aWMzUmhkR1VpT2lKRlozbHdkQ0lzSW1OdmRXNTBjbmtpT2lKRlozbHdkQ0lz'
                    'SW1WdFlXbHNJam9pYkdGM2VXVnlRR1Z0WVdsc0xtTnZiU0lzSW5Cb2IyNWxYMjU'
                    'xYldKbGNpSTZJakF4TVRjeU16VTBPRFV4SWl3aWNHOXpkR0ZzWDJOdlpHVWlPaUpPUV'
                    'NJc0ltVjRkSEpoWDJSbGMyTnlhWEIwYVc5dUlqb2lUa0VpZlN3aWRYTmxjbDlwWkN'
                    'JNk1UQXdPVE13Tml3aWNHMXJYMmx3SWpvaU1UQXlMalF4TGpFMk5DNHhNamNpZlE'
                    'uYmpzRDBBMGJEeGZ0a3RWMm5tUm9JZGdrWXhqUEhoZXAyRXI0WEpaYm9GTkF1d'
                    'FNQV2FyOERDS0pLc1JObmJuY3NnSGhDbDJwZUsxQjV0NVljWmFBeHc=" " height=\'100%\' width=\'100%\' "></iframe></body></html>',
                    mimeType: 'text/html')
                .toString(),
            javascriptMode: JavascriptMode.unrestricted,*/
          )),
    );
  }
}
