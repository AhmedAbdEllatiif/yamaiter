import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';

import '../../../../../common/constants/app_utils.dart';
import '../../../../../common/constants/assets_constants.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/download_file_widget.dart';

class TaxItem extends StatelessWidget {
  final TaxEntity taxEntity;
  final bool isCompleted;

  const TaxItem({Key? key, required this.taxEntity, required this.isCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_14.w, vertical: Sizes.dimen_8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// name and date
            SvgPicture.asset(
              AssetsImages.documentsSvg,
              height: Sizes.dimen_40.w,
              width: Sizes.dimen_40.w,
              color: AppColor.primaryDarkColor,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    // name
                    Text(
                      taxEntity.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          height: 1.2,
                          color: AppColor.primaryDarkColor,
                          fontWeight: FontWeight.bold),
                    ),

                    Text(
                      taxEntity.createdAt,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.2,
                          color: AppColor.primaryDarkColor,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),

            /// button
            if(isCompleted)
              DownloadFileWidget(
                text: "تحميل ملف الاقرار",
                fileName: taxEntity.adminFileName,
                fileUrl: taxEntity.fileToDownload,
              ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: AppColor.accentColor,
            //         borderRadius: BorderRadius.circular(AppUtils.cornerRadius)),
            //     padding: EdgeInsets.symmetric(
            //         horizontal: Sizes.dimen_12.w, vertical: 2),
            //     child: Text(
            //       "تحميل ملف الاقرار",
            //       style: Theme.of(context)
            //           .textTheme
            //           .caption!
            //           .copyWith(color: AppColor.primaryDarkColor),
            //     ),
            //   ),
            // ),


            if(!isCompleted)const Padding(
              padding: EdgeInsets.only(right: 5.5),
              child: Icon(
                Icons.keyboard_double_arrow_left_outlined,
                color: AppColor.primaryDarkColor,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
