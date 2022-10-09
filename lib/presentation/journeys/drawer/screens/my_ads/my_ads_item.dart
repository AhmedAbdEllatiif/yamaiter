import 'package:flutter/material.dart';

import '../../../../../common/screen_utils/screen_util.dart';
import '../../../../themes/theme_color.dart';

class MyAdItem extends StatelessWidget {
  const MyAdItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.primaryDarkColor,
      child: Container(
        height: ScreenUtil.screenHeight * 0.15,
        //width: double.infinity,
        //color: AppColor.primaryDarkColor,
      )
    );
  }
}
