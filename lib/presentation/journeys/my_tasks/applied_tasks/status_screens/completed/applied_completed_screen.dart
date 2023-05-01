import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/logic/cubit/get_applied_tasks/get_applied_tasks_cubit.dart';

import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../../common/enum/task_status.dart';
import '../../../../../../../../di/git_it_instance.dart';
import '../../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../../router/route_helper.dart';
import '../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_error_widget.dart';
import '../../../../../widgets/app_refersh_indicator.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../loading_more_applied_tasks.dart';
import 'applied_comleted_task_item.dart';

class AppliedCompletedScreen extends StatefulWidget {
  const AppliedCompletedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AppliedCompletedScreen> createState() => _AppliedInReviewState();
}

class _AppliedInReviewState extends State<AppliedCompletedScreen>
    with AutomaticKeepAliveClientMixin {
  /// posted_tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetMyTasksCubit
  late final GetAppliedTasksCubit _getAppliedTasks;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getAppliedTasks = getItInstance<GetAppliedTasksCubit>();
    _fetchCompletedTasksList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getAppliedTasks.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getAppliedTasks),
      ],
      child: BlocConsumer<GetAppliedTasksCubit, GetAppliedTasksState>(
        listener: (_, state) {
          //==> MyTasksListFetchedSuccessfully
          if (state is AppliedTasksListFetchedSuccessfully) {
            taskList.addAll(state.taskEntityList);
          }
          //==> lastPageFetched
          if (state is LastPageAppliedTasksListFetched) {
            taskList.addAll(state.taskEntityList);
          }
        },
        builder: (context, state) {
          //==> loading
          if (state is LoadingMoreAppliedTasksList) {
            return const Center(
              child: LoadingWidget(),
            );
          }

          //==> unAuthorized
          if (state is UnAuthorizedGetAppliedTasksList) {
            return Center(
              child: AppErrorWidget(
                appTypeError: AppErrorType.unauthorizedUser,
                buttonText: "تسجيل الدخول",
                onPressedRetry: () => _navigateToLogin(),
              ),
            );
          }

          //==> notActivatedUser
          if (state is NotActivatedUserToGetAppliedTasksList) {
            return Center(
              child: AppErrorWidget(
                appTypeError: AppErrorType.notActivatedUser,
                buttonText: "تواصل معنا",
                onPressedRetry: () => _navigateToContactUs(),
              ),
            );
          }

          //==> notActivatedUser
          if (state is ErrorWhileGettingAppliedTasksList) {
            return Center(
              child: AppErrorWidget(
                appTypeError: state.appError.appErrorType,
                onPressedRetry: () => _fetchCompletedTasksList(),
              ),
            );
          }

          //==> empty
          if (state is EmptyAppliedTasksList) {
            return Center(
              child: Text(
                "ليس لديك مهمات مكتملة",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.primaryDarkColor,
                    ),
              ),
            );
          }

          return AppRefreshIndicator(
            onRefresh: () async {
              taskList.clear();
              _fetchCompletedTasksList();
            },
            child: ListView.separated(
              controller: _controller,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),

              // count
              itemCount: taskList.length + 1,

              // separatorBuilder
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: Sizes.dimen_10.h,
                );
              },

              // itemBuilder
              itemBuilder: (BuildContext context, int index) {
                /// TaskItem
                if (index < taskList.length) {
                  return AppliedCompletedItem(
                    taskEntity: taskList[index],
                  );
                }

                /// loading or end of list
                return LoadingMoreAppliedTasksWidget(
                  appliedTasksCubit: _getAppliedTasks,
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// to fetch my posted_tasks list
  void _fetchCompletedTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAppliedTasks.fetchAppliedTasksList(
      userToken: userToken,
      taskType: TaskType.completed,
      currentListLength: taskList.length,
      offset: taskList.length,
    );
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getAppliedTasks.state is! LastPageAppliedTasksListFetched) {
          _fetchCompletedTasksList();
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => false;
}
