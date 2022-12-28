import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'app_button.dart';
import 'close_widget.dart';

class AppDialog extends StatelessWidget {
  final String title, buttonText;
  final String description;
  final Widget? image;
  final Function()? onPressed;
  final bool withCloseButton;
  final bool showAppVersion;
  final bool isLoadingDialog;

  const AppDialog({
    Key? key,
    this.description = "",
    this.title = "",
    this.buttonText = "",
    this.image,
    this.withCloseButton = true,
    this.onPressed,
    this.showAppVersion = false,
    this.isLoadingDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      elevation: Sizes.dimen_32,
      insetPadding: EdgeInsets.all(Sizes.dimen_10.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_10.w),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(Sizes.dimen_12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_16)),
        ),
        child: isLoadingDialog
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Center(
                    child: LoadingWidget(),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Close widget
                  if (withCloseButton)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CloseWidget(
                              onPressed: () => Navigator.of(context).pop()),
                        ),
                        SizedBox(
                          height: Sizes.dimen_5.h,
                        )
                      ],
                    ),

                  /// Details
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Logo Image
                      if (image != null) image!,

                      /// AppVersion
                      if (showAppVersion)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
                          child: Text(
                            'Version: 1.0.0',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: AppColor.accentColor),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      /// title
                      if (title.isNotEmpty)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Sizes.dimen_4.h),
                          child: Text(
                            title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: AppColor.primaryDarkColor,
                                    fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      /// Description
                      if (description.isNotEmpty)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
                          child: Text(
                            description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      /// Okay Button
                      AppButton(
                        text: buttonText.toUpperCase(),
                        /*constraints: BoxConstraints(
                    minWidth: ScreenUtil.screenWidth * 0.5,
                  ),*/
                        onPressed:
                            onPressed ?? () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
