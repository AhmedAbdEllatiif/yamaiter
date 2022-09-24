import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'app_logo.dart';

class LogoWithTitleWidget extends StatelessWidget {

  final String title;

  const LogoWithTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: Sizes.dimen_4.h,
          ),
          child: AppLogo(
            size: Sizes.dimen_70.h,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: Sizes.dimen_10.h),
          child: Text(
           title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppColor.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
