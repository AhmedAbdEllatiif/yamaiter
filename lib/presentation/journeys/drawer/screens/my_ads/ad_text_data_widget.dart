import 'package:flutter/material.dart';

class AddTextData extends StatelessWidget {
  final String text;
  final String value;

  const AddTextData({Key? key, required this.text, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text $value",
      textDirection: TextDirection.rtl,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      maxLines: 1,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Colors.black,
      ),
    );
  }
}
