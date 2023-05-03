import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import 'theme_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.cairoTextTheme();

  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.titleLarge!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadline5 => _poppinsTextTheme.headlineSmall!.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteSubTitle1 => _poppinsTextTheme.titleLarge!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get _whiteSubTitle2 => _poppinsTextTheme.titleLarge!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );

  //violetHeadLine6
  static TextStyle get _whiteBodyText2 => _poppinsTextTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get _button => _poppinsTextTheme.labelLarge!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static getTextTheme() => TextTheme(
        headlineSmall: _whiteHeadline5,
        titleLarge: _whiteHeadline6,
        titleMedium: _whiteSubTitle1,
        titleSmall: _whiteSubTitle2,
        bodyMedium: _whiteBodyText2,
        labelLarge: _button,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get submitTextButton => labelLarge!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
        letterSpacing: 1.5,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.bold,
      );

  TextStyle get gerySubtitle1 => titleMedium!.copyWith(
        color: Colors.grey,
      );

  TextStyle get whiteSubtitle1 => titleMedium!.copyWith(
        color: Colors.white,
      );

  TextStyle get wHeadLine6 => titleLarge!.copyWith(
        color: Colors.white,
      );

  TextStyle get violetHeadLine6 => titleLarge!.copyWith(
        color: AppColor.accentColor,
      );

  TextStyle get vulcanBodyText2 => bodyMedium!.copyWith(
        color: AppColor.primaryDarkColor,
      );

  TextStyle get whiteCaption => bodySmall!.copyWith(
        color: Colors.white,
      );

  TextStyle get geryCaption => bodySmall!.copyWith(
        color: Colors.grey,
      );

  TextStyle get vulcanCaption => bodySmall!.copyWith(
        color: AppColor.primaryDarkColor,
      );

  TextStyle get letterSpaceHeadLine6 => titleLarge!.copyWith(
      color: AppColor.primaryDarkColor,
      letterSpacing: 2,
      fontWeight: FontWeight.bold);

  TextStyle get blackBodyText2 => bodyMedium!.copyWith(
        color: AppColor.primaryDarkColor,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  TextStyle get boldVulcanBodyText2 => bodyMedium!.copyWith(
      color: AppColor.primaryDarkColor,
      fontSize: Sizes.dimen_14.sp,
      wordSpacing: 0.25,
      letterSpacing: 0.25,
      height: 1.5,
      fontWeight: FontWeight.bold);
}
