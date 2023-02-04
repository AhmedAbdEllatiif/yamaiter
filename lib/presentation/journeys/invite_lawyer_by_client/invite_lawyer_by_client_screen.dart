import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/task_status.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/journeys/invite_lawyer_by_client/my_tasks_drop_down_client.dart';
import 'package:yamaiter/presentation/logic/cubit/create_task/create_task_cubit.dart';

import 'package:yamaiter/presentation/logic/cubit/invite_lawyer/invite_lawyer_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../domain/entities/data/task_entity.dart';
import '../../../domain/entities/screen_arguments/create_task_args.dart';
import '../../../domain/entities/screen_arguments/invite_lawyer_args.dart';
import '../../logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/app_error_widget.dart';

class InviteLawyerByClientScreen extends StatefulWidget {
  final InviteLawyerArguments inviteLawyerArguments;

  const InviteLawyerByClientScreen({
    Key? key,
    required this.inviteLawyerArguments,
  }) : super(key: key);

  @override
  State<InviteLawyerByClientScreen> createState() =>
      _InviteLawyerByClientScreenState();
}

class _InviteLawyerByClientScreenState
    extends State<InviteLawyerByClientScreen> {
  late final GetMyTasksCubit _getMyTasksCubit;
  late final CreateTaskCubit _createTaskCubit;
  late final InviteLawyerCubit _inviteLawyerCubit;

  TaskEntity? chosenTask;

  String? errorText;

  @override
  void initState() {
    super.initState();
    _getMyTasksCubit = getItInstance<GetMyTasksCubit>();
    _createTaskCubit = getItInstance<CreateTaskCubit>();
    _inviteLawyerCubit = getItInstance<InviteLawyerCubit>();

    _fetchMyTaskTitle();
  }

  @override
  void dispose() {
    _getMyTasksCubit.close();
    _createTaskCubit.close();
    _inviteLawyerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getMyTasksCubit),
        BlocProvider(create: (context) => _createTaskCubit),
        BlocProvider(create: (context) => _inviteLawyerCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: MultiBlocListener(
          listeners: [
            /// listener on CreateTaskCubit
            BlocListener<CreateTaskCubit, CreateTaskState>(
              listener: (context, state) {
                if (state is TaskCreatedSuccessfully) {
                  _fetchMyTaskTitle();
                }
              },
            ),

            /// listener on InviteLawyerCubit
            BlocListener<InviteLawyerCubit, InviteLawyerState>(
              listener: (context, state) {
                if (state is InviteLawyerSendSuccessfully) {
                  _navigateToMyTaskScreen();
                }
              },
            ),
          ],
          child: Container(
            padding: EdgeInsets.only(
              top: ScreenUtil.screenHeight * 0.10,
              right: AppUtils.mainPagesHorizontalPadding.w,
              left: AppUtils.mainPagesHorizontalPadding.w,
            ),
            child: BlocBuilder<GetMyTasksCubit, GetMyTasksState>(
              builder: (context, state) {
                return Column(
                  children: [
                    /// title
                    Text(
                      "دعوة لتنفيذ مهمة",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColor.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    /// space
                    if (state is MyTasksListFetchedSuccessfully)
                      if (state.taskEntityList.isNotEmpty)
                        SizedBox(
                          height: Sizes.dimen_10.h,
                        ),

                    ///  dropDown
                    MyTasksDropDownClient(
                      getMyTasksCubit: _getMyTasksCubit,
                      errorText: errorText,
                      onChanged: (value) {
                        if (value != null) {
                          chosenTask = value;
                          _showOrHideError(false);
                        }
                      },
                    ),

                    /// space
                    SizedBox(
                      height: Sizes.dimen_10.h,
                    ),

                    /// builder from InviteLawyerCubit
                    BlocBuilder<InviteLawyerCubit, InviteLawyerState>(
                      builder: (context, state) {
                        /// loading
                        if (state is LoadingInviteLawyer) {
                          return const LoadingWidget();
                        }

                        /// UnAuthorized
                        if (state is UnAuthorizedInviteLawyer) {
                          return Center(
                            child: AppErrorWidget(
                              appTypeError: AppErrorType.unauthorizedUser,
                              buttonText: "تسجيل الدخول",
                              onPressedRetry: () {
                                _navigateToLogin();
                              },
                            ),
                          );
                        }

                        /// NotActivatedUser
                        if (state is NotActivatedUserToInviteLawyer) {
                          return Center(
                            child: AppErrorWidget(
                              appTypeError: AppErrorType.notActivatedUser,
                              buttonText: "تواصل معنا",
                              message:
                                  "نأسف لذلك، لم يتم تفعيل حسابك سوف تصلك رسالة بريدية عند التفعيل",
                              onPressedRetry: () {
                                _navigateToContactUs();
                              },
                            ),
                          );
                        }

                        /// add task text button
                        return Column(
                          children: [
                            AppButton(
                              text: "اضف مهمة جديدة من هنا",
                              isTextButton: true,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              onPressed: () => _navigateToCreateTaskClient(),
                            ),

                            /// space
                            SizedBox(
                              height: Sizes.dimen_10.h,
                            ),

                            /// send invitation
                            AppButton(
                              text: "ارسال الدعوة",
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      AppUtils.mainPagesHorizontalPadding.w),
                              color: AppColor.accentColor,
                              textColor: AppColor.white,
                              onPressed: () {
                                if (_validate()) {
                                  _inviteLawyerToTask();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _validate() {
    if (chosenTask != null) return true;
    _showOrHideError(true);
    return false;
  }

  /// to hide to show error text
  void _showOrHideError(bool isShow) {
    setState(() {
      errorText = isShow ? "اختر مهمة من المهام" : null;
    });
  }

  /// to fetch tasks titles only
  void _fetchMyTaskTitle() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyTasksCubit.fetchMyTasksList(
        userToken: userToken,
        taskType: TaskType.todo,
        currentListLength: 0,
        fetchOnlyNames: true);
  }

  /// to navigate to create task client screen
  void _navigateToCreateTaskClient() {
    RouteHelper().createTask(context,
        createTaskArguments: CreateTaskArguments(
          createTaskCubit: _createTaskCubit,
          goBackAfterSuccess: true,
        ));
  }

  void _inviteLawyerToTask() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init lawyer id
    final lawyerId = widget.inviteLawyerArguments.lawyerId;

    // init task id
    final taskId = chosenTask != null ? chosenTask!.id : -1;

    log("TaskId: $taskId, lawyerId: $lawyerId");

    _inviteLawyerCubit.inviteLawyer(
      userToken: userToken,
      taskId: taskId,
      lawyerId: lawyerId,
    );
  }

  /// navigate to my tasks screen
  void _navigateToMyTaskScreen() {
    RouteHelper().myTasks(context, isPushNamedAndRemoveUntil: true);
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
