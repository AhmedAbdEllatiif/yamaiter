import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../common/constants/sizes.dart';
import 'create_ad_form.dart';

class AddNewAdScreen extends StatelessWidget {
  const AddNewAdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,

      /// appBar
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
          child: CreateAdForm(
            withWhiteCard: false,
            onSuccess: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
