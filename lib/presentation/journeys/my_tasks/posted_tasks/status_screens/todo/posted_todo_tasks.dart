import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/enum/task_status.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_task_args.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_task/delete_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_refersh_indicator.dart';

import '../../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../../domain/entities/screen_arguments/edit_task_args.dart';
import '../../../../../../../../domain/entities/screen_arguments/single_task_details_params.dart';
import '../../../../../../../../router/route_helper.dart';
import '../../../../../logic/common/check_payment_status/check_payment_status_cubit.dart';
import '../../../../../logic/cubit/update_task/update_task_cubit.dart';
import '../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_error_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../loading_more_my_tasks.dart';
import 'todo_task_item.dart';

class PostedTodoTasks extends StatefulWidget {
  final PaymentAssignTaskCubit assignTaskCubit;

  const PostedTodoTasks({Key? key, required this.assignTaskCubit})
      : super(key: key);

  @override
  State<PostedTodoTasks> createState() => _PostedTodoTasksState();
}

class _PostedTodoTasksState extends State<PostedTodoTasks>
    with AutomaticKeepAliveClientMixin {
  /// posted_tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetMyTasksCubit
  late final GetMyTasksCubit _getMyTasksCubit;

  /// UpdateTaskCubit
  late final UpdateTaskCubit _updateTaskCubit;

  /// DeleteTaskCubit
  late final DeleteTaskCubit _deleteTaskCubit;

  /// CheckPaymentStatusCubit
  late final CheckPaymentStatusCubit _checkPaymentStatusCubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getMyTasksCubit = getItInstance<GetMyTasksCubit>();
    _updateTaskCubit = getItInstance<UpdateTaskCubit>();
    _deleteTaskCubit = getItInstance<DeleteTaskCubit>();
    _checkPaymentStatusCubit = getItInstance<CheckPaymentStatusCubit>();

    _fetchMyTasksList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getMyTasksCubit.close();
    _updateTaskCubit.close();
    _checkPaymentStatusCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _getMyTasksCubit),
          BlocProvider(create: (context) => _updateTaskCubit),
          BlocProvider(create: (context) => _deleteTaskCubit),
          BlocProvider(create: (context) => _checkPaymentStatusCubit),
        ],
        child: MultiBlocListener(
          listeners: [
            /// edit task listener
            BlocListener<GetMyTasksCubit, GetMyTasksState>(
                listener: (context, state) {
              // TODO: implement listener
            }),

            /// assign task listener
            /*BlocListener<PaymentAssignTaskCubit, PaymentToAssignTaskState>(
                bloc: _assignTaskCubit,
                listener: (context, state) {
                  if (state is PaymentLinkToAssignTaskFetched) {
                    taskList.clear();
                    _fetchMyTasksList();
                  }
                }),*/

            /// CheckPaymentStatus listener
            BlocListener<CheckPaymentStatusCubit, CheckPaymentStatusState>(
                listener: (_, state) {
              //==> accepted successfully
              if (state is PaymentSuccess) {
                taskList.clear();
                _fetchMyTasksList();
              }
            }),

            /// update task listener
            BlocListener<UpdateTaskCubit, UpdateTaskState>(
                listener: (context, state) {
              if (state is TaskUpdatedSuccessfully) {
                taskList.clear();
                _fetchMyTasksList();
              }
            }),

            /// delete task listener
            BlocListener<DeleteTaskCubit, DeleteTaskState>(
                listener: (context, state) {
              if (state is TaskDeletedSuccessfully) {
                taskList.clear();
                _fetchMyTasksList();
              }
            }),
          ],
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
                    onPressedRetry: () => _fetchMyTasksList(),
                  ),
                );
              }

              //==> empty
              if (state is EmptyMyTasksList) {
                return Center(
                  child: Text(
                    "ليس لديك طلبات من الغير",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.primaryDarkColor,
                        ),
                  ),
                );
              }

              return AppRefreshIndicator(
                onRefresh: () async {
                  taskList.clear();
                  _fetchMyTasksList();
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
                      return TodoTaskItem(
                        taskEntity: taskList[index],
                        onPressed: () {
                          _navigateToSingleTaskScreen(
                              taskEntity: taskList[index]);
                        },
                        onUpdatePressed: () {
                          _navigateToEditTaskScreen(taskList[index]);
                        },
                        onDeletePressed: () => _navigateToDeleteTaskScreen(
                          taskList[index].id,
                        ),
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
        ));
  }

  /// to fetch my posted_tasks list
  void _fetchMyTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyTasksCubit.fetchMyTasksList(
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
  void _navigateToSingleTaskScreen({required TaskEntity taskEntity}) {
    RouteHelper().singleTask(
      context,
      mySingleTaskArguments: MySingleTaskArguments(
        taskId: taskEntity.id,
        checkPaymentStatusCubit: _checkPaymentStatusCubit,
        updateTaskCubit: _updateTaskCubit,
        deleteTaskCubit: _deleteTaskCubit,
      ),
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getMyTasksCubit.state is! LastPageMyTasksListFetched) {
          _fetchMyTasksList();
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => false;
}
