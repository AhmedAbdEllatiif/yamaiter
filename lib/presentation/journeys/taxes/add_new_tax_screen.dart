import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/taxes/create_tax_form.dart';
import 'package:yamaiter/presentation/logic/cubit/create_tax/create_tax_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/screen_arguments/add_tax_args.dart';

class AddNewTaxScreen extends StatelessWidget {

  final AddTaxArguments addTaxArguments;
  const AddNewTaxScreen({Key? key, required this.addTaxArguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,

      /// appBar
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
          child: CreateTaxForm(
            createTaxCubit: addTaxArguments.createTaxCubit,
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
