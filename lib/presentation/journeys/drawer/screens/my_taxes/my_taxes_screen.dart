import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_taxes/tax_item.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../common/constants/app_utils.dart';
import '../../../../../common/constants/assets_constants.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../../domain/entities/data/ad_entity.dart';
import '../../../../widgets/ads_list/ads_list_view.dart';
import '../../../../widgets/title_with_add_new_item.dart';

class MyTaxesScreen extends StatefulWidget {
  const MyTaxesScreen({Key? key}) : super(key: key);

  @override
  State<MyTaxesScreen> createState() => _MyTaxesScreenState();
}

class _MyTaxesScreenState extends State<MyTaxesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appBar
      appBar: AppBar(
        title: const Text("اقرارتى الضريبية"),
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
                      title: "اقرارتى الضريبية",
                      addText: "طلب إقرار ضريبى",
                      onAddPressed: () => _navigateToAddNewTaxScreen(context),
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
                              return const TaxItem();
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

  /// to navigate to add new tax screen
  void _navigateToAddNewTaxScreen(BuildContext context) =>
      RouteHelper().addNewTaxcreen(context);
}
