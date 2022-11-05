import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/status_screens/in_review/in_review_item.dart';

import '../../../../../../../../common/constants/sizes.dart';
import '../../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../../common/enum/task_status.dart';
import '../../../../../../../../di/git_it.dart';
import '../../../../../../../../domain/entities/data/task_entity.dart';
import '../../../../../../../../router/route_helper.dart';
import '../../../../../../../logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';
import '../../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../../themes/theme_color.dart';
import '../../../../../../../widgets/app_error_widget.dart';
import '../../../../../../../widgets/loading_widget.dart';
import '../loading_more_my_tasks.dart';

class MyTasksInReview extends StatefulWidget {
  const MyTasksInReview({Key? key}) : super(key: key);

  @override
  State<MyTasksInReview> createState() => _MyTasksInReviewState();
}

class _MyTasksInReviewState extends State<MyTasksInReview>
    with AutomaticKeepAliveClientMixin {
  /// tasks list
  final List<TaskEntity> taskList = [];

  /// ScrollController
  late final ScrollController _controller;

  /// GetMyTasksCubit
  late final GetMyTasksCubit _getMyTasksCubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getMyTasksCubit = getItInstance<GetMyTasksCubit>();
    _fetchInReviewTasksList();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _getMyTasksCubit.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getMyTasksCubit),
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
                onPressedRetry: () => _fetchInReviewTasksList(),
              ),
            );
          }

          //==> empty
          if (state is EmptyMyTasksList) {
            return Center(
              child: Text(
                "ليس لديك مهمات قيد المراجعة",
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
                return InReviewItem(
                  taskEntity: taskList[index],
                );
              }

              /// loading or end of list
              return LoadingMoreMyTasksWidget(
                myTasksCubit: _getMyTasksCubit,
              );
            },
          );
        },
      ),
    );
  }



  /// to fetch my tasks list
  void _fetchInReviewTasksList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyTasksCubit.fetchMyTasksList(
      userToken: userToken,
      taskType: TaskType.inreview,
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
          _fetchInReviewTasksList();
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
