import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/string_extensions.dart';
import 'package:yamaiter/common/extensions/widget_extension.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_article_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/update_article_args.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_article/delete_article_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/update_article/update_article_cubit.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';
import '../../common/enum/animation_type.dart';
import '../../router/route_helper.dart';
import '../logic/cubit/user_token/user_token_cubit.dart';
import '../themes/theme_color.dart';
import 'cached_image_widget.dart';
import 'card_menu_item.dart';
import 'image_name_rating_widget.dart';

class ArticleItem extends StatefulWidget {
  final ArticleEntity articleEntity;
  final DeleteArticleCubit? deleteArticleCubit;
  final UpdateArticleCubit? updateArticleCubit;
  final bool withMenu;

  const ArticleItem({
    Key? key,
    required this.articleEntity,
    this.deleteArticleCubit,
    this.updateArticleCubit,
    this.withMenu = true,
  }) : super(key: key);

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  bool _isMenuOpened = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          //==> close menu if opened
          if (_isMenuOpened) {
            setState(() {
              _isMenuOpened = !_isMenuOpened;
            });
          } else {
            _navigateToArticleDetailsScreen();
          }
        },
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        child: Padding(
          padding: EdgeInsets.only(
            left: Sizes.dimen_8.w,
            right: Sizes.dimen_8.w,
            bottom: Sizes.dimen_8.h,
          ),
          child: Stack(
            children: [
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 3,
                                  ),
                            ),

                            /// description
                            Text(
                              widget.articleEntity.description.removeHtmlTags(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                                        .bodySmall!
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
                      rating: widget.articleEntity.creatorRating.toDouble(),
                      isAdmin: widget.articleEntity.authorName == "admin" ||
                          widget.articleEntity.authorName == "ya maitre" ||
                          widget.articleEntity.authorName == "يامتر",
                      unRatedColor: AppColor.primaryColor.withOpacity(0.6),
                      withRow: false,
                      nameSize: Sizes.dimen_12.sp,
                      iconRateSize: Sizes.dimen_12,
                      minImageSize: Sizes.dimen_40.w,
                      maxImageSize: Sizes.dimen_40.w,
                      nameColor: AppColor.primaryDarkColor,
                      onPressed: () {
                        // RouteHelper().editProfile(context);
                      },
                    ),
                  ],
                ),
              ),

              /// menu dots
              if (widget.withMenu)
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

              /// menu
              if (_isMenuOpened && widget.withMenu)
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
                          text: "تعديل النشور",
                          onPressed: () => _navigateToUpdateArticlesScreen(),
                        ),
                        CardMenuItem(
                          text: "حذف االمنشور",
                          onPressed: () => _navigateToDeleteArticle(),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ).animate(
        slideDuration: const Duration(milliseconds: 300),
        fadeDuration: const Duration(milliseconds: 300),
        map: {
          AnimationType.slide: {
            SlideOffset.begin: const Offset(0.0, 0.5),
            SlideOffset.end: const Offset(0.0, 0.0),
          },
          AnimationType.fade: {
            FadeOpacity.begin: 0.5,
            FadeOpacity.end: 1.0,
          },
        });
  }

  /// To navigate to update article screen sos
  void _navigateToUpdateArticlesScreen() {
    // init articleId
    final articleEntity = widget.articleEntity;

    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init updateArticleCubit
    final updateArticleCubit = widget.updateArticleCubit!;

    RouteHelper().updateArticle(
      context,
      arguments: UpdateArticleArguments(
        articleEntity: articleEntity,
        userToken: userToken,
        updateArticleCubit: updateArticleCubit,
      ),
    );
  }

  /// to navigate to delete sos
  void _navigateToDeleteArticle() {
    // init articleId
    final articleId = widget.articleEntity.id;

    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init deleteArticleCubit
    final deleteArticleCubit = widget.deleteArticleCubit!;

    // navigate to delete article screen
    RouteHelper().deleteArticleScreen(context,
        arguments: DeleteArticleArguments(
          articleId: articleId,
          userToken: userToken,
          deleteArticleCubit: deleteArticleCubit,
        ));
  }

  /// To navigate to single screen sos
  void _navigateToArticleDetailsScreen() => RouteHelper().singleArticleScreen(
        context,
        articleId: widget.articleEntity.id,
      );
}
