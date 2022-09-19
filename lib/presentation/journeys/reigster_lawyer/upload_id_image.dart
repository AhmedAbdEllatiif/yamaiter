import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';

class UploadIdImageWidget extends StatelessWidget {
  final Function() onPressed;
  const UploadIdImageWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
      ),
      constraints: BoxConstraints(
          minHeight: Sizes.dimen_28.h
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColor.accentColor,
          hoverColor: AppColor.accentColor,
          borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
          onTap: onPressed,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "إرفاق صورة كارنيه النقابة ",
                  style: TextStyle(color: AppColor.white),
                ),

                const Icon(Icons.cloud_upload_outlined,color: AppColor.white,)
              ],
            ),
          ),
          /*child: Stack(
            children: [

              // this text is fake to make is the same height as
              // other text fields in the registration page
              const AppTextField(label: "",enabled: false,),

              Positioned(
                bottom: 0.0,
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "إرفاق صورة كارنيه النقابة ",
                        style: TextStyle(color: AppColor.white),
                      ),

                      const Icon(Icons.cloud_upload_outlined,color: AppColor.white,)
                    ],
                  ),
                ),
              ),

            ],
          ),*/
        ),
      ),
    );
  }
}
