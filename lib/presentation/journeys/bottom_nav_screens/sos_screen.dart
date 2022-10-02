import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/drop_down_list.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../../common/constants/sizes.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({Key? key}) : super(key: key);

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// content card
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_10.h),
              child: ScrollableAppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// title
                    const AppContentTitleWidget(title: "نشر استغاثة طارئة"),

                    //==> space
                    SizedBox(height: Sizes.dimen_8.h),

                    AppDropDownField(
                        hintText: "حدد نوع حالة الطوارئ",
                        itemsList: sosTypeList,
                        onChanged: (value) {}),

                    //==> space
                    SizedBox(height: Sizes.dimen_5.h),

                    AppDropDownField(
                        hintText: "انشر فى نطاق",
                        itemsList: governoratesListWithSelectAll,
                        isLastItemHighlighted: true,
                        onChanged: (value) {}),

                    //==> space
                    SizedBox(height: Sizes.dimen_5.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Sizes.dimen_8.h,
                          horizontal: Sizes.dimen_5.w),
                      constraints: BoxConstraints(
                          minHeight: ScreenUtil.screenHeight * 0.15,
                          maxHeight: ScreenUtil.screenHeight * 0.30),
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius:
                              BorderRadius.circular(AppUtils.cornerRadius)),
                      child: const AppTextField(
                        label: "اكتب تفاصيل ما تتعرض له للنشر على زملائك",
                        maxLines: 20,
                        withFocusedBorder: false,
                        textInputType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                    ),

                    //==> space
                    SizedBox(height: Sizes.dimen_5.h),

                    AppButton(
                      text: "انشر استغاثتى على الزملاء",
                      color: AppColor.accentColor,
                      textColor: AppColor.primaryDarkColor,
                      withAnimation: true,
                      width: double.infinity,
                      onPressed: () {},
                    ),

                    //==> space
                    SizedBox(height: Sizes.dimen_20.h),
                  ],
                ),
              ),
            ),

            //==> space under the card
            SizedBox(height: Sizes.dimen_20.h),
          ],
        ),
      ),
    );
  }
}
