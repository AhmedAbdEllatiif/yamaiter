import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'app_content_title_widget.dart';

class TitleWithAddNewItem extends StatelessWidget {
  final String title;
  final String addText;
  final Function() onAddPressed;

  const TitleWithAddNewItem(
      {Key? key,
      required this.title,
      required this.addText,
      required this.onAddPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppContentTitleWidget(
            title: title,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryDarkColor)),
                child: Icon(
                  Icons.add,
                  color: AppColor.primaryDarkColor,
                  size: Sizes.dimen_12.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_5.w),
                child: Text(
                  addText,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColor.primaryDarkColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
