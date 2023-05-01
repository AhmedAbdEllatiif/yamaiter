import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/all_tasks/loading_more_all_tasks.dart';
import 'package:yamaiter/presentation/widgets/app_refersh_indicator.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/data/task_entity.dart';
import '../../../../router/route_helper.dart';
import '../../../logic/cubit/get_all_tasks/get_all_task_cubit.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/task_item.dart';

class AllTasksScreen extends StatefulWidget {
  final GetAllTasksCubit getAllTasksCubit;

  const AllTasksScreen({
    Key? key,
    required this.getAllTasksCubit,
  }) : super(key: key);

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  late final GetAllTasksCubit _getAllTasksCubit;

  int offset = 0;

  final List<TaskEntity> allTasksList = [];

  // ScrollController
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _getAllTasksCubit =
        widget.getAllTasksCubit; //getItInstance<GetAllTasksCubit>();
    //_fetchMyTasksList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _getAllTasksCubit.close();
    _controller.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getAllTasksCubit,
      child: BlocListener<GetAllTasksCubit, GetAllTasksState>(
        listener: (context, state) {
          //==> fetched
          if (state is AllTasksListFetchedSuccessfully) {
            allTasksList.addAll(state.taskEntityList);
          }
          //==> last page reached
          if (state is LastPageAllTasksListFetched) {
            allTasksList.addAll(state.taskEntityList);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            //top: Sizes.dimen_10.h,
            bottom: Sizes.dimen_2.h,
            left: Sizes.dimen_10.w,
            right: Sizes.dimen_10.w,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_3.h),
            child: BlocBuilder<GetAllTasksCubit, GetAllTasksState>(
                builder: (_, state) {
              //==> loading
              if (state is LoadingGetAllTasksList) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> unAuthorized
              if (state is UnAuthorizedGetAllTasksList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () => _navigateToLogin(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is NotActivatedUserToGetAllTasksList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    onPressedRetry: () => _navigateToContactUs(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is ErrorWhileGettingAllTasksList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchMyTasksList(),
                  ),
                );
              }

              //==> empty
              if (state is EmptyAllTasksList) {
                return Center(
                  child: Text(
                    "لا يوجد مهام",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.primaryDarkColor,
                        ),
                  ),
                );
              }

              //==> fetched
              return AppRefreshIndicator(
                onRefresh: () async {
                  allTasksList.clear();
                  _fetchMyTasksList();
                },
                child: ListView.separated(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: allTasksList.length + 1,
                  // controller: _controller,
                  separatorBuilder: (context, index) => SizedBox(
                    height: Sizes.dimen_2.h,
                  ),
                  itemBuilder: (context, index) {
                    if (index < allTasksList.length) {
                      return TaskItem(
                        taskEntity: allTasksList[index],
                      );
                    }

                    /// loading or end of list
                    return LoadingMoreAllTasksWidget(
                      allTasksCubit: _getAllTasksCubit,
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  /// to fetch Tasks list
  void _fetchMyTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAllTasksCubit.fetchAllTasksList(
      userToken: userToken,
      currentListLength: allTasksList.length,
      offset: allTasksList.length,
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getAllTasksCubit.state is! LastPageAllTasksListFetched) {
          _fetchMyTasksList();
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
