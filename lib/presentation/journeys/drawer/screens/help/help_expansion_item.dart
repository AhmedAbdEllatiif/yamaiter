import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../themes/theme_color.dart';

class HelpExpansionPanelRadio extends ExpansionPanelRadio {
  HelpExpansionPanelRadio({
    required String title,
    required String content,
  }) : super(
          canTapOnHeader: true,
          //hasIcon: false,

          /// title
          value: title,

          /// headerBuilder
          headerBuilder: (context, isExpanded) => Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: isExpanded ? 10 : 5,
              shadowColor: isExpanded
                  ? AppColor.primaryDarkColor.withOpacity(0.9)
                  : AppColor.primaryColor.withOpacity(0.5),
              child: ListTile(
                title: Text(title),
              ),
            ),
          ),

          /// body
          body: Container(
            padding: EdgeInsets.only(bottom: Sizes.dimen_10.h),
            child: Card(
              shadowColor: AppColor.primaryDarkColor.withOpacity(0.9),
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(Sizes.dimen_10.w),
                child: Text(content),
              ),
            ),
          ),
        );
}
