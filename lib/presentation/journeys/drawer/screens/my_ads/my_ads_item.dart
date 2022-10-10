import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';

import '../../../../../common/screen_utils/screen_util.dart';
import '../../../../themes/theme_color.dart';

class MyAdItem extends StatelessWidget {
  final AdEntity adEntity;

  const MyAdItem({Key? key, required this.adEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColor.primaryDarkColor,
        child: Container(
          height: ScreenUtil.screenHeight * 0.15,
          //width: double.infinity,
          //color: AppColor.primaryDarkColor,
          child: Center(
            child: Text(
              "Price: ${adEntity.price}",
              style: TextStyle(color: AppColor.white),
            ),
          ),
        ));
  }
}
