import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/status_screens/completed/completed_task_item.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../../common/enum/task_status.dart';
import '../../../../../../../../di/git_it.dart';
import '../../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../../router/route_helper.dart';
import '../../../../../../../logic/cubit/end_task/end_task_cubit.dart';
import '../../../../../../../logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';
import '../../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../../themes/theme_color.dart';
import '../../../../../../../widgets/app_error_widget.dart';
import '../../../../../../../widgets/app_refersh_indicator.dart';
import '../../../../../../../widgets/loading_widget.dart';
import '../loading_more_my_tasks.dart';

class MyTasksCompleted extends StatefulWidget {
  final EndTaskCubit endTaskCubit;

  const MyTasksCompleted({Key? key, required this.endTaskCubit})
      : super(key: key);

  @override
  State<MyTasksCompleted> createState() => _MyTasksCompletedState();
}

class _MyTasksCompletedState extends State<MyTasksCompleted>
    with AutomaticKeepAliveClientMixin {
  /// my_tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetMyTasksCubit
  late final GetMyTasksCubit _getMyTasksCubit;

  /// EndTaskCubit
  late final EndTaskCubit _endTaskCubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getMyTasksCubit = getItInstance<GetMyTasksCubit>();
    _endTaskCubit = widget.endTaskCubit;
    _fetchCompletedTasksList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getMyTasksCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getMyTasksCubit),
      ],
      child: BlocListener<EndTaskCubit, EndTaskState>(
        bloc: _endTaskCubit,
        listener: (context, state) {
          /// to refresh the list after the task is ended
          if (state is TaskEndedSuccessfully) {
            _fetchCompletedTasksList();
          }
        },
        child: BlocConsumer<GetMyTasksCubit, GetMyTasksState>(
          listener: (_, state) {
            //==> MyTasksListFetchedSuccessfully
            if (state is MyTasksListFetchedSuccessfully) {
              taskList.addAll(state.taskEntityList);
            }
            //==> lastPageFetched
            if (state is LastPageMyTasksListFetched) {
              taskList.addAll(state.taskEntityList);
            }
          },
          builder: (context, state) {
            //==> loading
            if (state is LoadingGetMyTasksList) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            //==> unAuthorized
            if (state is UnAuthorizedGetMyTasksList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.unauthorizedUser,
                  buttonText: "تسجيل الدخول",
                  onPressedRetry: () => _navigateToLogin(),
                ),
              );
            }

            //==> notActivatedUser
            if (state is NotActivatedUserToGetMyTasksList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.notActivatedUser,
                  buttonText: "تواصل معنا",
                  onPressedRetry: () => _navigateToContactUs(),
                ),
              );
            }

            //==> notActivatedUser
            if (state is ErrorWhileGettingMyTasksList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchCompletedTasksList(),
                ),
              );
            }

            //==> empty
            if (state is EmptyMyTasksList) {
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
              onRefresh: ()async {
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
                    return CompletedTaskItem(
                      taskEntity: taskList[index],
                    );
                  }

                  /// loading or end of list
                  return LoadingMoreMyTasksWidget(
                    myTasksCubit: _getMyTasksCubit,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  /// to fetch my my_tasks list
  void _fetchCompletedTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyTasksCubit.fetchMyTasksList(
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
        if (_getMyTasksCubit.state is! LastPageMyTasksListFetched) {
          _fetchCompletedTasksList();
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
