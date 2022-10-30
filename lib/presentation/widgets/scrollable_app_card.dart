import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';

import '../../common/constants/sizes.dart';
import '../../common/screen_utils/screen_util.dart';

class ScrollableAppCard extends StatelessWidget {
  final Widget child;
  final Widget? bottomChild;
  final Widget? title;
  final EdgeInsets? padding;
  final ScrollController? scrollController;

  const ScrollableAppCard({
    Key? key,
    required this.child,
    this.bottomChild,
    this.padding,
    this.scrollController,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
                vertical: Sizes.dimen_10.h, horizontal: Sizes.dimen_12.w),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: ScreenUtil.screenHeight -
                (ScreenUtil.statusBarHeight +
                    ScreenUtil.bottomBarHeight +
                    Sizes.dimen_120.h),
          ),
          child: Scrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// title
                title ?? const SizedBox.shrink(),

                // space
                if (title != null) SizedBox(height: Sizes.dimen_8.h),

                /// child
                Expanded(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: child),
                ),

                // space
                if (bottomChild != null) SizedBox(height: Sizes.dimen_8.h),

                /// bottom child
                bottomChild ?? const SizedBox.shrink(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
