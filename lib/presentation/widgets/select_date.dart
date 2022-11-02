import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class SelectDateWidget extends StatefulWidget {
  final Function(String? selectedDate) onDateSelected;
  final bool hasError;
  final String? initialValue;

  const SelectDateWidget({
    Key? key,
    required this.onDateSelected,
    required this.hasError,
     this.initialValue,
  }) : super(key: key);

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  /// to select required date
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_10.w, vertical: Sizes.dimen_4.h),
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.hasError ? AppColor.red : Colors.transparent),
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w)),
        child: Text(
          selectedDate ?? widget.initialValue ?? "حدد اقصي تازيخ للتنفيذ",
          style: const TextStyle(color: AppColor.white),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        helpText: "حدد اقصي تازيخ للتنفيذ",
        cancelText: "الغاء",
        confirmText: "تأكيد",
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColor.primaryDarkColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: AppColor.primaryDarkColor, // body text color
              ),
              shadowColor: AppColor.primaryDarkColor,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: AppColor.primaryDarkColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      setState(() {
        // selectedDate = picked;
        selectedDate = "${picked.toLocal()}".split(' ')[0];
        widget.onDateSelected(selectedDate);
      });
    }
  }
}
