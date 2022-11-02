import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/string_extensions.dart';

import 'package:yamaiter/common/extensions/widgetExtension.dart';

import '../../common/enum/animation_type.dart';
import '../themes/theme_color.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? errorText;
  final String? label;
  final Icon? icon;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final bool? enabled;
  final String? rePassword;
  final double? height;
  final double? width;
  final int? minLines;
  final int? maxLines;
  final EdgeInsets? margin;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final bool withFocusedBorder;
  final bool validateOnSubmit;

  const AppTextField({
    Key? key,
    this.controller,
    this.errorText,
    this.icon,
    this.validator,
    this.textInputType = TextInputType.text,
    this.label,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.enabled,
    this.rePassword,
    this.height,
    this.width,
    this.margin,
    this.labelStyle,
    this.textStyle,
    this.withFocusedBorder = true,
    this.validateOnSubmit = true,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscure;
  late Widget? _icon;

  @override
  void initState() {
    _isObscure = _isPasswordTextInputType();
    _icon = _buildIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // to rebuild icon with setState
    _icon = _buildIcon();

    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: TextFormField(
        // controller
        controller: widget.controller,

        // enabled
        enabled: widget.enabled,

        // max length with counter
        //maxLength: widget.maxLength,

        // max length without counter
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],

        // max and min lines
        minLines: widget.textInputType == TextInputType.visiblePassword
            ? 1
            : widget.minLines,
        maxLines: widget.textInputType == TextInputType.visiblePassword
            ? 1
            : widget.maxLength,

        // cursor color
        cursorColor: AppColor.white,

        // text style
        style: widget.textStyle ?? const TextStyle(color: AppColor.white),

        textInputAction: widget.textInputAction,

        // input decoration
        decoration: InputDecoration(
          // borders
          fillColor: AppColor.primaryColor,
          filled: true,

          // to decrease the height size
          isDense: true,
          contentPadding: widget.icon == null ||
                  widget.textInputType == TextInputType.visiblePassword
              ? const EdgeInsets.fromLTRB(10, 10, 10, 0)
              : const EdgeInsets.fromLTRB(8, 8, 8, 0),

          disabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.primaryColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.primaryColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          focusedBorder: widget.withFocusedBorder
              ? OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.accentColor),
                  borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
                )
              : const OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.primaryColor),
                ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.red),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.red),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),

          // label text
          labelText: widget.label,
          labelStyle:
              widget.labelStyle ?? const TextStyle(color: AppColor.white),

          //hintText:  widget.label,
          //hintStyle:  const TextStyle(color: AppColor.white),

          // error text
          errorText: widget.errorText != null
              ? widget.errorText!.isNotEmpty
                  ? widget.errorText
                  : null
              : null,
          errorStyle: const TextStyle(
            color: AppColor.accentColor,
            fontWeight: FontWeight.normal,
          ),

          // icon
          suffixIcon: _icon,
        ),

        // keyboardType
        keyboardType: widget.textInputType,

        obscureText: _isObscure,

        // validator
        validator:
            widget.validateOnSubmit ? widget.validator ?? validate : null,
      ).animate(
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
          }),
    );
  }

  /// return true if the textInput is visiblePassword
  bool _isPasswordTextInputType() =>
      widget.textInputType == TextInputType.visiblePassword;

  /// To build the icon
  Widget? _buildIcon() {
    // widget icon not null
    if (widget.icon != null) {
      return widget.icon;
    }

    // default password icon
    if (_isPasswordTextInputType()) {
      return IconButton(
        icon: Icon(
          _isObscure
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColor.white,
        ),
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
      ).animate(map: {
        AnimationType.rotate: {TriggerOn: TriggerOn.click}
      });
    }

    return null;
  }

  /// To validate
  String? validate(String? value) {
    if (value != null) {
      if (widget.textInputType == TextInputType.emailAddress) {
        return emailValidation(value);
      }
      if (_isPasswordTextInputType()) {
        return passwordValidation(value);
      }
    }

    if (value == null) return "* مطلوب ادخاله";
    if (value.isEmpty) return "* مطلوب ادخاله";
    return null;
  }

  /// return a nullable string of email validation
  String? emailValidation(String value) {
    if (value.isEmpty) return "* الرجاء إدخال البريد الخاص بك";

    if (!value.matchEmail) return "* عنوان البريد الإلكتروني غير صالح";

    return null;
  }

  /// return a nullable string of password validation
  String? passwordValidation(String value) {
    /*if (widget.rePassword != null) {
      if (value != widget.rePassword) {
        return "* يجب أن تكون كلمات المرور هي نفسها";
      }
    }*/

    // empty value
    if (value.isEmpty) return '* من فضلك أدخل كلمة مرور';

    // not contains a uppercase
    if (!value.containsUppercase) {
      return '* يجب تضمين حرف علوي واحد على الأقل';
    }

    // not contains a lowercase
    if (!value.containsLowercase) {
      return '* يجب تضمين حرف سفلي واحد على الأقل';
    }

    // not contains a special character
    if (!value.containsSpecialCharacter) {
      return '* يجب تضمين حرف خاص واحد على الأقل';
    }

    // not contains a number
    if (!value.containsNumber) return '* يجب تضمين رقم واحد على الأقل';

    // less than 8 characters
    if (value.length < 8) return '* يجب أن تكون كلمة المرور 8 أحرف على الأقل';

    return null;
  }
}
