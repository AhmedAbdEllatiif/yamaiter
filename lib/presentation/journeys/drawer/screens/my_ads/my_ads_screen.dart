import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../common/constants/app_utils.dart';
import '../../../../../common/constants/assets_constants.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../../domain/entities/data/ad_entity.dart';
import '../../../../widgets/ads_list/ads_list_view.dart';
import '../../../../widgets/title_with_add_new_item.dart';
import 'my_ads_item.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إعلاناتى"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppUtils.mainPagesHorizontalPadding.w,
            vertical: AppUtils.mainPagesVerticalPadding.h),
        child: Column(
          children: [
            /// Ads ListView
            const AdsListViewWidget(
              adsList: [
                AdEntity(id: 0, url: AssetsImages.adSample),
                AdEntity(id: 1, url: AssetsImages.adSample),
                AdEntity(id: 1, url: AssetsImages.adSample),
              ],
            ),

            /// title with add new
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: Sizes.dimen_16.h),
                child: Column(
                  children: [
                    /// title with add new sos
                    TitleWithAddNewItem(
                      title: "إعلاناتى",
                      addText: "طلب إعلان جديد",
                      onAddPressed: () => _navigateToAddNewAd(context),
                    ),

                    /// list of my sos
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            //==> separator
                            separatorBuilder: (context, index) => SizedBox(
                              height: Sizes.dimen_2.h,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return const MyAdItem();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// to navigate to add new ad
  void _navigateToAddNewAd(BuildContext context) =>
      RouteHelper().addNewAdScreen(context);
}
