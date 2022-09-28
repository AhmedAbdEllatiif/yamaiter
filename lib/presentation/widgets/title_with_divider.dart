import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../../common/screen_utils/screen_util.dart';
import '../themes/theme_color.dart';

class TitleWithDivider extends StatelessWidget {
  final Icon titleIcon;
  final String title;
  final Color dividerColor;

  const TitleWithDivider({
    Key? key,
    required this.titleIcon,
    required this.title,
    this.dividerColor = AppColor.primaryDarkColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //==> person icon with text
        Row(
          children: [

            /// titleIcon
            titleIcon,

            /// title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColor.primaryDarkColor),
              ),
            )
          ],
        ),

        /// separator
        SizedBox(
          width: ScreenUtil.screenWidth * 0.9,
          child:  Divider(
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
