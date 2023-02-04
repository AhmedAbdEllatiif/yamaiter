import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../domain/entities/screen_arguments/create_tax_args.dart';
import 'choose_to_add_item.dart';

class ChooseToAddScreenClientUser extends StatelessWidget {
  const ChooseToAddScreenClientUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            /// first row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //==> request help
                ChooseToAddItem(
                  image: AssetsImages.documentsSvg,
                  text: "طلب مساعدة قانونية بحضور محامى",
                  onPressed: () => _navigateToCreateTaskClient(context),
                ),
                SizedBox(width: Sizes.dimen_5.w),

                //==> request consultation services
                ChooseToAddItem(
                  image: AssetsImages.newsPaperSvg,
                  text: "استشارة قانونية فورية",
                  onPressed: () => _navigateToRequestAConsultation(context),
                ),
              ],
            ),

            /// row space
            SizedBox(height: Sizes.dimen_5.h),

            /// second row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //==> request an ad
                ChooseToAddItem(
                  image: AssetsImages.publishAdSvg,
                  text: "انشاظ اعلان دعائى",
                  onPressed: () => _navigateCreateAdScreen(context),
                ),
              ],
            ),

            /// row space
            SizedBox(height: Sizes.dimen_5.h),
          ],
        ),
      ),
    );
  }

  /// to navigate to create task client
  void _navigateToCreateTaskClient(BuildContext context) =>
      RouteHelper().createTask(context, createTaskArguments: null);

  /// to navigate to request a consultation
  void _navigateToRequestAConsultation(BuildContext context) =>
      RouteHelper().requestAConsultation(context);

  /// to navigate to article
  void _navigateToCreateArticle(BuildContext context) =>
      RouteHelper().createArticleScreen(context);

  /// to navigate to create ad
  void _navigateCreateAdScreen(BuildContext context) =>
      RouteHelper().createAdScreen(context);
}
