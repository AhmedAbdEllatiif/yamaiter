import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/sizes.dart';
import 'choose_to_add_item.dart';

class ChooseToAddScreen extends StatelessWidget {
  const ChooseToAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
      child: Column(
        children: [
          /// first row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //==> request a work
              ChooseToAddItem(
                image: AssetsImages.documentsSvg,
                text: "نشر مهمة عمل",
                onPressed: () {},
              ),
              SizedBox(width: Sizes.dimen_5.w),

              //==> sos
              ChooseToAddItem(
                image: AssetsImages.sosSvg,
                text: "استغاثة عاجلة SOS",
                onPressed: () => _navigateToCreateSos(context),
              ),
            ],
          ),

          /// row space
          SizedBox(height: Sizes.dimen_5.h),

          /// second row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //==> share article
              ChooseToAddItem(
                image: AssetsImages.newsPaperSvg,
                text: "شارك افكارك من هنا",
                onPressed: () => _navigateToCreateArticle(context),
              ),
              SizedBox(width: Sizes.dimen_5.w),

              //==> request an ad
              ChooseToAddItem(
                image: AssetsImages.publishAdSvg,
                text: "طلب اعلان دعائى",
                onPressed: () => _navigateCreateAdScreen(context),
              ),
            ],
          ),

          /// row space
          SizedBox(height: Sizes.dimen_5.h),

          /// third row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChooseToAddItem(
                image: AssetsImages.documentsSvg,
                text: "قدم إقرارك الضريبى السنوى من هنا",
                onPressed: () => _navigateToCreateTax(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// to navigate to create sos
  void _navigateToCreateSos(BuildContext context) =>
      RouteHelper().createSos(context);

  /// to navigate to article
  void _navigateToCreateArticle(BuildContext context) =>
      RouteHelper().createArticleScreen(context);

  /// to navigate to create ad
  void _navigateCreateAdScreen(BuildContext context) =>
      RouteHelper().createAdScreen(context);

  /// to navigate to create tax
  void _navigateToCreateTax(BuildContext context) =>
      RouteHelper().createTaxScreen(context);
}
