import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/screen_arguments/apply_for_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/invite_task_details_args.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/invited_tasks/invited_task_item.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';
import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../../di/git_it.dart';
import '../../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../../router/route_helper.dart';
import '../../../../../../common/constants/app_utils.dart';
import '../../../../../logic/cubit/apply_for_task/apply_for_task_cubit.dart';
import '../../../../../logic/cubit/get_invited_tasks/get_invited_task_cubit.dart';
import '../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_error_widget.dart';
import '../../../../../widgets/app_refersh_indicator.dart';
import '../../../../../widgets/loading_widget.dart';
import 'loading_more_invited_tasks.dart';

class InvitedTasksScreen extends StatefulWidget {
  const InvitedTasksScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InvitedTasksScreen> createState() => _InvitedTasksScreenState();
}

class _InvitedTasksScreenState extends State<InvitedTasksScreen> {
  /// my_tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetMyTasksCubit
  late final GetInvitedTasksCubit _getInvitedTasks;

  /// ApplyForTaskCubit
  late final ApplyForTaskCubit _applyForTaskCubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getInvitedTasks = getItInstance<GetInvitedTasksCubit>();
    _applyForTaskCubit = getItInstance<ApplyForTaskCubit>();
    _fetchInvitedTasksList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getInvitedTasks.close();
    _applyForTaskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getInvitedTasks),
        BlocProvider(create: (context) => _applyForTaskCubit),
      ],
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title: const Text("عروض مقدمة"),
        ),

        /// body
        body: BlocListener<ApplyForTaskCubit, ApplyForTaskState>(
          listener: (context, state) {
            if (state is AppliedForTaskSuccessfully) {
              taskList.clear();
              _fetchInvitedTasksList();
              _navigateToAppliedTaskScreen();
            }
          },
          child: BlocConsumer<GetInvitedTasksCubit, GetInvitedTasksState>(
            listener: (_, state) {
              //==> MyTasksListFetchedSuccessfully
              if (state is InvitedTasksListFetchedSuccessfully) {
                taskList.addAll(state.taskEntityList);
              }
              //==> lastPageFetched
              if (state is LastPageInvitedTasksListFetched) {
                taskList.addAll(state.taskEntityList);
              }
            },
            builder: (context, state) {
              //==> loading
              if (state is LoadingMoreInvitedTasksList) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> unAuthorized
              if (state is UnAuthorizedGetInvitedTasksList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () => _navigateToLogin(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is NotActivatedUserToGetInvitedTasksList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    onPressedRetry: () => _navigateToContactUs(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is ErrorWhileGettingInvitedTasksList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchInvitedTasksList(),
                  ),
                );
              }

              //==> empty
              if (state is EmptyInvitedTasksList) {
                return Center(
                  child: Text(
                    "ليس لديك عروض مقدمة",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.primaryDarkColor,
                        ),
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppUtils.mainPagesHorizontalPadding.w,
                    vertical: AppUtils.mainPagesVerticalPadding.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppContentTitleWidget(
                        title: "عروض مقدمة من الغير",
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),

                    /// space
                    SizedBox(
                      height: Sizes.dimen_10.h,
                    ),

                    /// list
                    Expanded(
                      child: AppRefreshIndicator(
                        onRefresh: () async {
                          taskList.clear();
                          _fetchInvitedTasksList();
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
                              return InvitedTaskItem(
                                taskEntity: taskList[index],

                                //==> onApplyForTaskPressed
                                onApplyForTaskPressed: () {
                                  _navigateToApplyForTaskScreen(
                                    taskEntity: taskList[index],
                                  );
                                },

                                //==> onShowMorePressed
                                onShowMorePressed: () {
                                  _navigateToInviteTaskDetails(
                                    taskEntity: taskList[index],
                                  );
                                },
                              );
                            }

                            /// loading or end of list
                            return LoadingMoreInvitedWidget(
                              invitedTasksCubit: _getInvitedTasks,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// to fetch my my_tasks list
  void _fetchInvitedTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getInvitedTasks.fetchInvitedTasksList(
      userToken: userToken,
      currentListLength: taskList.length,
      offset: taskList.length,
    );
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);

  /// to navigate to applied tasks screen
  /// after a success process
  void _navigateToAppliedTaskScreen() {
    RouteHelper().appliedTasksScreen(context, isPushReplacement: true);
  }

  /// to navigate to ApplyForTaskScreen
  void _navigateToApplyForTaskScreen({required TaskEntity taskEntity}) {
    RouteHelper().applyForTask(
      context,
      applyForTaskArguments: ApplyForTaskArguments(
        taskEntity: taskEntity,
        applyForTaskCubit: _applyForTaskCubit,
      ),
    );
  }

  /// to navigate to invite task details
  void _navigateToInviteTaskDetails({required TaskEntity taskEntity}) {
    RouteHelper().inviteTaskDetails(
      context,
      invitedTaskDetailsArguments: InvitedTaskDetailsArguments(
        taskEntity: taskEntity,
        applyForTaskCubit: _applyForTaskCubit,
      ),
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getInvitedTasks.state is! LastPageInvitedTasksListFetched) {
          _fetchInvitedTasksList();
        }
      }
    });
  }
}
