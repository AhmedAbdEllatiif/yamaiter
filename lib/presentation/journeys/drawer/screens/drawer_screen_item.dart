import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/about/about_section_entity.dart';

import '../../../../common/constants/sizes.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/static_pages_content_widget.dart';
import '../../../widgets/static_pages_title_widget.dart';

class DrawerScreenItem extends StatelessWidget {
  final String title;

  final List<AboutSectionEntity> sections;

  const DrawerScreenItem(
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
          StaticPageTitleWidget(
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
              return StaticPageContentWidget(
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
