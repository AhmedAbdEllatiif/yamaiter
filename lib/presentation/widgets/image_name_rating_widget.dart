import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/assets_constants.dart';
import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'cached_image_widget.dart';

class ImageNameRatingWidget extends StatelessWidget {
  final String imgUrl;
  final String name;
  final double rating;
  final double? nameSize;
  final Function()? onPressed;
  final double minImageSize;
  final double maxImageSize;
  final Color nameColor;
  final Color unRatedColor;
  final Color ratedColor;
  final bool withRow;
  final double iconRateSize;
  final bool isAdmin;
  final bool showRating;

  const ImageNameRatingWidget({
    Key? key,
    required this.imgUrl,
    required this.name,
    required this.rating,
    this.onPressed,
    this.nameSize,
    this.withRow = true,
    this.minImageSize = Sizes.dimen_30,
    this.maxImageSize = Sizes.dimen_30,
    this.iconRateSize = Sizes.dimen_16,
    this.nameColor = AppColor.white,
    this.unRatedColor = AppColor.white,
    this.ratedColor = AppColor.accentColor,
    this.isAdmin = false,
    this.showRating = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withRow ? _withRow(context) : _withColumn(context);
  }

  Widget _withColumn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// admin image
          if (isAdmin)
            CircleAvatar(
              minRadius: minImageSize.w / 1.7,
              maxRadius: maxImageSize.w / 1.7,
              backgroundColor: AppColor.primaryDarkColor,
              child: Image.asset(AssetsImages.logo),
            ),

          /// not admin image
          if (!isAdmin)
            GestureDetector(
              onTap: onPressed,
              child: CachedImageWidget(
                imageUrl: imgUrl,
                isCircle: true,
                height: maxImageSize.w,
                width: maxImageSize.w,
                progressBarScale: 0.5,
              ),
            ),
          Text(
            isAdmin ? "يامتر" : name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: nameColor, fontSize: nameSize),
          ),

          if (!isAdmin)
            if (showRating)
              RatingBar.builder(
                initialRating: rating,
                minRating: 0.5,
                itemSize: iconRateSize.w,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                unratedColor: unRatedColor,
                ignoreGestures: true,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: ratedColor,
                ),
                onRatingUpdate: (rating) {
                  log("$rating");
                },
              )
        ],
      ),
    );
  }

  Widget _withRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// admin image
        if (isAdmin)
          CircleAvatar(
            minRadius: minImageSize.w / 1.7,
            maxRadius: maxImageSize.w / 1.7,
            backgroundColor: AppColor.primaryDarkColor,
            child: Image.asset(AssetsImages.logo),
          ),

        /// not admin image
        if (!isAdmin)
          GestureDetector(
            onTap: onPressed,
            child: CachedImageWidget(
              imageUrl: imgUrl,
              isCircle: true,
              height: maxImageSize.w,
              width: maxImageSize.w,
              progressBarScale: 0.5,
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isAdmin ? "يامتر" : name,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: nameColor),
              ),
              if (!isAdmin)
                if (showRating)
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 0,
                    itemSize: Sizes.dimen_16.w,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    unratedColor: unRatedColor,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: ratedColor,
                    ),
                    onRatingUpdate: (rating) {
                      log("$rating");
                    },
                  ),
            ],
          ),
        )
      ],
    );
  }
}
