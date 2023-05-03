import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/sos/sos_form.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/screen_arguments/add_sos_args.dart';

class AddSosScreen extends StatelessWidget {
  final AddSosArguments addSosArguments;

  const AddSosScreen({Key? key, required this.addSosArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,

      /// appBar
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
          child: SosForm(
            createSosCubit: addSosArguments.createSosCubit,
            withWithCard: false,
            onSuccess: ()=> Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
