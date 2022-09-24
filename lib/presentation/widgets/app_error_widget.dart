import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import '../../common/constants/sizes.dart';
import '../../common/enum/app_error_type.dart';
import '../../common/screen_utils/screen_util.dart';
import '../../domain/entities/app_error.dart';
import '../themes/theme_color.dart';
import 'app_button.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType appTypeError;
  final String message;
  final IconData? iconData;
  final String? buttonText;
  final Function() onPressedRetry;

  const AppErrorWidget({
    Key? key,
    required this.appTypeError,
    this.message = '',
    required this.onPressedRetry,
    this.iconData,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil.screenWidth * 0.80,
      child: Card(
        color: AppColor.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.dimen_32.w, vertical: Sizes.dimen_5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Icon
              Icon(
                iconData ??
                    (appTypeError == AppErrorType.api
                        ? Icons.wifi_off_outlined
                        : Icons.warning_amber_outlined),
                color: AppColor.accentColor,
                size: Sizes.dimen_64.w,
              ),

              /// Text
              Text(
                message.isEmpty
                    ? appTypeError == AppErrorType.api
                        ? "Check network connection"
                        : 'Something is gone wrong'
                    : message,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColor.primaryDarkColor),
              ),

              /// Button
              Container(
                margin: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
                child: AppButton(
                  text: buttonText ?? "Retry".toUpperCase(),
                  onPressed: onPressedRetry,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
