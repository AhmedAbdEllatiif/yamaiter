import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/loading_more_my_tasks_client.dart';
import 'package:yamaiter/presentation/logic/client_cubit/get_my_tasks_client/get_my_tasks_client_cubit.dart';

import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../common/enum/task_status.dart';
import '../../../../../../../di/git_it.dart';
import '../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../themes/theme_color.dart';
import '../../../../../../widgets/app_error_widget.dart';
import '../../../../../../widgets/app_refersh_indicator.dart';
import '../../../../../../widgets/loading_widget.dart';
import 'in_progress_item_client.dart';

class MyTasksInProgressClient extends StatefulWidget {
  const MyTasksInProgressClient({Key? key}) : super(key: key);

  @override
  State<MyTasksInProgressClient> createState() =>
      _MyTasksInProgressClientState();
}

class _MyTasksInProgressClientState extends State<MyTasksInProgressClient>
    with AutomaticKeepAliveClientMixin {
  /// my_tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetMyTasksCubit
  late final GetMyTasksClientCubit _getMyTasksClientCubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getMyTasksClientCubit = getItInstance<GetMyTasksClientCubit>();
    _fetchInProgressTasksList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getMyTasksClientCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getMyTasksClientCubit),
      ],
      child: BlocConsumer<GetMyTasksClientCubit, GetMyTasksClientState>(
        listener: (_, state) {
          //==> MyTasksListFetchedSuccessfully
          if (state is MyTasksClientListFetchedSuccessfully) {
            taskList.addAll(state.taskEntityList);
          }
          //==> lastPageFetched
          if (state is LastPageMyTasksClientListFetched) {
            taskList.addAll(state.taskEntityList);
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
                onPressedRetry: () => _fetchInProgressTasksList(),
              ),
            );
          }

          //==> empty
          if (state is EmptyMyTasksClientList) {
            return Center(
              child: Text(
                "ليس لديك طلبات قيد التنفيذ",
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
                  return InProgressTaskItemClient(
                    taskEntity: taskList[index],
                  );
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
    );
  }

  /// to fetch my my_tasks list
  void _fetchInProgressTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyTasksClientCubit.fetchMyTasksClientList(
      userToken: userToken,
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
        if (_getMyTasksClientCubit.state is! LastPageMyTasksClientListFetched) {
          _fetchInProgressTasksList();
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
