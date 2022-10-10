import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../../domain/entities/data/ad_entity.dart';
import '../../../router/route_helper.dart';
import 'create_ad_form.dart';

class CreateAdScreen extends StatelessWidget {
  const CreateAdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("طلب اعلان"),
      ),
      body: Column(
        children: [
          /// Ads
           const AdsWidget(),

          /// Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_16.h,
                right: AppUtils.mainPagesHorizontalPadding.w,
                left: AppUtils.mainPagesHorizontalPadding.w,
                bottom: Sizes.dimen_10.h,
              ),
              child: CreateAdForm(
                withWhiteCard: true,
                onSuccess: () =>
                    RouteHelper().myAdsScreen(context, isReplacement: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
