import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../domain/entities/data/side_menu_page_entity.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/scrollable_app_card.dart';
import '../../../widgets/app_content_title_widget.dart';

class SideMenuPageItem extends StatelessWidget {
  final String title;

  final List<SideMenuPageSectionEntity> sections;

  const SideMenuPageItem(
      {Key? key, required this.title, required this.sections})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Sizes.dimen_12.h, horizontal: Sizes.dimen_12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //==> title
          AppContentTitleWidget(
            title: title,
          ),

          //==> space
          SizedBox(height: Sizes.dimen_8.h),

          ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, index) => SizedBox(height: Sizes.dimen_10.h),
            itemCount: sections.length,
            itemBuilder: (_, index) {
              return ScrollableAppCard(
                child: Text(
                  sections[index].description,
                  overflow: TextOverflow.clip,
                  //maxLines: 500,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.primaryDarkColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}