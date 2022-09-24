import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/app_utils.dart';
import '../themes/theme_color.dart';

class AppDropDownField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final List<String> itemsList;
  final Function(String?) onChanged;
  final double? height;
  final double? width;
  final EdgeInsets? margin;

  const AppDropDownField({
    Key? key,
    required this.itemsList,
    this.hintText,
    this.errorText,
    required this.onChanged,
    this.height,
    this.width,
    this.margin,
  }) : super(key: key);

  @override
  State<AppDropDownField> createState() => _AppDropDownFieldState();
}

class _AppDropDownFieldState extends State<AppDropDownField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        //value: "A",

        // decoration
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.primaryColor,

          // to decrease the height size
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),

          // hint text style
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColor.white),

          // error text
          errorText: widget.errorText,
          errorStyle: const TextStyle(
            color: AppColor.accentColor,
            fontWeight: FontWeight.normal,
          ),

          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.primaryColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.accentColor),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.red),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.accentColor),
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          ),
        ),

        // iconEnabledColor
        iconEnabledColor: AppColor.white,

        // text style
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColor.white
        ),

        // dropdownColor
        dropdownColor: AppColor.primaryColor,

        // dropDownRadius
        borderRadius: BorderRadius.all(
          Radius.circular(AppUtils.cornerRadius.w),
        ),

        // onChanged
        onChanged: widget.onChanged,

        validator: (value) {
          // if (value == null) return "* اختر المحافظة محل العمل";
          // if (value.isEmpty) return "* اختر المحافظة محل العمل";
          if (value == null) return "* مطلوب ادخاله";
          if (value.isEmpty) return "* مطلوب ادخاله";
        },

        // items
        items: widget.itemsList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
