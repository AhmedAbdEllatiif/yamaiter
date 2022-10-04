import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/sos/sos_form.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../common/constants/sizes.dart';

class AddSosScreen extends StatelessWidget {
  const AddSosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      /// appBar
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
          child: const SosForm(withWithCard: false,),
        ),
      ),
    );
  }
}
