import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';

import '../themes/theme_color.dart';
import 'custom_circular_progress_bar.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double progressBarScale;
  final bool isCircle;
  final BoxFit boxFit;
  final bool withBorderRadius;
  final Widget? errorWidget;

  const CachedImageWidget({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.progressBarScale,
    required this.isCircle,
    this.errorWidget,
    this.withBorderRadius = false,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  log("ImgUrl >>>>>>>>>> $imageUrl");
    return imageUrl == AppUtils.undefined
        ? const Icon(
            Icons.error,
            color: AppColor.accentColor,
          )
        : CachedNetworkImage(
            /// imageUrl
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: BoxFit.contain,

            /// imageBuilder
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                //borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
                borderRadius: withBorderRadius
                    ? BorderRadius.circular(AppUtils.cornerRadius)
                    : null,
                image: DecorationImage(
                  image: imageProvider,
                  fit: boxFit,
                  // colorFilter: ColorFilter.mode(
                  //   Colors.red,
                  //   BlendMode.colorBurn,
                  // ),
                ),
              ),
            ),

            /// progressBar
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CustomCircularProgressBar(
              scale: progressBarScale,
              progress: downloadProgress.progress,
            ),

            /// error widget
            errorWidget: (context, url, error) =>
                errorWidget ??
                const Icon(
                  Icons.error,
                  color: AppColor.accentColor,
                ),
          );
  }
}
