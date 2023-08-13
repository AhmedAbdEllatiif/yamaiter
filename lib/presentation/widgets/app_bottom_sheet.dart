import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../common/constants/app_utils.dart';
import '../themes/theme_color.dart';

class AppBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;

  const AppBottomSheet({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // Customize the bottom sheet content here
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppUtils.cornerRadius.w * 2),
        topRight: Radius.circular(AppUtils.cornerRadius.w * 2),
      ),
      child: Container(
        color: AppColor.white,
        padding: EdgeInsets.only(
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // title
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            // divider
            const Divider(height: 30, color: AppColor.gray),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // space
                  const SizedBox(height: 20),

                  child,

                  // space
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
