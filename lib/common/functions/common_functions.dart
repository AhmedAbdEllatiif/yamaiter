import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../presentation/themes/theme_color.dart';
import '../constants/sizes.dart';

/// show snackBar
/// * [context] the current context to show snackBar
/// * [message] the required message to show
void showSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColor.primaryDarkColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColor.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.dimen_20.w)),
        margin: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_30.w,
          vertical: Sizes.dimen_10.h,
        ),
      ),
    );
}
