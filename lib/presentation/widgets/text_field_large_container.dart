import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';
import '../../common/screen_utils/screen_util.dart';
import '../themes/theme_color.dart';
import 'app_text_field.dart';

class TextFieldLargeContainer extends StatelessWidget {
  final AppTextField appTextField;

  const TextFieldLargeContainer({Key? key, required this.appTextField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_8.h, horizontal: Sizes.dimen_5.w),
        constraints: BoxConstraints(
            minHeight: ScreenUtil.screenHeight * 0.15,
            maxHeight: ScreenUtil.screenHeight * 0.30),
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius)),
        child: appTextField);
  }
}
