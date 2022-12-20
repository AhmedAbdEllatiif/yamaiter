import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String widthAndHeight = "width='100%' height='100%'";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
          child: WebView(
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
        javascriptMode: JavascriptMode.unrestricted,
      )),
    );
  }
}
