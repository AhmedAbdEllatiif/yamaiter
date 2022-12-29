import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_task_details_params.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/single_task/applicant_lawyers/list_of_applicant_lawyers.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_single_task/get_my_single_task_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';

import '../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../common/screen_utils/screen_util.dart';
import '../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../domain/entities/screen_arguments/delete_task_args.dart';
import '../../../../../../../domain/entities/screen_arguments/edit_task_args.dart';
import '../../../../../../../domain/entities/screen_arguments/payment_args.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../../../../logic/client_cubit/delete_task_client/delete_task_client_cubit.dart';
import '../../../../../../logic/cubit/delete_task/delete_task_cubit.dart';
import '../../../../../../logic/cubit/update_task/update_task_cubit.dart';
import '../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../widgets/app_error_widget.dart';
import '../../../../../../widgets/loading_widget.dart';
import '../../../../../../widgets/text_with_icon.dart';

class SingleTaskScreen extends StatefulWidget {
  final SingleTaskArguments singleTaskParams;

  const SingleTaskScreen({Key? key, required this.singleTaskParams})
      : super(key: key);

  @override
  State<SingleTaskScreen> createState() => _SingleTaskScreenState();
}

class _SingleTaskScreenState extends State<SingleTaskScreen> {
  late TaskEntity _taskEntity;

  /// GetMySingleTaskCubit
  late final GetMySingleTaskCubit _getMySingleTaskCubit;

  /// UpdateTaskCubit
  late final UpdateTaskCubit _updateTaskCubit;

  /// DeleteTaskCubit
  late final DeleteTaskCubit _deleteTaskCubit;

  /// AssignTaskCubit
  late final PaymentAssignTaskCubit _assignTaskCubit;

  @override
  void initState() {
    super.initState();
    _taskEntity = widget.singleTaskParams.taskEntity;
    _getMySingleTaskCubit = getItInstance<GetMySingleTaskCubit>();
    _assignTaskCubit = widget.singleTaskParams.assignTaskCubit;
    _updateTaskCubit = widget.singleTaskParams.updateTaskCubit;
    _deleteTaskCubit = widget.singleTaskParams.deleteTaskCubit;

    // fetch current task data
    _fetchMySingleTask();
  }

  @override
  void dispose() {
    _getMySingleTaskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getMySingleTaskCubit,
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title: const Text("تفاصيل المهمة"),
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                position: PopupMenuPosition.under,
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("تعديل المهمة"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("حذف المهمة"),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    //==> update Task
                    _navigateToEditTaskScreen(_taskEntity);
                  } else if (value == 1) {
                    //==> deleteTask
                    _navigateToDeleteTaskScreen(_taskEntity.id);
                  }
                }),
          ],
        ),

        /// body
        body: MultiBlocListener(
          listeners: [
            /// AssignTaskCubit
            BlocListener<PaymentAssignTaskCubit, PaymentToAssignTaskState>(
              bloc: _assignTaskCubit,
              listener: (_, state) {
                if (state is PaymentLinkToAssignTaskFetched) {
                  _navigateToPaymentScreen(
                    paymentLink: state.payEntity.link,
                  );
                }
              },
            ),

            /// DeleteTaskCubit
            BlocListener<DeleteTaskCubit, DeleteTaskState>(
              bloc: _deleteTaskCubit,
              listener: (_, state) {
                if (state is TaskClientDeletedSuccessfully) {
                  Navigator.pop(context);
                }
              },
            ),

            /// UpdateTaskCubit
            BlocListener<UpdateTaskCubit, UpdateTaskState>(
              bloc: _updateTaskCubit,
              listener: (_, state) {
                if (state is TaskUpdatedSuccessfully) {
                  _fetchMySingleTask();
                }
              },
            ),
          ],

          //==> BlocBuilder
          child: BlocBuilder<GetMySingleTaskCubit, GetMySingleTaskState>(
            builder: (context, state) {
              //==> loading
              if (state is LoadingGetMySingleTask) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> unAuthorized
              if (state is UnAuthorizedGetMySingleTask) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () => _navigateToLogin(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is NotActivatedGetMySingleTask) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    onPressedRetry: () => _navigateToContactUs(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is ErrorWhileGettingMySingleTask) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchMySingleTask(),
                  ),
                );
              }

              //==> fetched
              if (state is MySingleTaskFetchedSuccessfully) {
                log("TaskCommission: ${state.taskEntity.costCommission}");
                _taskEntity = state.taskEntity;
                return Padding(
                  padding: EdgeInsets.only(
                    left: AppUtils.mainPagesHorizontalPadding.w,
                    right: AppUtils.mainPagesHorizontalPadding.w,
                    top: Sizes.dimen_16.h,
                    bottom: 10.0,
                  ),
                  child: Column(
                    children: [
                      /// title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// title
                          AppContentTitleWidget(
                            title: _taskEntity.title,
                            textSpace: 1.3,
                          ),

                          /// date, court, applicants
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 3, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                /// court
                                Flexible(
                                  child: TextWithIconWidget(
                                    iconData: Icons.pin_drop_outlined,
                                    text: _taskEntity.governorates,
                                  ),
                                ),

                                SizedBox(width: Sizes.dimen_8.w),

                                /// date
                                Flexible(
                                  child: TextWithIconWidget(
                                    iconData: Icons.date_range_outlined,
                                    text: _taskEntity.startingDate,
                                  ),
                                ),

                                SizedBox(width: Sizes.dimen_8.w),

                                /// applicantsCount
                                TextWithIconWidget(
                                  iconData: Icons.person_outline_outlined,
                                  text: _taskEntity.applicantsCount.toString(),
                                ),
                              ],
                            ),
                          ),

                          //==> space
                          SizedBox(
                            height: Sizes.dimen_10.h,
                          ),

                          /// description
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: ScreenUtil.screenHeight * .25,
                            ),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                _taskEntity.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.black, height: 1.4),
                              ),
                            ),
                          ),

                          //==> space
                          SizedBox(
                            height: Sizes.dimen_10.h,
                          ),
                        ],
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListOfApplicantLawyers(
                            assignTaskCubit: _assignTaskCubit,
                            taskEntity: state.taskEntity,
                            applicants: state.taskEntity.applicantLawyers,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              //==> else
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  /// to navigate to payment screen
  void _navigateToPaymentScreen({
    required String paymentLink,
  }) async {
    await RouteHelper().paymentScreen(
      context,
      paymentArguments: PaymentArguments(link: paymentLink),
    );

    if (!mounted) return;

    /// Todo check for if task is assign successfully
    showSnackBar(context, message: "Todo check for if task is assign successfully");
  }

  /// To fetch my single task details
  void _fetchMySingleTask() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMySingleTaskCubit.fetchMySingleTask(
      userToken: userToken,
      taskId: widget.singleTaskParams.taskEntity.id,
    );
  }

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

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
