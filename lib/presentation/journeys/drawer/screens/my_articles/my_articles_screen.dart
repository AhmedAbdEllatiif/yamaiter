import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/screen_arguments/add_article_args.dart';
import 'package:yamaiter/presentation/logic/cubit/create_article/create_article_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_article/delete_article_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/my_articles/my_articles_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/update_article/update_article_cubit.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../../../common/constants/app_utils.dart';
import '../../../../../common/constants/assets_constants.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../../common/enum/app_error_type.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/data/ad_entity.dart';
import '../../../../../router/route_helper.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../../../widgets/article_item.dart';
import '../../../../widgets/title_with_add_new_item.dart';

class MyArticlesScreen extends StatefulWidget {
  const MyArticlesScreen({Key? key}) : super(key: key);

  @override
  State<MyArticlesScreen> createState() => _MyArticlesScreenState();
}

class _MyArticlesScreenState extends State<MyArticlesScreen> {
  late final MyArticlesCubit _myArticlesCubit;
  late final DeleteArticleCubit _deleteArticleCubit;
  late final CreateArticleCubit _createArticleCubit;
  late final UpdateArticleCubit _updateArticleCubit;

  @override
  void initState() {
    super.initState();
    _myArticlesCubit = getItInstance<MyArticlesCubit>();
    _deleteArticleCubit = getItInstance<DeleteArticleCubit>();
    _createArticleCubit = getItInstance<CreateArticleCubit>();
    _updateArticleCubit = getItInstance<UpdateArticleCubit>();
    _fetchMyArticles();
  }

  @override
  void dispose() {
    _myArticlesCubit.close();
    _deleteArticleCubit.close();
    _createArticleCubit.close();
    _updateArticleCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _myArticlesCubit),
        BlocProvider(create: (context) => _deleteArticleCubit),
        BlocProvider(create: (context) => _createArticleCubit),
        BlocProvider(create: (context) => _updateArticleCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          /// refresh list on delete item
          BlocListener<DeleteArticleCubit, DeleteArticleState>(
            listener: (context, state) {
              if (state is ArticleDeletedSuccessfully) {
                _fetchMyArticles();
              }
            },
          ),

          /// refresh list of add item
          BlocListener<CreateArticleCubit, CreateArticleState>(
            listener: (context, state) {
              if (state is ArticleCreatedSuccessfully) {
                _fetchMyArticles();
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("منشوراتى"),
          ),
          body: Column(
            children: [
              const AdsWidget(
                adsList: [
                  AdEntity(id: 0, url: AssetsImages.adSample),
                  AdEntity(id: 1, url: AssetsImages.adSample),
                  AdEntity(id: 1, url: AssetsImages.adSample),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.dimen_16.h,
                    right: AppUtils.mainPagesHorizontalPadding.w,
                    left: AppUtils.mainPagesHorizontalPadding.w,
                  ),
                  child: Column(
                    children: [
                      /// title with add new sos
                      TitleWithAddNewItem(
                        title: "منشوراتى",
                        addText: "اضف منشور جديد",
                        onAddPressed: () => _navigateToAddArticle(),
                      ),

                      /// fetched list
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child:
                                BlocBuilder<MyArticlesCubit, MyArticlesState>(
                              builder: (context, state) {
                                /// loading
                                if (state is LoadingMyArticlesList) {
                                  return const Center(
                                    child: LoadingWidget(),
                                  );
                                }

                                /// unAuthorized
                                if (state is UnAuthorizedGetMyArticlesList) {
                                  return Center(
                                    child: AppErrorWidget(
                                      appTypeError:
                                          AppErrorType.unauthorizedUser,
                                      buttonText: "تسجيل الدخول",
                                      onPressedRetry: () => _navigateToLogin(),
                                    ),
                                  );
                                }

                                /// notActivatedUser
                                if (state
                                    is NotActivatedUserToGetMyArticlesList) {
                                  return Center(
                                    child: AppErrorWidget(
                                      appTypeError:
                                          AppErrorType.notActivatedUser,
                                      buttonText: "تواصل معنا",
                                      onPressedRetry: () =>
                                          _navigateToContactUs(),
                                    ),
                                  );
                                }

                                /// notActivatedUser
                                if (state is ErrorWhileGettingMyArticlesList) {
                                  return Center(
                                    child: AppErrorWidget(
                                      appTypeError: state.appError.appErrorType,
                                      onPressedRetry: () => _fetchMyArticles(),
                                    ),
                                  );
                                }

                                /// fetched
                                if (state
                                    is MyArticlesListFetchedSuccessfully) {
                                  return ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.articleEntityList.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: Sizes.dimen_2.h,
                                    ),
                                    itemBuilder: (context, index) {
                                      return ArticleItem(
                                        articleEntity:
                                            state.articleEntityList[index],
                                        deleteArticleCubit: _deleteArticleCubit,
                                        updateArticleCubit: _updateArticleCubit,
                                      );
                                    },
                                  );
                                }

                                /// other
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// to fetch my articles list
  void _fetchMyArticles() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _myArticlesCubit.fetchMyArticlesList(userToken: userToken);
  }

  /// to navigate to add article
  void _navigateToAddArticle() => RouteHelper().addArticle(context,
      arguments: AddArticleArguments(createArticleCubit: _createArticleCubit));

  /// to navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
