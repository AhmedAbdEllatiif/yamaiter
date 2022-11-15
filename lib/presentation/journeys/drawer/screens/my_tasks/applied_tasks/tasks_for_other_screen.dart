import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/status_screens/in_progress/my_tasks_in_progress.dart';
import 'package:yamaiter/presentation/logic/cubit/end_task/end_task_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../../../common/constants/sizes.dart';
import '../../../../../logic/cubit/assign_task/assign_task_cubit.dart';
import '../../../../../widgets/app_content_title_widget.dart';
import '../../../../../widgets/tab_bar/tab_bar_widget.dart';
import '../../../../../widgets/tab_bar/tab_item.dart';
import 'status_screens/todo/todo_applied_task.dart';

class TasksForOtherScreen extends StatefulWidget {
  const TasksForOtherScreen({Key? key}) : super(key: key);

  @override
  State<TasksForOtherScreen> createState() => _TasksForOtherScreenState();
}

class _TasksForOtherScreenState extends State<TasksForOtherScreen>
    with SingleTickerProviderStateMixin {
  /// TabController
  late final TabController _tabController;

  /// current tab selected index
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /*providers:  [
        BlocProvider(create: (context) {}),
        //BlocProvider(create: (context) => _endTaskCubit),
      ],*/
      child: Container(
        /* listeners: [
          /// listener on assign task to lawyer
          BlocListener<AssignTaskCubit, AssignTaskState>(
            listener: (context, state) {
              if (state is TaskAssignedSuccessfully) {
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
        ],*/
        child: Scaffold(
          /// appBar
          appBar: AppBar(
            title: const Text("مهامى لحساب الغير"),
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: Sizes.dimen_10.h, horizontal: Sizes.dimen_20.w),
                child: AppContentTitleWidget(
                  title: "مهامى لحساب الغير",
                  textStyle: Theme.of(context).textTheme.headline5,
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
                    text: "مهامى لحساب الغير",
                    textStyle: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.white, fontWeight: FontWeight.bold),
                  ),
                  TabItem(
                    text: "قيد التنفيذ",
                    textStyle: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.white, fontWeight: FontWeight.bold),
                  ),
                  TabItem(
                    text: "قيد المراجعة",
                    textStyle: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.white, fontWeight: FontWeight.bold),
                  ),
                  TabItem(
                    text: "مكتملة",
                    textStyle: Theme.of(context).textTheme.caption!.copyWith(
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
                      AppliedTaskTodo(
                        assignTaskCubit: getItInstance<AssignTaskCubit>(),
                      ),

                      /// InProgress
                      const MyTasksInProgress(),

                      /// InReview
                      Container(),

                      /// Completed
                      Container()
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
