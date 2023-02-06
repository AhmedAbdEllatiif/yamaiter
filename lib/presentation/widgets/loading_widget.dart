import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../common/constants/assets_constants.dart';
import '../themes/theme_color.dart';



class LoadingWidget extends StatelessWidget {
  final double size;
  final String? text;

  const LoadingWidget({
    Key? key,
    this.size = 100,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size,
          width: size,
          child: Lottie.asset(AssetsLottie.loading),
        ),

        // text
        if(text != null)
        Text(
          text ?? "",
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: AppColor.accentColor),
        )
      ],
    );
  }
}
