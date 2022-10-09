import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../../domain/entities/data/ad_entity.dart';
import '../../../router/route_helper.dart';
import 'create_tax_form.dart';

class CreateTaxScreen extends StatelessWidget {
  const CreateTaxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاقرار الضريبى"),
      ),
      body: Column(
        children: [
          /// Ads
          const AdsWidget(
            adsList: [
              AdEntity(id: 0, url: AssetsImages.adSample),
              AdEntity(id: 1, url: AssetsImages.adSample),
              AdEntity(id: 1, url: AssetsImages.adSample),
            ],
          ),

          /// Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_16.h,
                right: AppUtils.mainPagesHorizontalPadding.w,
                left: AppUtils.mainPagesHorizontalPadding.w,
                bottom: Sizes.dimen_10.h,
              ),
              child: CreateTaxForm(
                withWhiteCard: true,
                onSuccess: () =>
                    RouteHelper().myTaxesScreen(context, isReplacement: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
