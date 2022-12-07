import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/all_lawyers/loading_more_lawyers_widget.dart';
import 'package:yamaiter/presentation/logic/cubit/fetch_lawyers/fetch_lawyers_cubit.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../router/route_helper.dart';
import '../../../domain/entities/data/lawyer_entity.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/lawyers/lawyer_item.dart';
import '../../widgets/loading_widget.dart';

class AllLawyerList extends StatefulWidget {
  const AllLawyerList({
    Key? key,
  }) : super(key: key);

  @override
  State<AllLawyerList> createState() => _AllLawyerListState();
}

class _AllLawyerListState extends State<AllLawyerList> {
  late final FetchLawyersCubit _lawyersCubit;

  int offset = 0;

  final List<LawyerEntity> allLawyersList = [];

  // ScrollController
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _lawyersCubit = getItInstance<FetchLawyersCubit>();
    _fetchLawyersList();
    _controller = ScrollController();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _lawyersCubit.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _lawyersCubit,
      child: BlocListener<FetchLawyersCubit, FetchLawyersState>(
        listener: (context, state) {
          //==> fetched
          if (state is LawyersFetched) {
            allLawyersList.addAll(state.lawyersList);
          }
          //==> last page reached
          if (state is LastPageLawyersFetched) {
            allLawyersList.addAll(state.lawyersList);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.dimen_10.h,
            bottom: Sizes.dimen_2.h,
            left: Sizes.dimen_10.w,
            right: Sizes.dimen_10.w,
          ),
          child: BlocBuilder<FetchLawyersCubit, FetchLawyersState>(
              builder: (_, state) {
            //==> loading
            if (state is LoadingLawyers) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            //==> unAuthorized
            if (state is UnAuthorizedToFetchLawyers) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.unauthorizedUser,
                  buttonText: "تسجيل الدخول",
                  onPressedRetry: () => _navigateToLogin(),
                ),
              );
            }

            //==> notActivatedUser
            if (state is ErrorWhileLoadingLawyers) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchLawyersList(),
                ),
              );
            }

            //==> empty
            if (state is EmptyLawyers) {
              return Center(
                child: Text(
                  "لا يوجد محامين",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.primaryDarkColor,
                      ),
                ),
              );
            }

            //==> fetched
            return ListView.separated(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: allLawyersList.length + 1,
              // controller: _controller,
              separatorBuilder: (context, index) => SizedBox(
                height: Sizes.dimen_2.h,
              ),
              itemBuilder: (context, index) {
                if (index < allLawyersList.length) {
                  return LawyerItem(lawyer: allLawyersList[index]);
                }

                /// loading or end of list
                return LoadingMoreLawyersWidget(
                  fetchLawyersCubit: _lawyersCubit,
                );
              },
            );
          }),
        ),
      ),
    );
  }

  /// to fetch lawyers list
  void _fetchLawyersList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _lawyersCubit.fetchLawyers(
      userToken: userToken,
      currentListLength: allLawyersList.length,
      offset: allLawyersList.length,
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_lawyersCubit.state is! LastPageLawyersFetched) {
          _fetchLawyersList();
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
