import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/sizes.dart';

class ChooseToAddScreen extends StatelessWidget {
  const ChooseToAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _itemToChoose(context,text: "نشر مهمة عمل"),
              SizedBox(width: Sizes.dimen_5.w),
              _itemToChoose(context,text:"استغاثة عاجلة SOS")
            ],
          ),
          SizedBox(
            height: Sizes.dimen_5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _itemToChoose(context,text:"شارك افكارك من هنا"),
              SizedBox(width: Sizes.dimen_5.w),
              _itemToChoose(context,text:"طلب اعلان دعائى")
            ],
          ),
          SizedBox(
            height: Sizes.dimen_5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_itemToChoose(context,text:"قدم إقرارك الضريبى السنوى من هنا")],
          ),
        ],
      ),
    );
  }

  Widget _itemToChoose(BuildContext context, {String text = "Test"}) {
    return Card(
      child: InkWell(
        onTap: () {RouteHelper().createSos(context);},
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        child: Container(
          constraints: BoxConstraints(
            minWidth: ScreenUtil.screenWidth * 0.35,
            maxWidth: ScreenUtil.screenWidth * .36,
            minHeight: ScreenUtil.screenHeight * 0.16,
            maxHeight: ScreenUtil.screenHeight * 0.18,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.ac_unit,
                size: Sizes.dimen_20.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: Sizes.dimen_2.h,right: Sizes.dimen_5.w,left: Sizes.dimen_5.w),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColor.primaryDarkColor,
                    height: 1.1
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
