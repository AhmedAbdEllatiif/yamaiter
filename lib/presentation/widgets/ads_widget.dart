import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/assets_constants.dart';
import '../../domain/entities/data/ad_entity.dart';
import 'ads_list/ads_list_view.dart';

class AdsWidget extends StatelessWidget {

  final List<AdEntity>? adsList;

  const AdsWidget({Key? key, this.adsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppUtils.mainPagesHorizontalPadding.w,
        vertical: AppUtils.mainPagesVerticalPadding.h,
      ),
      child: AdsListViewWidget(),
    );
  }
}
