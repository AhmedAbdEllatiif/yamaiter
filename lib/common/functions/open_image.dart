import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:yamaiter/presentation/widgets/cached_image_widget.dart';

import '../../presentation/themes/theme_color.dart';
import '../screen_utils/screen_util.dart';

///
/// To open image with library
/// https://pub.dev/packages/full_screen_image/
void openImage(
  BuildContext context, {
  required String image,
  EdgeInsets padding = EdgeInsets.zero,
  bool isCircle = true,
}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      opaque: false,
      barrierColor: AppColor.primaryDarkColor,
      pageBuilder: (BuildContext context, _, __) {
        return FullScreenPage(
          backgroundColor: AppColor.primaryDarkColor,
          backgroundIsTransparent: false,
          disposeLevel: DisposeLevel.Medium,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              ),
              child: Hero(
                tag: "smallImage",
                child: Padding(
                  padding: padding,
                  child: isCircle? CachedImageWidget(
                    imageUrl: image,
                    boxFit: BoxFit.cover,
                    isCircle: isCircle,
                    height: ScreenUtil.screenWidth * 0.7,
                    width: ScreenUtil.screenWidth * 0.7,
                    progressBarScale: 0.5,
                  ): CachedNetworkImage(
                    imageUrl: image,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
