import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/screen_arguments/search_result_args.dart';
import 'package:yamaiter/presentation/journeys/search_result_for_lawyers/search_result_item.dart';
import 'package:yamaiter/presentation/logic/cubit/fetch_lawyers/fetch_lawyers_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/search_for_lawyers/search_for_lawyers_cubit.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../domain/entities/data/lawyer_entity.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../main/main_page_title.dart';
import 'loading_more_search_result.dart';

class SearchResultForLawyers extends StatefulWidget {
  final SearchResultArguments arguments;

  const SearchResultForLawyers({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<SearchResultForLawyers> createState() => _SearchResultForLawyersState();
}

class _SearchResultForLawyersState extends State<SearchResultForLawyers> {
  /// SearchForLawyersCubit
  late final SearchForLawyersCubit _searchForLawyersCubit;

  /// result of lawyers
  late final List<LawyerEntity> lawyerResult = [];

  /// governorates searching in
  late final String _governorates;

  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _searchForLawyersCubit = getItInstance<SearchForLawyersCubit>();
    //lawyerResult = widget.arguments.lawyersResult;
    _governorates = widget.arguments.governorates;
    _searchForLawyers();

    /// init cotroller
    _controller = ScrollController();
    _listenerOnScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchForLawyersCubit,
      child: BlocListener<SearchForLawyersCubit, SearchForLawyersState>(
        listener: (context, state) {
          //==> fetched
          if (state is SearchLawyersResult) {
            lawyerResult.addAll(state.lawyersResult);
          }
          //==> last page reached
          if (state is LastPageSearchForLawyersFetched) {
            lawyerResult.addAll(state.lawyersResult);
          }
        },
        child: Scaffold(

          /// appBar
          appBar: AppBar(
            title: const Text("نتائج البحث"),
          ),

          /// body
          body: Column(
            children: [

              /// adsWidget
              const AdsWidget(),

              /// title with add new Tasks
              Padding(
                padding: EdgeInsets.only(
                  top: AppUtils.mainPagesVerticalPadding.h,
                  right: AppUtils.mainPagesHorizontalPadding.w,
                  left: AppUtils.mainPagesHorizontalPadding.w,
                ),
                child: const MainPageTitle(
                  title: "نتائج البحث",
                ),
              ),

              SizedBox(
                height: Sizes.dimen_10.h,
              ),




              /// result list
              BlocBuilder<SearchForLawyersCubit, SearchForLawyersState>(

                builder: (context, state) {

                  //==> loading
                  if (state is LoadingSearchForLawyersList) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }

                  //==> unAuthorized
                  if (state is UnAuthorizedSearchForLawyers) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: AppErrorType.unauthorizedUser,
                        buttonText: "تسجيل الدخول",
                        onPressedRetry: () => _navigateToLogin(),
                      ),
                    );
                  }

                  //==> notActivatedUser
                  if (state is NotActivatedUserToSearchForLawyers) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: AppErrorType.notActivatedUser,
                        buttonText: "تواصل معنا",
                        onPressedRetry: () => _navigateToContactUs(),
                      ),
                    );
                  }

                  //==> notActivatedUser
                  if (state is ErrorWhileSearchingForLawyers) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: state.appError.appErrorType,
                        onPressedRetry: () => _searchForLawyers(),
                      ),
                    );
                  }

                  //==> empty
                  if (state is EmptyLawyers) {
                    return Center(
                      child: Text(
                        "لا يوجد محامين في هذه المحافظة",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.primaryDarkColor,
                        ),
                      ),
                    );
                  }



                  return Flexible(
                    child: ListView.separated(
                      controller: _controller,
                      padding: EdgeInsets.only(
                          right: AppUtils.mainPagesHorizontalPadding.w,
                          left: AppUtils.mainPagesHorizontalPadding.w,
                          bottom: 30),
                      shrinkWrap: true,

                      physics: const BouncingScrollPhysics(),

                      //==> itemCount
                      itemCount: lawyerResult.length + 1,

                      //==> separatorBuilder
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: Sizes.dimen_5.h,
                        );
                      },

                      //==> itemBuilder
                      itemBuilder: (context, index) {
                        if (index < lawyerResult.length) {
                          return SearchResultItem(
                              lawyerEntity: lawyerResult[index]);
                        }

                        /// loading or end of list
                        return LoadingMoreSearchResultWidget(
                          searchForLawyersCubit: _searchForLawyersCubit,
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  /// To search for lawyers
  void _searchForLawyers() {
    // init userToken
    final userToken = getUserToken(context);

    _searchForLawyersCubit.searchForLawyer(
      userToken: userToken,
      governorates: _governorates,
      currentListLength: lawyerResult.length,
      offset: lawyerResult.length,
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_searchForLawyersCubit.state is! LastPageSearchForLawyersFetched) {
          _searchForLawyers();
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
