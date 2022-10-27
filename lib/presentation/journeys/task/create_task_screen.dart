import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/task/task_form.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("نشر مهمة عمل"),
      ),
      body: Column(
        children: [
          const AdsWidget(),

          //==> Task form
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppUtils.mainPagesHorizontalPadding.w,
              //vertical: AppUtils.mainPagesVerticalPadding.h,
            ),
            child: TaskForm(
              onSuccess: () {
                //RouteHelper().myTaskScreen(context, isReplacement: true);
              },
            ),
          )),
        ],
      ),
    );
  }
}
