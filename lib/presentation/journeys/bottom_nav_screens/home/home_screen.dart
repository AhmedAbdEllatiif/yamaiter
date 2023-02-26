import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/home/loading_more_all_articles.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/data/article_entity.dart';
import '../../../../router/route_helper.dart';
import '../../../logic/cubit/get_all_articles/get_all_articles_cubit.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/app_refersh_indicator.dart';
import '../../../widgets/article_item.dart';
import '../../../widgets/loading_widget.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
  late final GetAllArticlesCubit _getAllArticlesCubit;

  int offset = 0;

  final List<ArticleEntity> allArticlesList = [];

  // ScrollController
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _getAllArticlesCubit = getItInstance<GetAllArticlesCubit>();
    _fetchMyArticlesList();
    _controller = ScrollController();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _getAllArticlesCubit.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getAllArticlesCubit,
      child: BlocListener<GetAllArticlesCubit, GetAllArticlesState>(
        listener: (context, state) {
          //==> fetched
          if (state is AllArticlesListFetchedSuccessfully) {
            allArticlesList.addAll(state.articlesList);
          }
          //==> last page reached
          if (state is LastPageAllArticlesReached) {
            allArticlesList.addAll(state.articlesList);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.dimen_10.h,
            bottom: Sizes.dimen_2.h,
            left: Sizes.dimen_10.w,
            right: Sizes.dimen_10.w,
          ),
          child: BlocBuilder<GetAllArticlesCubit, GetAllArticlesState>(
              builder: (_, state) {
            //==> loading
            if (state is LoadingGetAllArticlesList) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            //==> unAuthorized
            if (state is UnAuthorizedGetAllArticlesList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.unauthorizedUser,
                  buttonText: "تسجيل الدخول",
                  onPressedRetry: () => _navigateToLogin(),
                ),
              );
            }

            //==> notActivatedUser
            if (state is NotActivatedUserToGetAllArticlesList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.notActivatedUser,
                  buttonText: "تواصل معنا",
                  onPressedRetry: () => _navigateToContactUs(),
                ),
              );
            }

            //==> notActivatedUser
            if (state is ErrorWhileGettingAllArticlesList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchMyArticlesList(),
                ),
              );
            }

            //==> empty
            if (state is EmptyAllArticlesList) {
              return Center(
                child: Text(
                  "لا يوجد منشورات",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.primaryDarkColor,
                      ),
                ),
              );
            }

            //==> fetched
            return AppRefreshIndicator(
              onRefresh: () async {
                allArticlesList.clear();
                _fetchMyArticlesList();
              },
              child: ListView.separated(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: allArticlesList.length + 1,
                // controller: _controller,
                separatorBuilder: (context, index) => SizedBox(
                  height: Sizes.dimen_2.h,
                ),
                itemBuilder: (context, index) {
                  if (index < allArticlesList.length) {
                    return ArticleItem(
                      articleEntity: allArticlesList[index],
                      withMenu: false,
                    );
                  }

                  /// loading or end of list
                  return LoadingMoreAllArticlesWidget(
                    allArticlesCubit: _getAllArticlesCubit,
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  /// to fetch Articles list
  void _fetchMyArticlesList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAllArticlesCubit.fetchAllArticlesList(
      userToken: userToken,
      currentListLength: allArticlesList.length,
      offset: allArticlesList.length,
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getAllArticlesCubit.state is! LastPageAllArticlesReached) {
          _fetchMyArticlesList();
        }
      }
    });
  }

  /// to navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to navigate to contact us
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
