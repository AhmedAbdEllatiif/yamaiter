import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';
import 'package:yamaiter/presentation/journeys/sos/sos_form.dart';
import '../../widgets/ads_list/ads_list_view.dart';

class CreateSosScreen extends StatelessWidget {
  const CreateSosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("نشر استغاثة"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppUtils.mainPagesHorizontalPadding.w,
            vertical: AppUtils.mainPagesVerticalPadding.h),
        child: Column(
          children: const [
            AdsListViewWidget(
              adsList: [
                AdEntity(id: 0, url: AssetsImages.adSample),
                AdEntity(id: 1, url: AssetsImages.adSample),
                AdEntity(id: 1, url: AssetsImages.adSample),
              ],
            ),

            //==> sos form
            SosForm(),
          ],
        ),
      ),
    );
  }
}
