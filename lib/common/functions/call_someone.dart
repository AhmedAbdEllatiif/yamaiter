import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

void callSomeone({required String phoneNunm}) async {
  try{
    //_navigateToSingleSosScreen();
    await launchUrl(Uri(
      scheme: 'tel',
      path: phoneNunm,
      // queryParameters: <String, String>{
      //   'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
      // },
    ));
  }catch(e){
    log("callSomeone >> can't make a call >> error: $e");
  }

}
