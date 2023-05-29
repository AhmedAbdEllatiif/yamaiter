import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_authoried_user.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/screen_arguments/my_task_args.dart';
import 'package:yamaiter/presentation/logic/cubit/end_task/end_task_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../../../common/constants/sizes.dart';
import '../../../../common/enum/task_status.dart';
import '../../../logic/cubit/assign_task/assign_task_cubit.dart';
import '../../../widgets/app_content_title_widget.dart';
import '../../../widgets/tab_bar/tab_bar_widget.dart';
import '../../../widgets/tab_bar/tab_item.dart';
import 'status_screens/completed/posted_completed_tasks.dart';
import 'status_screens/in_progress/posted_in_progress_tasks.dart';
import 'status_screens/in_review/posted_in_review_tasks.dart';
import 'status_screens/todo/posted_todo_tasks.dart';

class MyTasksScreen extends StatefulWidget {
  final MyTasksArguments myTasksArguments;

  const MyTasksScreen({Key? key, required this.myTasksArguments})
      : super(key: key);

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen>
    with SingleTickerProviderStateMixin {
  /// TabController
  late final TabController _tabController;

  /// current tab selected index
  int currentIndex = 0;

  /// AssignTaskCubit
  late final PaymentAssignTaskCubit _assignTaskCubit;

  /// EndTaskCubit
  late final EndTaskCubit _endTaskCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _assignTaskCubit = getItInstance<PaymentAssignTaskCubit>();
    _endTaskCubit = getItInstance<EndTaskCubit>();
    switch (widget.myTasksArguments.taskType) {
      case TaskType.todo:
        _tabController.index = 0;
        break;
      case TaskType.inprogress:
        _tabController.index = 1;
        break;
      case TaskType.inreview:
        _tabController.index = 2;
        break;
      case TaskType.completed:
        _tabController.index = 3;
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _assignTaskCubit.close();
    _endTaskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _assignTaskCubit),
        BlocProvider(create: (context) => _endTaskCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          /// listener on assign task to lawyer
          BlocListener<PaymentAssignTaskCubit, PaymentToAssignTaskState>(
            listener: (context, state) {
              /// move to inProgress
              if (state is PaymentLinkToAssignTaskFetched ||
                  state is TaskAssignedSuccessfullyWithWallet) {
                setState(() {
                  currentIndex = 1;
                  _tabController.index = currentIndex;
                });
              }
            },
          ),

          /// listener on end task
          BlocListener<EndTaskCubit, EndTaskState>(
            listener: (context, state) {
              if (state is TaskEndedSuccessfully) {
                setState(() {
                  currentIndex = 3;
                  _tabController.index = currentIndex;
                });
              }
            },
          )
        ],
        child: Scaffold(
          /// appBar
          appBar: AppBar(
            title: Text(isCurrentUserLawyer(context)
                ? "طلباتى"
                : "طلباتي المعروضة على المحامين "),
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: Sizes.dimen_10.h, horizontal: Sizes.dimen_20.w),
                child: AppContentTitleWidget(
                  title: isCurrentUserLawyer(context)
                      ? "طلباتى"
                      : "طلباتي المعروضة على المحامين ",
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                ),
              ),

              ///TabBar widget
              TabBarWidget(
                currentSelectedIndex: currentIndex,
                tabController: _tabController,
                onTabPressed: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                tabs: [
                  TabItem(
                    text: isCurrentUserLawyer(context)
                        ? "طلباتى"
                        : "طلباتي المعروضة على المحامين ",
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.white, fontWeight: FontWeight.bold),
                  ),
                  TabItem(
                    text: "قيد التنفيذ",
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.white, fontWeight: FontWeight.bold),
                  ),
                  TabItem(
                    text: "قيد المراجعة",
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.white, fontWeight: FontWeight.bold),
                  ),
                  TabItem(
                    text: "مكتملة",
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          //fontSize: Sizes.dimen_10.sp,
                        ),
                  ),
                ],
              ),

              /// TabBarView
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Sizes.dimen_10.h, left: 8.0, right: 8.0),
                  child: TabBarView(
                    //physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      /// MyTodo
                      PostedTodoTasks(
                        assignTaskCubit: _assignTaskCubit,
                      ),

                      /// InProgress
                      const PostedInProgressTasks(),

                      /// InReview
                      PostedInReviewTasks(
                        endTaskCubit: _endTaskCubit,
                      ),

                      /// Completed
                      PostedCompletedTasks(
                        endTaskCubit: _endTaskCubit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
