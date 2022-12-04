import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/screen_arguments/my_tasks_client_args.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/completed_client/my_completed_task_client.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/in_progress_cleint/my_tasks_inprogress_client.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/todo_client/my_tasks_todo_client.dart';
import 'package:yamaiter/presentation/logic/client_cubit/assign_task/assign_task_client_cubit.dart';

import '../../../../../../common/constants/sizes.dart';
import '../../../../../logic/client_cubit/end_task_client/end_task_client_cubit.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_content_title_widget.dart';
import '../../../../../widgets/tab_bar/tab_bar_widget.dart';
import '../../../../../widgets/tab_bar/tab_item.dart';
import 'in_review_client/my_tasks_inReview_client.dart';

class MyTasksScreenClient extends StatefulWidget {
  final MyTasksClientArguments arguments;

  const MyTasksScreenClient({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<MyTasksScreenClient> createState() => _MyTasksScreenClientState();
}

class _MyTasksScreenClientState extends State<MyTasksScreenClient>
    with SingleTickerProviderStateMixin {
  /// AssignTaskClientCubit
  late final AssignTaskClientCubit _assignTaskClientCubit;

  /// EndTaskClientCubit
  late final EndTaskClientCubit _endTaskClientCubit;

  /// TabController
  late final TabController _tabController;

  /// current tab selected index
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    //==> init _tabController
    _tabController = TabController(length: 4, vsync: this);

    //==> init _assignTaskClientCubit
    _assignTaskClientCubit = getItInstance<AssignTaskClientCubit>();

    //==> init _endTaskClientCubit
    _endTaskClientCubit = getItInstance<EndTaskClientCubit>();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _assignTaskClientCubit.close();
    _endTaskClientCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _assignTaskClientCubit),
        BlocProvider(create: (context) => _endTaskClientCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          /// listener on assign task to lawyer
          BlocListener<AssignTaskClientCubit, AssignTaskClientState>(
            listener: (context, state) {
              if (state is TaskClientAssignedSuccessfully) {
                setState(() {
                  currentIndex = 1; // to inProgress
                  _tabController.index = currentIndex;
                });
              }
            },
          ),

          /// listener on end task
          BlocListener<EndTaskClientCubit, EndTaskClientState>(
            listener: (context, state) {
              if (state is TaskClientEndedSuccessfully) {
                setState(() {
                  currentIndex = 3; // to completed
                  _tabController.index = currentIndex;
                });
              }
            },
          )
        ],
        child: Scaffold(
          /// appBar
          appBar: AppBar(
            title: const Text("طلباتى"),
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: Sizes.dimen_10.h, horizontal: Sizes.dimen_20.w),
                child: AppContentTitleWidget(
                  title: "طلباتى المعروضة على المحامين",
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
                    text: "طلباتى المعروضة",
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
                      MyTasksTodoClient(
                        assignTaskClientCubit: _assignTaskClientCubit,
                      ),

                      /// InProgress
                      const MyTasksInProgressClient(),

                      /// InReview
                      MyTasksInReviewClient(
                        endTaskClientCubit: _endTaskClientCubit,
                      ),

                      /// Completed
                      MyCompletedTasksClient(
                        endTaskClientCubit: _endTaskClientCubit,
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
