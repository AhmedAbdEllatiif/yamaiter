import 'package:flutter/material.dart';
import 'package:yamaiter/common/enum/static_screens.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/data/data_source/static_data_sources.dart';
import 'package:yamaiter/data/models/static_models/static_screens_model.dart';

import 'package:yamaiter/presentation/themes/theme_color.dart';

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
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_12.h, horizontal: Sizes.dimen_12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // title
          Text(
          screenModel.title,
          style: Theme
              .of(context)
              .textTheme
              .titleMedium!
              .copyWith(
              color: AppColor.primaryDarkColor,
              fontWeight: FontWeight.bold),
        ),

        /// space
        SizedBox(height: Sizes.dimen_12.h),

        /// Card with text
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:Sizes.dimen_12.h ,horizontal:Sizes.dimen_12.w),
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: ScreenUtil.screenHeight - (ScreenUtil.statusBarHeight + ScreenUtil.bottomBarHeight + Sizes.dimen_100.h)
                  ),
                  //height: 400,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                          screenModel.content,
                          overflow: TextOverflow.clip,
                          //maxLines: 500,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.primaryDarkColor,
                      ),
                    ),
              ),
                  ),
                ),
            ),
            ),
          ),
        )
      ],
    ),)
    ,
    );
  }

  /// return the required model according to [StaticScreenType]
  StaticScreensModel buildScreenModel() =>
      StaticDataSources(staticScreenType: staticScreenType).getScreenModel();
}
