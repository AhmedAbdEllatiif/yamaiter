import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/assets_constants.dart';
import '../../../../domain/entities/data/ad_entity.dart';
import '../../../../router/route_helper.dart';
import '../../../widgets/ads_list/ads_list_view.dart';
import 'article_form.dart';

class CreateArticleScreen extends StatelessWidget {
  const CreateArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة منشور"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppUtils.mainPagesHorizontalPadding.w,
            vertical: AppUtils.mainPagesVerticalPadding.h),
        child: Column(
          children:  [
            const AdsListViewWidget(
              adsList: [
                AdEntity(id: 0, url: AssetsImages.adSample),
                AdEntity(id: 1, url: AssetsImages.adSample),
                AdEntity(id: 1, url: AssetsImages.adSample),
              ],
            ),

            //==> article form
            Expanded(child: ArticleForm(
              onSuccess: (){
                RouteHelper().myArticlesScreen(context, isReplacement: true);
              },
            )),
          ],
        ),
      ),
    );
  }
}
