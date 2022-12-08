import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/consultation_details_args.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../../common/constants/sizes.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/rounded_text.dart';
import '../../../../../widgets/text_with_icon.dart';

class MyConsultationItem extends StatelessWidget {
  final ConsultationEntity consultationEntity;

  const MyConsultationItem({
    Key? key,
    required this.consultationEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
            left: Sizes.dimen_8.w,
            right: Sizes.dimen_8.w,
            bottom: Sizes.dimen_8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consultationEntity.type,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 3,
                        ),
                  ),

                  /// description
                  Text(
                    consultationEntity.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.normal,
                          height: 1.3,
                        ),
                  ),

                  /// createAt
                  TextWithIconWidget(
                    iconData: Icons.date_range_outlined,
                    text: consultationEntity.createdAt,
                  )
                ],
              ),
            ),

            ///==> readMore
            RoundedText(
              text: "اقرأ المزيد",
              background: AppColor.accentColor,
              onPressed: () => _navigateToConsultationDetailsScreen(context),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToConsultationDetailsScreen(BuildContext context) {
    RouteHelper().consultationDetails(context,arguments: ConsultationDetailsArguments(consultationEntity: consultationEntity));
  }
}
