import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/screen_utils/screen_util.dart';
import '../../../themes/theme_color.dart';

class ChooseToAddItem extends StatelessWidget {
  final String text;
  final String image;
  final Function() onPressed;

  const ChooseToAddItem({
    Key? key,
    required this.text,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        child: Container(
          constraints: BoxConstraints(
            minWidth: ScreenUtil.screenWidth * 0.35,
            maxWidth: ScreenUtil.screenWidth * .36,
            minHeight: ScreenUtil.screenHeight * 0.16,
            maxHeight: ScreenUtil.screenHeight * 0.18,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// image
              SvgPicture.asset(
                  image,
                  height: Sizes.dimen_40.w,
                  width: Sizes.dimen_40.w,
                  color: AppColor.primaryDarkColor,
                  semanticsLabel: 'A red up arrow'
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: Sizes.dimen_2.h,
                    right: Sizes.dimen_5.w,
                    left: Sizes.dimen_5.w),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColor.primaryDarkColor, height: 1.1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
