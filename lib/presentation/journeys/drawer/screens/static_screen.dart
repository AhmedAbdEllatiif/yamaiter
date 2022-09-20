import 'package:flutter/material.dart';
import 'package:yamaiter/common/enum/static_screens.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/data/data_source/static_data_sources.dart';
import 'package:yamaiter/data/models/static_models/static_screens_model.dart';

import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_logo.dart';
import 'package:yamaiter/presentation/widgets/custom_app_bar.dart';
import 'package:yamaiter/presentation/widgets/static_pages_content_widget.dart';
import 'package:yamaiter/presentation/widgets/static_pages_title_widget.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/screen_utils/screen_util.dart';

class StaticScreen extends StatelessWidget {
  final StaticScreenType staticScreenType;
  late final StaticScreensModel screenModel;

  StaticScreen({Key? key, required this.staticScreenType}) : super(key: key) {
    screenModel = buildScreenModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// appBar
        appBar: CustomAppBar(context),

        /// body
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_12.h, horizontal: Sizes.dimen_12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==> title
              StaticPageTitleWidget(
                title: screenModel.title,
              ),

              //==> space
              SizedBox(height: Sizes.dimen_8.h),

              //==> Card with text
              StaticPageContentWidget(
                child: Text(
                  screenModel.content,
                  overflow: TextOverflow.clip,
                  //maxLines: 500,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.primaryDarkColor,
                      ),
                ),
              ),
            ],
          ),
        ));
  }

  /// return the required model according to [StaticScreenType]
  StaticScreensModel buildScreenModel() =>
      StaticDataSources(staticScreenType: staticScreenType).getScreenModel();
}
