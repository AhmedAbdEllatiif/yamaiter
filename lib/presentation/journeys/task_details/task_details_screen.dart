import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/common/functions/navigate_to_login.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/apply_for_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/task_details_args.dart';
import 'package:yamaiter/presentation/journeys/task_details/task_details_widget.dart';
import 'package:yamaiter/presentation/logic/cubit/apply_for_task/apply_for_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_single_task_details_cubit/get_single_task_details_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../widgets/ads_widget.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskDetailsArguments taskDetailsArguments;

  const TaskDetailsScreen({Key? key, required this.taskDetailsArguments})
      : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late final TaskEntity _taskEntity;

  late final ApplyForTaskCubit applyForTaskCubit;
  late final GetSingleTaskDetailsCubit _singleTaskDetailsCubit;

  @override
  void initState() {
    super.initState();
    applyForTaskCubit = getItInstance<ApplyForTaskCubit>();
    _singleTaskDetailsCubit = getItInstance<GetSingleTaskDetailsCubit>();
    if (widget.taskDetailsArguments.taskEntity != null) {
      _taskEntity = widget.taskDetailsArguments.taskEntity!;
    } else {
      _fetchTaskDetails();
    }
  }

  @override
  void dispose() {
    applyForTaskCubit.close();
    _singleTaskDetailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _singleTaskDetailsCubit,
      child: Scaffold(
        /// appbar
        appBar: AppBar(
          title: const Text("تفاصيل المهمة"),
        ),

        /// body
        body: MultiBlocListener(
          listeners: [
            BlocListener<ApplyForTaskCubit, ApplyForTaskState>(
              bloc: applyForTaskCubit,
              listener: (context, state) {
                if (state is AppliedForTaskSuccessfully) {
                  _navigateToAppliedTaskScreen();
                }
              },
            ),
            BlocListener<ApplyForTaskCubit, ApplyForTaskState>(
              bloc: applyForTaskCubit,
              listener: (context, state) {
                if (state is AppliedForTaskSuccessfully) {
                  _navigateToAppliedTaskScreen();
                }
              },
            ),
          ],
          child: Column(
            children: [
              /// Ads ListView
              const AdsWidget(),

              /// space
              const SizedBox(
                height: 10,
              ),

              widget.taskDetailsArguments.taskEntity != null
                  ? TaskDetailsWidget(
                      applyForTaskCubit: applyForTaskCubit,
                      taskEntity: widget.taskDetailsArguments.taskEntity!,
                      isAlreadyApplied:
                          widget.taskDetailsArguments.isAlreadyApplied,
                    )
                  : BlocBuilder<GetSingleTaskDetailsCubit,
                      GetSingleTaskDetailsState>(
                      builder: (context, state) {
                        /*
                        *
                        *
                        *
                        *
                        *
                        * */
                        if (state is LoadingSingleTaskDetails) {
                          return const Center(
                            child: LoadingWidget(),
                          );
                        }

                        /*
                        *
                        *
                        * UnAuthenticated
                        *
                        *
                        * */
                        if (state is UnAuthenticatedToFetchSingleTaskDetails) {
                          return Center(
                            child: AppErrorWidget(
                              appTypeError: AppErrorType.unauthorizedUser,
                              onPressedRetry: () {
                                navigateToLogin(context);
                              },
                            ),
                          );
                        }

                        /*
                        *
                        *
                        * error
                        *
                        *
                        * */
                        if (state is ErrorWhileFetchingTaskDetails) {
                          return Center(
                            child: AppErrorWidget(
                              appTypeError: state.appError.appErrorType,
                              onPressedRetry: () {
                                navigateToLogin(context);
                              },
                            ),
                          );
                        }

                        /*
                        *
                        *
                        * success
                        *
                        *
                        * */
                        if (state is TaskFetchedSuccessfully) {
                          return TaskDetailsWidget(
                            applyForTaskCubit: applyForTaskCubit,
                            taskEntity: state.taskEntity!,
                            isAlreadyApplied:
                                widget.taskDetailsArguments.isAlreadyApplied,
                          );
                        }

                        /// else
                        return const SizedBox.shrink();
                      },
                    ),

              /// space
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToApplyForTask() {
    RouteHelper().applyForTask(
      context,
      applyForTaskArguments: ApplyForTaskArguments(
        taskEntity: _taskEntity,
        applyForTaskCubit: applyForTaskCubit,
      ),
    );
  }

  /// to fetch task details
  void _fetchTaskDetails() {
    _singleTaskDetailsCubit.tryToFetchTaskDetails(
      userToken: getUserToken(context),
      taskId: widget.taskDetailsArguments.taskId ?? -1,
    );
  }

  /// to navigate to applied tasks screen
  /// after a success process
  void _navigateToAppliedTaskScreen() {
    RouteHelper().appliedTasksScreen(context, isPushReplacement: true);
  }
}
