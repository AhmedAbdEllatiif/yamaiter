import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/status_screens/my_tasks_completed.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/status_screens/my_tasks_in_progress.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/status_screens/my_tasks_in_review.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/status_screens/my_tasks_todo.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../../../common/constants/sizes.dart';
import '../../../../../../common/screen_utils/screen_util.dart';
import '../../../../../widgets/app_content_title_widget.dart';
import '../../../../../widgets/tab_bar/tab_bar_widget.dart';
import '../../../../../widgets/tab_bar/tab_item.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({Key? key}) : super(key: key);

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen>
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
    return Scaffold(
      /// appBar
      appBar: AppBar(
        title: const Text("طلباتى من الغير"),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// title
          Container(
            margin: EdgeInsets.symmetric(
                vertical: Sizes.dimen_10.h, horizontal: Sizes.dimen_20.w),
            child: AppContentTitleWidget(
              title: "طلباتى من الغير",
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
                text: "طلباتى من الغير",
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
                text: "مهام مكتملة",
                textStyle: Theme.of(context).textTheme.caption!.copyWith(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.dimen_10.sp,
                    ),
              ),
            ],
          ),

          /// TabBarView
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(top: Sizes.dimen_10.h, left: 8.0, right: 8.0),
              child: TabBarView(
                //physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: const [
                  /// MyTodo
                  MyTasksTodo(),

                  /// InProgress
                  MyTasksInProgress(),

                  /// InReview
                  MyTasksInReview(),

                  /// Completed
                  MyTasksCompleted(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
