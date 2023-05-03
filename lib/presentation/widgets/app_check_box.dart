import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class AppCheckBoxTile extends StatefulWidget {
  final Function(bool?) onChanged;
  final String text;
  final Color textColor;
  final Color checkBoxColor;
  final bool hasError;

  const AppCheckBoxTile({
    Key? key,
    required this.onChanged,
    required this.text,
    this.textColor = AppColor.primaryDarkColor,
    this.checkBoxColor = AppColor.primaryDarkColor,
    this.hasError = false,
  }) : super(key: key);

  @override
  State<AppCheckBoxTile> createState() => _AppCheckBoxTileState();
}

class _AppCheckBoxTileState extends State<AppCheckBoxTile> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.text,
        maxLines: 2,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: widget.textColor, height: 1.5,fontWeight: FontWeight.bold),
      ),


      // subtitle as error
      subtitle: widget.hasError
          ? Text(
              "* يجب الموافقة على شروط الاتفاقية",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColor.red),
            )
          : null,


      value: _isChecked,
      dense: false,

      // checked color
      checkColor: AppColor.white,
      activeColor: AppColor.primaryDarkColor,

      // border side color
      side: BorderSide(color: widget.hasError?AppColor.red: widget.checkBoxColor),

      // checkboxShape
      checkboxShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
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
