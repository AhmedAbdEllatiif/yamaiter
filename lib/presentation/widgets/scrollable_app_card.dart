import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../../common/screen_utils/screen_util.dart';

class ScrollableAppCard extends StatelessWidget {
  final Widget child;

  const ScrollableAppCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_10.h, horizontal: Sizes.dimen_12.w),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: ScreenUtil.screenHeight -
                (ScreenUtil.statusBarHeight +
                    ScreenUtil.bottomBarHeight +
                    Sizes.dimen_120.h),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(), child: child),
          ),
        ),
      ),
    );
  }
}
