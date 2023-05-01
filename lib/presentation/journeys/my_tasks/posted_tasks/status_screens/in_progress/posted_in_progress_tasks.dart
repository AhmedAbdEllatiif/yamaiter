import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/payment_mission_type.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/domain/entities/screen_arguments/refund_args.dart';
import 'package:yamaiter/presentation/logic/common/refund_payment/refund_payment_cubit.dart';

import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../../common/enum/task_status.dart';
import '../../../../../../../../di/git_it_instance.dart';
import '../../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../../router/route_helper.dart';
import '../../../../../logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_error_widget.dart';
import '../../../../../widgets/app_refersh_indicator.dart';
import '../../../../../widgets/loading_widget.dart';
import '../loading_more_my_tasks.dart';
import 'in_progress_item.dart';

class PostedInProgressTasks extends StatefulWidget {
  const PostedInProgressTasks({Key? key}) : super(key: key);

  @override
  State<PostedInProgressTasks> createState() => _PostedInProgressTasksState();
}

class _PostedInProgressTasksState extends State<PostedInProgressTasks>
    with AutomaticKeepAliveClientMixin {
  /// posted_tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetMyTasksCubit
  late final GetMyTasksCubit _getMyTasksCubit;

  /// RefundPaymentCubit
  late final RefundPaymentCubit _refundPaymentCubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getMyTasksCubit = getItInstance<GetMyTasksCubit>();
    _refundPaymentCubit = getItInstance<RefundPaymentCubit>();
    _fetchInProgressTasksList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getMyTasksCubit.close();
    _refundPaymentCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getMyTasksCubit),
        BlocProvider(create: (context) => _refundPaymentCubit),
      ],
      child: BlocListener<RefundPaymentCubit, RefundPaymentState>(
        listener: (context, state) {
          if (state is RefundSuccess) {
            taskList.clear();
            _fetchInProgressTasksList();
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
                  onPressedRetry: () => _fetchInProgressTasksList(),
                ),
              );
            }

            //==> empty
            if (state is EmptyMyTasksList) {
              return Center(
                child: Text(
                  "ليس لديك مهمات قيد التنفيذ",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.primaryDarkColor,
                      ),
                ),
              );
            }

            return AppRefreshIndicator(
              onRefresh: () async {
                taskList.clear();
                _fetchInProgressTasksList();
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
                    return InProgressTaskItem(
                      taskEntity: taskList[index],
                      onDeletePressed: () {
                        _navigateToRefundScreen(
                          taskId: taskList[index].id,
                          refundFees: taskList[index].refundCommission,
                        );
                      },
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

  /// to fetch my posted_tasks list
  void _fetchInProgressTasksList() {
    _getMyTasksCubit.fetchMyTasksList(
      userToken: getUserToken(context),
      taskType: TaskType.inprogress,
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
          _fetchInProgressTasksList();
        }
      }
    });
  }

  /// to navigate to refund screen
  void _navigateToRefundScreen({
    required int taskId,
    required String refundFees,
  }) {
    // to reset before start new refund
    _refundPaymentCubit.reset();

    // init args
    final refundArguments = RefundArguments(
      refundPaymentCubit: _refundPaymentCubit,
      paymentMissionType: PaymentMissionType.task,
      missionId: taskId,
      refundFees: refundFees,
    );

    // navigate
    RouteHelper().refundScreen(
      context,
      refundArguments: refundArguments,
    );
  }

  @override
  bool get wantKeepAlive => false;
}
