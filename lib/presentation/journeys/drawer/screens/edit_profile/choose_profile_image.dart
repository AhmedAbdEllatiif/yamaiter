import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_authoried_user.dart';

import '../../../../../common/screen_utils/screen_util.dart';
import '../../../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/cached_image_widget.dart';

class ChooseProfileImageWidget extends StatefulWidget {
  const ChooseProfileImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseProfileImageWidget> createState() =>
      _ChooseProfileImageWidgetState();
}

class _ChooseProfileImageWidgetState extends State<ChooseProfileImageWidget> {
  late final String _currentUserImage;

  @override
  void initState() {
    super.initState();
    _currentUserImage = getAuthorizedUserEntity(context).userAvatar;
    log("_currentUserImage $_currentUserImage");
  }

  /// the key board status
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      // on tap choose new image
      onTap: () => context.read<PickImageCubit>().pickSingleImage(),

      // child
      child: BlocBuilder<PickImageCubit, PickImageState>(
          builder: (context, state) {
        if (state is ImagePicked) {
          return AnimatedContainer(
            margin: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.05),
            height: !isKeyboard ? Sizes.dimen_120 : Sizes.dimen_60,
            width: !isKeyboard ? Sizes.dimen_120 : Sizes.dimen_60,
            duration: const Duration(milliseconds: 500),
            child: CircleAvatar(
              backgroundImage: FileImage(
                File(state.image.path),
              ),
            ),
          );
          //return Image.file(File(state.image.path));
        }

        return Column(
          children: [
            AnimatedContainer(
              margin: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.05),
              height: !isKeyboard ? Sizes.dimen_120 : Sizes.dimen_60,
              width: !isKeyboard ? Sizes.dimen_120 : Sizes.dimen_60,
              duration: const Duration(milliseconds: 500),
              child: CachedImageWidget(
                imageUrl: _currentUserImage,
                height: Sizes.dimen_120.w,
                width: Sizes.dimen_120.w,
                isCircle: true,
                progressBarScale: 0.5,
                errorWidget: Icon(
                  Icons.person_outline_rounded,
                  color: AppColor.primaryDarkColor,
                  size: Sizes.dimen_100.w,
                ),
              ),
            ),
            Text(
              "تعديل صورة البروفايل",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColor.primaryDarkColor,
                  ),
            )
          ],
        );
      }),
    );
  }
}
