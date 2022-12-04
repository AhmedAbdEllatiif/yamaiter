import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/loading_more_my_tasks_client.dart';

import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../common/enum/task_status.dart';
import '../../../../../../../di/git_it.dart';
import '../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../../../../logic/client_cubit/end_task_client/end_task_client_cubit.dart';
import '../../../../../../logic/client_cubit/get_my_tasks_client/get_my_tasks_client_cubit.dart';
import '../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../themes/theme_color.dart';
import '../../../../../../widgets/app_error_widget.dart';
import '../../../../../../widgets/app_refersh_indicator.dart';
import '../../../../../../widgets/loading_widget.dart';
import 'completed_task_item_client.dart';

class MyCompletedTasksClient extends StatefulWidget {
  final EndTaskClientCubit endTaskClientCubit;

  const MyCompletedTasksClient({
    Key? key,
    required this.endTaskClientCubit,
  }) : super(key: key);

  @override
  State<MyCompletedTasksClient> createState() => _MyCompletedTasksClientState();
}

class _MyCompletedTasksClientState extends State<MyCompletedTasksClient>
    with AutomaticKeepAliveClientMixin {
  /// my_tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetMyTasksClientCubit
  late final GetMyTasksClientCubit _getMyTasksClientCubit;

  /// EndTaskClientCubit
  late final EndTaskClientCubit _endTaskClientCubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getMyTasksClientCubit = getItInstance<GetMyTasksClientCubit>();
    _endTaskClientCubit = widget.endTaskClientCubit;
    _fetchCompletedTasksList();
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
      child: BlocListener<EndTaskClientCubit, EndTaskClientState>(
        bloc: _endTaskClientCubit,
        listener: (context, state) {
          /// to refresh the list after the task is ended
          if (state is TaskClientEndedSuccessfully) {
            _fetchCompletedTasksList();
          }
        },
        child: BlocConsumer<GetMyTasksClientCubit, GetMyTasksClientState>(
          listener: (_, state) {
            //==> MyTasksClientListFetchedSuccessfully
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
                  onPressedRetry: () => _fetchCompletedTasksList(),
                ),
              );
            }

            //==> empty
            if (state is EmptyMyTasksClientList) {
              return Center(
                child: Text(
                  "ليس لديك طلبات مكتملة",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.primaryDarkColor,
                      ),
                ),
              );
            }

            return AppRefreshIndicator(
              onRefresh: () async {
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
                    return CompletedTaskItemClient(
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
      ),
    );
  }

  /// to fetch my my_tasks list
  void _fetchCompletedTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyTasksClientCubit.fetchMyTasksClientList(
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
        if (_getMyTasksClientCubit.state is! LastPageMyTasksClientListFetched) {
          _fetchCompletedTasksList();
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
