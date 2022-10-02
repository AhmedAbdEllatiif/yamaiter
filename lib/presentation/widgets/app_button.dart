import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';

import '../../common/constants/sizes.dart';
import '../../common/enum/animation_type.dart';
import '../themes/theme_color.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Function() onPressed;
  final EdgeInsets margin;
  final double? height;
  final bool isTextButton;
  final bool withAnimation;
  final Icon? icon;
  final double? width;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.color = AppColor.primaryColor,
    this.height,
    this.icon,
    this.width,
    this.isTextButton = false,
    this.withAnimation = false,
     this.textColor = AppColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withAnimation ? button(context).animate(
        slideDuration: const Duration(milliseconds: 300),
        fadeDuration: const Duration(milliseconds: 300),
        map: {
          AnimationType.slide: {
            SlideOffset.begin: const Offset(0.0, 0.5),
            SlideOffset.end: const Offset(0.0, 0.0),
          },
          AnimationType.fade: {
            FadeOpacity.begin: 0.5,
            FadeOpacity.end: 1.0,
          },
        }) : button(context);
  }

  Widget button(BuildContext context){
    return Container(
      // height: Sizes.dimen_16.h,
      margin: margin,
      width: width,
      /*height: height ??
          ResponsiveValue<double>(context,
              defaultValue: Sizes.dimen_20.h,
              valueWhen: [
                Condition.equals(name: TABLET, value: Sizes.dimen_30.h),
                Condition.largerThan(name: TABLET, value: Sizes.dimen_30.h),
                Condition.equals(name: MOBILE, value: Sizes.dimen_25.h),
                Condition.smallerThan(name: MOBILE, value: Sizes.dimen_40.h),
              ]).value,*/

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w)),
        /* gradient: const LinearGradient(
          colors: [AppColor.appPurple, AppColor.appPurple],
        ),*/
      ),
      child: isTextButton
          ? _customTextButton(context)
          : _elevatedButton(context),
    );
  }


  /// return custom text button
  Widget _customTextButton(BuildContext context){
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_30.w)),
      child: Container(
        padding: const EdgeInsets.all(Sizes.dimen_6),
      /*  decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: AppColor.accentColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.dimen_30.w),
          ),
        ),*/
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.button!.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveValue(context,
                    defaultValue: Sizes.dimen_12.sp,
                    valueWhen: [
                      Condition.largerThan(
                          name: TABLET,
                          value: Sizes.dimen_12.sp),
                      Condition.equals(
                          name: TABLET,
                          value: Sizes.dimen_12.sp),
                      Condition.equals(
                          name: MOBILE,
                          value: Sizes.dimen_14.sp),
                      Condition.smallerThan(
                          name: MOBILE,
                          value: Sizes.dimen_15.sp),
                    ]).value,
              ),
            ),
            if (icon != null)
              SizedBox(
                width: Sizes.dimen_5.w,
              ),
            if (icon != null) icon!,
          ],
        ),
      ),
    );
  }

  /// return elevated button
  ElevatedButton _elevatedButton(BuildContext context){
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
          shadowColor:  MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:BorderRadius.all(Radius.circular(Sizes.dimen_30.w)),
                  // side: BorderSide(color: Colors.red)
              )
          )
      ),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Sizes.dimen_3.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveValue(context,
                    defaultValue: Sizes.dimen_12.sp,
                    valueWhen: [
                      Condition.largerThan(
                          name: TABLET, value: Sizes.dimen_12.sp),
                      Condition.equals(
                          name: TABLET, value: Sizes.dimen_12.sp),
                      Condition.equals(
                          name: MOBILE, value: Sizes.dimen_18.sp),
                      Condition.smallerThan(
                          name: MOBILE, value: Sizes.dimen_15.sp),
                    ]).value,
              ),
            ),
            if (icon != null)
              SizedBox(
                width: Sizes.dimen_5.w,
              ),
            if (icon != null) icon!
          ],
        ),
      ),
    );
  }
}
