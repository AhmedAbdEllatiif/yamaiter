import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

void openUrl({required String url}) async {
  try {
    String fallbackUrl = url;

    try {
      Uri fbBundleUri = Uri.parse(fallbackUrl);
      var canLaunchNatively = await canLaunchUrl(fbBundleUri);

      if (canLaunchNatively) {
        launchUrl(fbBundleUri);
      } else {
        await launchUrl(Uri.parse(fallbackUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      log("openUrl >> onTap >> error: $e");
    }
  } on Exception catch (e) {
    log("openUrl >> onTap >> Exception >> error: $e");
  }
}
