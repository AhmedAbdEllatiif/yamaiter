import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';

import '../../../domain/entities/screen_arguments/delete_sos_args.dart';

class DeleteSosScreen extends StatefulWidget {
  final DeleteSosArguments deleteSosArguments;
  const DeleteSosScreen({Key? key, required this.deleteSosArguments}) : super(key: key);

  @override
  State<DeleteSosScreen> createState() => _DeleteSosScreenState();
}

class _DeleteSosScreenState extends State<DeleteSosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primaryDarkColor,
        width: double.infinity,
        padding: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.25),
        child: Column(
          children: [
            /// title
            Text(
              "حذف الاستغاثة",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColor.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),

            SizedBox(
              height: Sizes.dimen_8.h,
            ),

            Text(
              "هل انت متاكد من حذف هذه الاستغاثة",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),

            SizedBox(
              height: Sizes.dimen_8.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: AppButton(
                          text: "حذف الاستغاثة",
                          color: AppColor.accentColor,
                          textColor: AppColor.white,
                          fontSize: Sizes.dimen_16.sp,
                          padding: EdgeInsets.zero,
                          onPressed: () {})),
                  SizedBox(
                    width: Sizes.dimen_10.w,
                  ),
                  Expanded(
                    child: AppButton(
                      text: "إلغاء",
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
