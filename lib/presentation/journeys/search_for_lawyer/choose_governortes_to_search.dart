import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/drop_down_list.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';

import '../../../common/constants/sizes.dart';
import '../../widgets/app_button.dart';

class ChooseGovernoratesToSearch extends StatelessWidget {
  String? chosenGovernorates;
  final Function(String) onSearchPressed;

  ChooseGovernoratesToSearch({Key? key, required this.onSearchPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.screenHeight * .10,
        right: AppUtils.screenHorizontalPadding.w,
        left: AppUtils.screenHorizontalPadding.w,
      ),
      child: Column(
        children: [
          /// title
          Text(
            "يامتر ابحث عن محامى فى محافظة.. ؟",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColor.accentColor,
                  fontWeight: FontWeight.bold,
                ),
          ),

          SizedBox(
            height: Sizes.dimen_16.h,
          ),

          /// dropDown
          AppDropDownField(
            hintText: "اختر محافظة البحث",
            itemsList: governoratesList,
            onChanged: (value) {
              chosenGovernorates = value;
            },
          ),
          SizedBox(
            height: Sizes.dimen_16.h,
          ),

          /// search button
          AppButton(
            text: "ابحث الان",
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: Sizes.dimen_30.w),
            color: AppColor.accentColor,
            textColor: AppColor.white,
            fontSize: Sizes.dimen_16.sp,
            padding: EdgeInsets.zero,
            onPressed: () {
              onSearchPressed(chosenGovernorates ?? "");
            },
          ),
        ],
      ),
    );
  }
}
