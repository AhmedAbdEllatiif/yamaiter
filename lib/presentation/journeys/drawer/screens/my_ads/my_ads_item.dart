import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/ad_status.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';

import '../../../../../common/screen_utils/screen_util.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/cached_image_widget.dart';
import 'ad_status_widget.dart';
import 'ad_text_data_widget.dart';

class MyAdItem extends StatelessWidget {
  final AdEntity adEntity;

  const MyAdItem({Key? key, required this.adEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("AdImage >> ${adEntity.image}");
    return Column(
      children: [
        /// data
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12.0,
          ),
          child: Column(
            children: [
              // status , price
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // //==> status
                  // Expanded(
                  //   child: AddTextData(
                  //     text: "الحالة",
                  //     value: adEntity.status.toShortString(),
                  //   ),
                  // ),

                  //==> price
                  Expanded(
                    child: AddTextData(
                      text: "التكلفة:",
                      value: adEntity.price.toString(),
                    ),
                  ),

                  //==> period
                  Expanded(
                    child: AddTextData(
                      text: "المدة بالايام:",
                      value: adEntity.period.toString(),
                    ),
                  ),

                  //==> price
                  Expanded(
                    child: AddTextData(
                      text: "", //"الصفحة",
                      value: adEntity.pages,
                    ),
                  ),

                  //==> date
                  Expanded(
                    child: AddTextData(
                      text: "", //"التاريخ:",
                      value: adEntity.createdAt,
                    ),
                  ),
                ],
              ),
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     //==> period
              //     Expanded(
              //       child: AddTextData(
              //         text: "المدة بالايام",
              //         value: adEntity.period.toString(),
              //       ),
              //     ),
              //
              //     //==> price
              //     Expanded(
              //       child: AddTextData(
              //         text: "الصفحة",
              //         value: adEntity.pages,
              //       ),
              //     ),
              //   ],
              // ),
              //
              // Row(
              //   children: [
              //     Expanded(
              //       child: AddTextData(
              //         text: "التاريخ",
              //         value: adEntity.createdAt,
              //       ),
              //     ),
              //
              //     // Expanded(
              //     //   child: AddTextData(
              //     //     text: "العنوان",
              //     //     value: adEntity.url,
              //     //   ),
              //     // ),
              //   ],
              // ),
              //
              //
            ],
          ),
        ),

        /// image
        //if (adEntity.image != AppUtils.undefined)
        ClipRRect(
          // borderRadius: BorderRadius.only(
          //   topRight: Radius.circular(AppUtils.cornerRadius.w),
          //   topLeft: Radius.circular(AppUtils.cornerRadius.w),
          // ),
          child: Stack(
            children: [
              CachedImageWidget(
                imageUrl: adEntity.image,
                height: ScreenUtil.screenHeight * 0.15,
                width: double.infinity,
                isCircle: false,
                progressBarScale: 0.2,
              ),

              /// AdStatusWidget
              AdStatusWidget(
                adStatus: adEntity.status,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
