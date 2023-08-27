import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl({
  required String url,
  LaunchMode launchMode = LaunchMode.platformDefault,
}) async {
  try {
    String fallbackUrl = url;

    try {
      Uri fbBundleUri = Uri.parse(fallbackUrl);
      var canLaunchNatively = await canLaunchUrl(fbBundleUri);

      if (canLaunchNatively) {
        return await launchUrl(
          fbBundleUri,
          mode: launchMode,
        );
      } else {
        return await launchUrl(
          Uri.parse(fallbackUrl),
        );
      }
    } catch (e) {
      log("openUrl >> onTap >> error: $e");
      return false;
    }
  } on Exception catch (e) {
    log("openUrl >> onTap >> Exception >> error: $e");
    return false;
  }
}
