import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_task_client_args.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/loading_more_my_tasks_client.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/todo_client/todo_task_item_client.dart';
import 'package:yamaiter/presentation/logic/client_cubit/assign_task/assign_task_client_cubit.dart';
import 'package:yamaiter/presentation/logic/client_cubit/get_my_tasks_client/get_my_tasks_client_cubit.dart';

import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../common/enum/task_status.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../../../../logic/cubit/assign_task/assign_task_cubit.dart';
import '../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../themes/theme_color.dart';
import '../../../../../../widgets/app_error_widget.dart';
import '../../../../../../widgets/app_refersh_indicator.dart';
import '../../../../../../widgets/loading_widget.dart';

class MyTasksTodoClient extends StatefulWidget {
  final AssignTaskClientCubit assignTaskClientCubit;

  const MyTasksTodoClient({Key? key, required this.assignTaskClientCubit})
      : super(key: key);

  @override
  State<MyTasksTodoClient> createState() => _MyTasksTodoClientState();
}

class _MyTasksTodoClientState extends State<MyTasksTodoClient>
    with AutomaticKeepAliveClientMixin {
  /// task list
  final List<TaskEntity> tasksList = [];

  /// GetMyTasksClientCubit
  late final GetMyTasksClientCubit _getMyTasksClientCubit;

  /// AssignTaskClientCubit
  late final AssignTaskClientCubit _assignTaskClientCubit;

  /// ScrollController
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    //==> init scroll controller
    _controller = ScrollController();

    //==> init _assignTaskClientCubit
    _assignTaskClientCubit = widget.assignTaskClientCubit;

    //==> init _getMyTasksClientCubit
    _getMyTasksClientCubit = getItInstance<GetMyTasksClientCubit>();

    //==> start fetching tasks list
    _fetchMyTasksList();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getMyTasksClientCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _getMyTasksClientCubit),
          //BlocProvider(create: (context) => _updateTaskCubit),
          //BlocProvider(create: (context) => _deleteTaskCubit),
        ],
        child: MultiBlocListener(
          listeners: [
            /// edit task listener
            /*BlocListener<GetMyTasksCubit, GetMyTasksState>(
                listener: (context, state) {
              // TODO: implement listener
            }),*/

            /// assign task listener
            BlocListener<AssignTaskClientCubit, AssignTaskClientState>(
                bloc: _assignTaskClientCubit,
                listener: (context, state) {
                  if (state is TaskClientAssignedSuccessfully) {
                    tasksList.clear();
                    _fetchMyTasksList();
                  }
                }),

            /// update task listener
            /*BlocListener<UpdateTaskCubit, UpdateTaskState>(
                listener: (context, state) {
              if (state is TaskUpdatedSuccessfully) {
                taskList.clear();
                _fetchMyTasksList();
              }
            }),*/

            /// delete task listener
            /*BlocListener<DeleteTaskCubit, DeleteTaskState>(
                listener: (context, state) {
              if (state is TaskDeletedSuccessfully) {
                tasksList.clear();
                _fetchMyTasksList();
              }
            }),*/
          ],
          child: BlocConsumer<GetMyTasksClientCubit, GetMyTasksClientState>(
            listener: (_, state) {
              //==> MyTasksListFetchedSuccessfully
              if (state is MyTasksClientListFetchedSuccessfully) {
                tasksList.addAll(state.taskEntityList);
              }
              //==> lastPageFetched
              if (state is LastPageMyTasksClientListFetched) {
                tasksList.addAll(state.taskEntityList);
              }
            },
            builder: (context, state) {
              //==> loading
              if (state is LoadingGetMyTasksClientList) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> unAuthorized
              if (state is UnAuthorizedGetMyTasksClientList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () => _navigateToLogin(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is NotActivatedUserToGetMyTasksClientList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    onPressedRetry: () => _navigateToContactUs(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is ErrorWhileGettingMyTasksClientList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchMyTasksList(),
                  ),
                );
              }

              //==> empty
              if (state is EmptyMyTasksClientList) {
                return Center(
                  child: Text(
                    "ليس لديك طلبات",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.primaryDarkColor,
                        ),
                  ),
                );
              }

              return AppRefreshIndicator(
                onRefresh: () async {
                  tasksList.clear();
                  _fetchMyTasksList();
                },
                child: ListView.separated(
                  controller: _controller,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),

                  // count
                  itemCount: tasksList.length + 1,

                  // separatorBuilder
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: Sizes.dimen_10.h,
                    );
                  },

                  // itemBuilder
                  itemBuilder: (BuildContext context, int index) {
                    /// TaskItem
                    if (index < tasksList.length) {
                      return TodoTaskItemClient(
                          taskEntity: tasksList[index],
                          onPressed: () {
                            _navigateToSingleTaskScreen(
                                taskId: tasksList[index].id);
                          },
                          onUpdatePressed: () {
                            //_navigateToEditTaskScreen(taskList[index]);
                          },
                          onDeletePressed: () {});
                    }

                    /// loading or end of list
                    return LoadingMoreMyTasksClientWidget(
                      myTasksClientCubit: _getMyTasksClientCubit,
                    );
                  },
                ),
              );
            },
          ),
        ));
  }

  /// to fetch my my_tasks list
  void _fetchMyTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyTasksClientCubit.fetchMyTasksClientList(
      userToken: userToken,
      taskType: TaskType.todo,
      currentListLength: tasksList.length,
      offset: tasksList.length,
    );
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);

  void _navigateToSingleTaskScreen({required int taskId}) =>
      RouteHelper().singleTaskClient(
        context,
        singleTaskClientArguments: SingleTaskClientArguments(
          assignTaskClientCubit: _assignTaskClientCubit,
          taskId: taskId,
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
