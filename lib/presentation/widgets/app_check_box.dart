import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class AppCheckBoxTiel extends StatefulWidget {
  final Function(bool?) onChanged;

  const AppCheckBoxTiel({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<AppCheckBoxTiel> createState() => _AppCheckBoxTileState();
}

class _AppCheckBoxTileState extends State<AppCheckBoxTiel> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        "من خلال إنشاء حساب، فأنك توافق على الشروط و الأحكام سياسة الخصوصية و اتفاقية المعاملات القانونية ",
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: AppColor.white),
      ),
      value: _isChecked,

      side: const BorderSide(color: AppColor.accentColor),
      checkColor: AppColor.white,

      // checkboxShape
      checkboxShape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2)),

      // onChanged
      onChanged: (value) {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onChanged(value);
      },
    );
  }
}
