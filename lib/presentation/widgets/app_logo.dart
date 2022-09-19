import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';

class AppLogo extends StatelessWidget {
  final double? size;

  const AppLogo({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImages.personAvatar,
      height: size,
      width: size,
    );
  }
}
