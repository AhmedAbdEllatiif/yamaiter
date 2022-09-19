import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/logic/pick_images/pick_image_cubit.dart';
import 'package:yamaiter/presentation/logic/pick_images/pick_image_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';

class UploadIdImageWidget extends StatelessWidget {
  final Function() onPressed;

  const UploadIdImageWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickImageCubit, PickImageState>(
      builder: (context, state) {
        // Column of: Container and error text
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // the full container
            Container(
              constraints: BoxConstraints(minHeight: Sizes.dimen_28.h),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                border: Border.all(color: getBorderColor(state)),
                borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
              ),
              child: Material(
                color: Colors.transparent,

                // inkwell
                child: InkWell(
                  splashColor: AppColor.accentColor,
                  hoverColor: AppColor.accentColor,
                  borderRadius: BorderRadius.circular(AppUtils.cornerRadius.w),
                  onTap: onPressed,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),

                    // row of title and icon
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // text title
                        const Expanded(
                          child: Text(
                            "إرفاق صورة كارنيه النقابة ",
                            style: TextStyle(color: AppColor.white),
                          ),
                        ),

                        // icon with picked image name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //==> icon
                              getIcon(state),

                              //==> text image name
                              if (state is ImagePicked)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    getPickedImageName(state),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: AppColor.accentColor,
                                        ),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// error text
            if (state is NoImageSelected || state is ErrorWhilePickingImage)
              Padding(
                padding: EdgeInsets.only(
                    top: Sizes.dimen_2.h, right: Sizes.dimen_10.w,),
                child: Text(
                  getErrorText(state),
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.accentColor,
                      ),
                ),
              )
          ],
        );
      },
    );
  }


  Widget getIcon(PickImageState state){
    return state is ImagePicked ? Center(
      child: Icon(
        getIconData(state),
        color: getIconColor(state),
      ),
    ):Icon(
      getIconData(state),
      color: getIconColor(state),
    );
  }

  /// return icon color
  Color? getIconColor(PickImageState state) =>
      state is ImagePicked ? AppColor.accentColor : AppColor.white;

  /// return the border color
  Color getBorderColor(PickImageState state) =>
      state is NoImageSelected || state is ErrorWhilePickingImage
          ? AppColor.red
          : Colors.transparent;

  /// return the icon data
  IconData? getIconData(PickImageState state) =>
      state is ImagePicked ? Icons.image_outlined : Icons.cloud_upload_outlined;

  /// return picked image name
  String getPickedImageName(PickImageState state) =>
      state is ImagePicked ? state.image.name : "";

  ///  return the error text
  String getErrorText(PickImageState state) {
    if (state is NoImageSelected) {
      return "* من فضلك اختر صورة";
    }

    if (state is ErrorWhilePickingImage) {
      return "* حاول اختيار صورة اخرى";
    }
    return "";
  }
}
