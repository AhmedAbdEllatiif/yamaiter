import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class ImageNameRatingWidget extends StatelessWidget {
  final String imgUrl;
  final String name;
  final int rating;
  final double? nameSize;
  final Function() onPressed;
  final double minImageSize;
  final double maxImageSize;
  final Color nameColor;
  final Color unRatedColor;
  final Color ratedColor;
  final bool withRow;
  final double iconRateSize;

  const ImageNameRatingWidget({
    Key? key,
    required this.imgUrl,
    required this.name,
    required this.rating,
    required this.onPressed,
    this.nameSize,
    this.withRow = true,
    this.minImageSize = Sizes.dimen_30,
    this.maxImageSize = Sizes.dimen_30,
    this.iconRateSize = Sizes.dimen_16,
    this.nameColor = AppColor.white,
    this.unRatedColor = AppColor.white,
    this.ratedColor = AppColor.accentColor,
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
          GestureDetector(
            onTap: onPressed,
            child: CircleAvatar(
              minRadius: minImageSize.w,
              maxRadius: maxImageSize.w,
              backgroundImage: AssetImage(imgUrl),
            ),
          ),
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: nameColor, fontSize: nameSize),
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
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
              print(rating);
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
        GestureDetector(
          onTap: onPressed,
          child: CircleAvatar(
            minRadius: minImageSize.w,
            maxRadius: maxImageSize.w,
            backgroundImage: AssetImage(imgUrl),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: nameColor),
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
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
                  print(rating);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
