import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/enum/task_status.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_task_args.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/status_screens/todo/todo_task_item.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_task/delete_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_applied_tasks/get_applied_tasks_cubit.dart';

import '../../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../../domain/entities/screen_arguments/edit_task_args.dart';
import '../../../../../../../../domain/entities/screen_arguments/single_task_details_params.dart';
import '../../../../../../../../router/route_helper.dart';
import '../../../../../../../logic/cubit/update_task/update_task_cubit.dart';
import '../../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../../themes/theme_color.dart';
import '../../../../../../../widgets/app_error_widget.dart';
import '../../../../../../../widgets/loading_widget.dart';
import '../../loading_more_applied_tasks.dart';
import 'applied_todo_task_item.dart';

class AppliedTaskTodo extends StatefulWidget {
  final AssignTaskCubit assignTaskCubit;

  const AppliedTaskTodo({Key? key, required this.assignTaskCubit})
      : super(key: key);

  @override
  State<AppliedTaskTodo> createState() => _AppliedTaskTodoState();
}

class _AppliedTaskTodoState extends State<AppliedTaskTodo>
    with AutomaticKeepAliveClientMixin {
  /// my_tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetAppliedTaskCubit
  late final GetAppliedTasksCubit _getAppliedTaskCubit;

  /// UpdateTaskCubit
  late final UpdateTaskCubit _updateTaskCubit;

  /// DeleteTaskCubit
  late final DeleteTaskCubit _deleteTaskCubit;
  late final AssignTaskCubit _assignTaskCubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getAppliedTaskCubit = getItInstance<GetAppliedTasksCubit>();
    _updateTaskCubit = getItInstance<UpdateTaskCubit>();
    _deleteTaskCubit = getItInstance<DeleteTaskCubit>();
    _assignTaskCubit = widget.assignTaskCubit;

    _fetchAppliedTaskList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getAppliedTaskCubit.close();
    _updateTaskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _getAppliedTaskCubit),
          BlocProvider(create: (context) => _updateTaskCubit),
          BlocProvider(create: (context) => _deleteTaskCubit),
        ],
        child: MultiBlocListener(
          listeners: [
            /// assign task listener
            BlocListener<AssignTaskCubit, AssignTaskState>(
                bloc: _assignTaskCubit,
                listener: (context, state) {
                  if (state is TaskAssignedSuccessfully) {
                    taskList.clear();
                    _fetchAppliedTaskList();
                  }
                }),

            /// update task listener
            BlocListener<UpdateTaskCubit, UpdateTaskState>(
                listener: (context, state) {
              if (state is TaskUpdatedSuccessfully) {
                taskList.clear();
                _fetchAppliedTaskList();
              }
            }),

            /// delete task listener
            BlocListener<DeleteTaskCubit, DeleteTaskState>(
                listener: (context, state) {
              if (state is TaskDeletedSuccessfully) {
                taskList.clear();
                _fetchAppliedTaskList();
              }
            }),
          ],
          child: BlocConsumer<GetAppliedTasksCubit, GetAppliedTasksState>(
            listener: (_, state) {
              //==> AppliedTaskListFetchedSuccessfully
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
              if (state is LoadingGetAppliedTasksList) {
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
                    onPressedRetry: () => _fetchAppliedTaskList(),
                  ),
                );
              }

              //==> empty
              if (state is EmptyAppliedTasksList) {
                return Center(
                  child: Text(
                    "ليس لديك مهام لحساب الغير",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.primaryDarkColor,
                        ),
                  ),
                );
              }

              return ListView.separated(
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
                    return AppliedTodoTaskItem(
                      taskEntity: taskList[index],
                    );
                  }

                  /// loading or end of list
                  return LoadingMoreAppliedTasksWidget(
                    appliedTasksCubit: _getAppliedTaskCubit,
                  );
                },
              );
            },
          ),
        ));
  }

  /// to fetch my my_tasks list
  void _fetchAppliedTaskList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAppliedTaskCubit.fetchAppliedTasksList(
      userToken: userToken,
      taskType: TaskType.todo,
      currentListLength: taskList.length,
      offset: taskList.length,
    );
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);

  /// to navigate to edit task screen
  void _navigateToEditTaskScreen(TaskEntity taskEntity) =>
      RouteHelper().editTask(
        context,
        editTaskArguments: EditTaskArguments(
          updateTaskCubit: _updateTaskCubit,
          taskEntity: taskEntity,
        ),
      );

  /// to navigate to delete task screen
  void _navigateToDeleteTaskScreen(int id) => RouteHelper().deleteTask(
        context,
        deleteTaskArguments: DeleteTaskArguments(
          deleteTaskCubit: _deleteTaskCubit,
          taskId: id,
        ),
      );

  /// to navigate to single task screen
  void _navigateToSingleTaskScreen({required int taskId}) {
    RouteHelper().singleTask(
      context,
      editTaskArguments: SingleTaskArguments(
        taskId: taskId,
        assignTaskCubit: _assignTaskCubit,
      ),
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getAppliedTaskCubit.state is! LastPageAppliedTasksListFetched) {
          _fetchAppliedTaskList();
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
