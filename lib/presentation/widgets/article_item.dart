import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/assets_constants.dart';
import '../../common/constants/sizes.dart';
import '../../router/route_helper.dart';
import '../themes/theme_color.dart';
import 'cached_image_widget.dart';
import 'card_menu_item.dart';
import 'image_name_rating_widget.dart';

class ArticleItem extends StatefulWidget {
  final ArticleEntity articleEntity;

  const ArticleItem({Key? key, required this.articleEntity}) : super(key: key);

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  bool _isMenuOpened = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _navigateToArticleDetailsScreen(),
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        child: Padding(
          padding: EdgeInsets.only(
              left: Sizes.dimen_8.w,
              right: Sizes.dimen_8.w,
              bottom: Sizes.dimen_8.h),
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// ImageNameRatingWidget
                  Container(
                    width: Sizes.dimen_70.w,
                    height: Sizes.dimen_70.w,
                    margin: EdgeInsets.only(left: Sizes.dimen_10.w),
                    decoration: BoxDecoration(
                      color: AppColor.primaryDarkColor,
                      borderRadius:
                          BorderRadius.circular(AppUtils.cornerRadius),
                    ),
                    child: CachedImageWidget(
                      imageUrl: widget.articleEntity.imageFeature,
                      isCircle: false,
                      withBorderRadius: true,
                      height: double.infinity,
                      width: double.infinity,
                      progressBarScale: 0.5,
                    ),
                  ),

                  /// data
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: Sizes.dimen_4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// title
                          Text(
                            widget.articleEntity.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 3,
                                    ),
                          ),

                          /// description
                          Text(
                            widget.articleEntity.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                      height: 1.3,
                                    ),
                          ),

                          /// date
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: AppColor.accentColor,
                                size: Sizes.dimen_12.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: Text(
                                  widget.articleEntity.createdAt,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: AppColor.accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// ImageNameRatingWidget
                  ImageNameRatingWidget(
                    name: widget.articleEntity.authorName,
                    imgUrl: widget.articleEntity.creatorImage,
                    rating: 3,
                    unRatedColor: AppColor.primaryColor.withOpacity(0.6),
                    withRow: false,
                    nameSize: Sizes.dimen_12.sp,
                    iconRateSize: Sizes.dimen_12,
                    minImageSize: Sizes.dimen_24,
                    maxImageSize: Sizes.dimen_24,
                    nameColor: AppColor.primaryDarkColor,
                    onPressed: () {
                      // RouteHelper().editProfile(context);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              left: Sizes.dimen_10.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isMenuOpened = !_isMenuOpened;
                  });
                },
                child: Text(
                  "...",
                  style: TextStyle(
                      fontSize: Sizes.dimen_20.sp,
                      color: AppColor.primaryDarkColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (_isMenuOpened)
              Positioned(
                top: Sizes.dimen_30,
                left: Sizes.dimen_10.w,
                child: Container(
                  padding: EdgeInsets.all(Sizes.dimen_5.w),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(color: AppColor.primaryDarkColor)),
                  child: Column(
                    children: [
                      CardMenuItem(
                        text: "Option1",
                        onPressed: () {},
                      ),
                      CardMenuItem(
                        text: "حذف االمنشور",
                        onPressed: () => _navigateToDeleteArticleScreen(),
                      ),
                    ],
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }

  /// To navigate to delete sos
  void _navigateToDeleteArticleScreen() {}

  /// To navigate to single screen sos
  void _navigateToArticleDetailsScreen() {}
}
