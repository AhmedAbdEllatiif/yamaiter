import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../../../common/enum/app_error_type.dart';
import '../../../../../di/git_it_instance.dart';
import '../../../../../domain/entities/data/article_entity.dart';
import '../../../../../router/route_helper.dart';
import '../../../../logic/cubit/get_all_articles/get_all_articles_cubit.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../../../widgets/app_refersh_indicator.dart';
import '../../../../widgets/article_item.dart';
import '../../../../widgets/lawyers/top_rated_lawyers_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../main/main_page_title.dart';

class HomePageClient extends StatefulWidget {
  const HomePageClient({Key? key}) : super(key: key);

  @override
  State<HomePageClient> createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

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

  bool isStretched = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getAllArticlesCubit,
      child: Builder(builder: (context) {
        return BlocBuilder<GetAllArticlesCubit, GetAllArticlesState>(
          builder: (context, state) {
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

            /// LastPageAllArticlesReached
            if (state is LastPageAllArticlesReached) {
              return AppRefreshIndicator(
                onRefresh: () async {
                  _fetchMyArticlesList();
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: <Widget>[
                    /// special lawyers
                    SliverAppBar(
                      pinned: true,
                      snap: _snap,
                      floating: true,
                      automaticallyImplyLeading: false,
                      expandedHeight: ScreenUtil.screenHeight * 0.28,
                      backgroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        title: const MainPageTitle(
                          title: "احدث المنشورات",
                        ),
                        titlePadding: const EdgeInsets.only(top: 1),
                        expandedTitleScale: 1.3,
                        background: Container(
                          color: AppColor.white,
                          //padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              MainPageTitle(
                                title: "محامين متمزين",
                              ),
                              TopRatedLawyersWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// text
                    /*const SliverToBoxAdapter(
                      child: MainPageTitle(
                        title: "احدث المنشورات",
                      ),
                    ),*/
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index == state.articlesList.length - 1) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ArticleItem(
                                articleEntity: state.articlesList[index],
                                withMenu: false,
                              ),
                            );
                          } else {
                            return ArticleItem(
                              articleEntity: state.articlesList[index],
                              withMenu: false,
                            );
                          }
                        },
                        childCount: state.articlesList.length,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        );
      }),
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
