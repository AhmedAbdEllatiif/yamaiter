import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../presentation/themes/theme_color.dart';
import '../constants/sizes.dart';

/// show snackBar
/// * [context] the current context to show snackBar
/// * [message] the required message to show
void showSnackBar(BuildContext context,
    {required String message,
    Color? textColor,
    Color? backgroundColor,
    bool isFloating = true}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: textColor ?? AppColor.primaryDarkColor,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor ?? AppColor.white,
        behavior:
            isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
        shape: isFloating
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.dimen_20.w))
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Sizes.dimen_20.w),
                    topLeft: Radius.circular(Sizes.dimen_20.w))),
        margin: isFloating
            ? EdgeInsets.symmetric(
                horizontal: Sizes.dimen_30.w,
                vertical: Sizes.dimen_10.h,
              )
            : null,
      ),
    );
}
