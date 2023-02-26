import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/enum/ad_status.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../../themes/theme_color.dart';

class AdStatusWidget extends StatefulWidget {
  final AdStatus adStatus;

  const AdStatusWidget({Key? key, required this.adStatus}) : super(key: key);

  @override
  State<AdStatusWidget> createState() => _AdStatusWidgetState();
}

class _AdStatusWidgetState extends State<AdStatusWidget> {
  late final Color _color;
  late final Color _textColor;

  @override
  void initState() {
    super.initState();

    switch (widget.adStatus) {
      case AdStatus.unKnown:
        _color = AppColor.white;
        _textColor = AppColor.black;
        break;
      case AdStatus.inprogress:
        _color = AppColor.gray;
        _textColor = AppColor.white;
        break;
      case AdStatus.published:
        _color = AppColor.green;
        _textColor = AppColor.white;
        break;
      case AdStatus.expired:
        _color = AppColor.red;
        _textColor = AppColor.white;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
      color: _color,
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w)
      ),
      child: Text(
        widget.adStatus.toShortString(),
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.normal, color: _textColor,
        fontSize: Sizes.dimen_12.sp),
      ),
    );
  }
}
