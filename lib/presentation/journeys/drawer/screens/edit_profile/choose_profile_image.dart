import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';


import '../../../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../themes/theme_color.dart';

class ChooseProfileImageWidget extends StatelessWidget {
  const ChooseProfileImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // on tap choose new image
      onTap: () => context.read<PickImageCubit>().pickSingleImage(),

      // child
      child: BlocBuilder<PickImageCubit, PickImageState>(
          builder: (context, state) {
        if (state is ImagePicked) {
          return CircleAvatar(
            minRadius: Sizes.dimen_70.w,
            maxRadius: Sizes.dimen_100.w,
            backgroundImage: FileImage(
              File(state.image.path),
            ),
          );
          //return Image.file(File(state.image.path));
        }

        return Column(
          children: [
            Icon(
              Icons.person,
              color: AppColor.primaryDarkColor,
              size: Sizes.dimen_130.w,
            ),
            Text(
              "تعديل صورة البروفايل",
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: AppColor.primaryDarkColor,
                  ),
            )
          ],
        );
      }),
    );
  }
}
