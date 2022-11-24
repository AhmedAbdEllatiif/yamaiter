import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';

import '../../common/constants/app_utils.dart';
import '../themes/theme_color.dart';

class AppDropDownField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  late final List<String> itemsList;
  late final List<TaskEntity> taskItems;
  final Function(dynamic?) onChanged;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final bool isLastItemHighlighted;
  final bool disabled;

  AppDropDownField({
    Key? key,
    required this.onChanged,
    final List<String>? itemsList,
    final List<TaskEntity>? taskItems,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.height,
    this.width,
    this.margin,
    this.disabled = false,
    this.isLastItemHighlighted = false,
  }) : super(key: key) {
    if (taskItems != null) {
      this.taskItems = taskItems;
    } else {
      this.taskItems = const [];
    }

    if (itemsList != null) {
      this.itemsList = itemsList;
    } else {
      this.itemsList = const [];
    }
  }

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
      child: DropdownButtonFormField<dynamic>(
        isExpanded: true,
        //value: "A",
        value: widget.initialValue,

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
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColor.white),

        // dropdownColor
        dropdownColor: AppColor.primaryColor,

        // dropDownRadius
        borderRadius: BorderRadius.all(
          Radius.circular(AppUtils.cornerRadius.w),
        ),

        // onChanged
        onChanged: widget.disabled ? null : widget.onChanged,

        validator: (value) {
          // if (value == null) return "* اختر المحافظة محل العمل";
          // if (value.isEmpty) return "* اختر المحافظة محل العمل";
          if (value == null) return "* مطلوب ادخاله";
          if (value.isEmpty) return "* مطلوب ادخاله";
        },
        // items
        items: widget.itemsList.isNotEmpty ? _items() : _taskItems(),
      ),
    );
  }

  List<DropdownMenuItem<String>> _items() {
    final List<DropdownMenuItem<String>> items = [];
    widget.itemsList.asMap().forEach((index, element) {
      items.add(DropdownMenuItem<String>(
        value: element,
        alignment:
            widget.isLastItemHighlighted && index == widget.itemsList.length - 1
                ? AlignmentDirectional.center
                : AlignmentDirectional.centerStart,
        child:
            widget.isLastItemHighlighted && index == widget.itemsList.length - 1
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      element,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Text(element),
      ));
    });
    return items;
  }

  List<DropdownMenuItem<TaskEntity>> _taskItems() {
    final List<DropdownMenuItem<TaskEntity>> items = [];
    widget.taskItems.asMap().forEach((index, element) {
      items.add(DropdownMenuItem<TaskEntity>(
        value: element,
        alignment:
            widget.isLastItemHighlighted && index == widget.itemsList.length - 1
                ? AlignmentDirectional.center
                : AlignmentDirectional.centerStart,
        child:
            widget.isLastItemHighlighted && index == widget.itemsList.length - 1
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      element.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Text(element.title),
      ));
    });
    return items;
  }
}
