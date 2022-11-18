import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/choose_tasks/choose_my_task_type_item.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';

import '../../../../../../common/constants/assets_constants.dart';
import '../../../../../../common/constants/sizes.dart';
import '../../../../../../router/route_helper.dart';

class ChooseTasksScreen extends StatefulWidget {
  const ChooseTasksScreen({Key? key}) : super(key: key);

  @override
  State<ChooseTasksScreen> createState() => _ChooseTasksScreenState();
}

class _ChooseTasksScreenState extends State<ChooseTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appBar
      appBar: AppBar(
        title: const Text("مهامى"),
      ),

      body: Container(
        margin: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.12),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
            child: Column(
              children: [
                /// title
                Container(
                  margin: EdgeInsets.only(bottom: Sizes.dimen_16.h),
                  child: AppContentTitleWidget(
                    title: "مهامى",
                    textStyle: Theme.of(context).textTheme.headline5,
                  ),
                ),

                /// first row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //==> my tasks
                    ChooseMyTasksTypeItem(
                      image: AssetsImages.documentsSvg,
                      text: "طلباتى من الغير",
                      onPressed: () => _navigateMyTaxesScreen(context),
                    ),
                    SizedBox(width: Sizes.dimen_5.w),

                    //==> tasks for others
                    ChooseMyTasksTypeItem(
                      image: AssetsImages.documentsSvg,
                      text: "مهام لحساب الغير",
                      onPressed: () => _navigateTasksForOtherScreen(context),
                    ),
                  ],
                ),

                /// row space
                SizedBox(height: Sizes.dimen_5.h),

                /// second row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //==> invitations
                    ChooseMyTasksTypeItem(
                      image: AssetsImages.newsPaperSvg,
                      text: "عروض الوظائف",
                      onPressed: () => _navigateInvitedTasksScreen(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// to navigate to MyTaskFromOther
  void _navigateMyTaxesScreen(BuildContext context) =>
      RouteHelper().myTasks(context, isReplacement: false);

  /// to navigate to TasksForOtherScreen
  void _navigateTasksForOtherScreen(BuildContext context) =>
      RouteHelper().appliedTasksScreen(context);

  /// to navigate to InvitedTasksScreen
  void _navigateInvitedTasksScreen(BuildContext context) =>
      RouteHelper().invitedTasksScreen(context);
}
