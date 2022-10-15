import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/screen_arguments/update_sos_args.dart';
import 'package:yamaiter/presentation/journeys/sos/update_sos/update_sos_form.dart';

import '../../../../common/constants/sizes.dart';
import '../../../themes/theme_color.dart';

class UpdateSosScreen extends StatelessWidget {
  final UpdateSosArguments arguments;

  const UpdateSosScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,

      /// appBar
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
          child: UpdateSosForm(
            withWithCard: false,
            sosEntity: arguments.sosEntity,
            userToken: arguments.userToken,
            updateSosCubit: arguments.updateSosCubit,
            onSuccess: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
