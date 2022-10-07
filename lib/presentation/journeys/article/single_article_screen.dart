import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../domain/entities/data/ad_entity.dart';
import '../../../domain/entities/screen_arguments/single_article_screen_args.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/get_single_article/get_single_article_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/ads_list/ads_list_view.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/image_name_rating_widget.dart';
import '../../widgets/scrollable_app_card.dart';
import 'article_image_slider.dart';

class SingleArticleScreen extends StatefulWidget {
  final SingleArticleArguments singleArticleArguments;

  const SingleArticleScreen({Key? key, required this.singleArticleArguments})
      : super(key: key);

  @override
  State<SingleArticleScreen> createState() => _SingleArticleScreenState();
}

class _SingleArticleScreenState extends State<SingleArticleScreen> {
  late final GetSingleArticleCubit _getSingleArticleCubit;
  late final int _articleId;

  @override
  void initState() {
    super.initState();
    _getSingleArticleCubit = getItInstance<GetSingleArticleCubit>();

    // init article id
    _articleId = widget.singleArticleArguments.articleId;

    // to fetch the article
    _fetchSingleAd();
  }

  @override
  void dispose() {
    _getSingleArticleCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getSingleArticleCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تفاصيل المنشور"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppUtils.mainPagesHorizontalPadding.w,
              vertical: AppUtils.mainPagesVerticalPadding.h),
          child: Column(
            children: [
              /// Ads ListView
              const AdsListViewWidget(
                adsList: [
                  AdEntity(id: 0, url: AssetsImages.adSample),
                  AdEntity(id: 1, url: AssetsImages.adSample),
                  AdEntity(id: 1, url: AssetsImages.adSample),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                child:
                    BlocBuilder<GetSingleArticleCubit, GetSingleArticleState>(
                  builder: (context, state) {
                    /// Loading
                    if (state is LoadingSingleArticle) {
                      return const Center(
                        child: LoadingWidget(),
                      );
                    }

                    /// UnAuthorizedCreateSos
                    if (state is UnAuthorizedGetSingleArticle) {
                      return Center(
                        child: AppErrorWidget(
                          appTypeError: AppErrorType.unauthorizedUser,
                          buttonText: "تسجيل الدخول",
                          onPressedRetry: () {
                            _navigateToLogin();
                          },
                        ),
                      );
                    }

                    /// NotActivatedUserToCreateSos
                    if (state is NotActivatedUserToGetSingleArticle) {
                      return Center(
                        child: AppErrorWidget(
                          appTypeError: AppErrorType.notActivatedUser,
                          buttonText: "تواصل معنا",
                          message:
                              "نأسف لذلك، لم يتم تفعيل حسابك سوف تصلك رسالة بريدية عند التفعيل",
                          onPressedRetry: () {
                            _navigateToContactUs();
                          },
                        ),
                      );
                    }

                    /// NotActivatedUserToCreateSos
                    if (state is ErrorWhileGettingSingleArticle) {
                      return Center(
                        child: AppErrorWidget(
                          appTypeError: state.appError.appErrorType,
                          onPressedRetry: () {
                            _fetchSingleAd();
                          },
                        ),
                      );
                    }

                    /// fetched
                    if (state is SingleArticleFetchedSuccessfully) {
                      final articleEntity = state.articleEntity;
                      return ScrollableAppCard(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        articleEntity.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color:
                                                    AppColor.primaryDarkColor,
                                                fontWeight: FontWeight.bold,
                                                height: 1.2),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.date_range_outlined,
                                            color: AppColor.accentColor,
                                            size: Sizes.dimen_12.w,
                                          ),
                                          Text(
                                            articleEntity.createdAt,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    color:
                                                        AppColor.accentColor),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                /// ImageNameRatingWidget
                                ImageNameRatingWidget(
                                  name: articleEntity.authorName,
                                  imgUrl: AssetsImages.personAvatar,
                                  rating: 3,
                                  unRatedColor:
                                      AppColor.primaryColor.withOpacity(0.6),
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

                            /// Space
                            SizedBox(height: Sizes.dimen_12.h),

                            ArticleImageSliderWidget(
                              images: state.articleEntity.images,
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _fetchSingleAd() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // fetch single article
    _getSingleArticleCubit.fetchSingleArticle(
      articleId: _articleId.toString(),
      userToken: userToken,
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
