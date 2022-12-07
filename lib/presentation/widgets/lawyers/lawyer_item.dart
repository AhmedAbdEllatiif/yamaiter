import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/screen_arguments/invite_lawyer_args.dart';
import '../../../router/route_helper.dart';
import '../../themes/theme_color.dart';
import '../image_name_rating_widget.dart';
import '../rounded_text.dart';

class LawyerItem extends StatelessWidget {
  final LawyerEntity lawyer;

  const LawyerItem({Key? key, required this.lawyer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// image
            ImageNameRatingWidget(
              imgUrl: lawyer.profileImage,
              name: lawyer.name,
              rating: lawyer.rating.toDouble(),
              withRow: false,
              nameColor: AppColor.primaryDarkColor,
              ratedColor: AppColor.accentColor,
              unRatedColor: AppColor.primaryColor,
              iconRateSize: Sizes.dimen_12.w,
              minImageSize: Sizes.dimen_40,
              maxImageSize: Sizes.dimen_40,
            ),

            /// description
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    lawyer.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(height: 1.3),
                  )),

                  /// tasksCount , button
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${lawyer.tasksCount} مهمة",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(height: .5),
                      ),
                      RoundedText(
                          text: "دعوة لمهمة",
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          textStyle:
                              Theme.of(context).textTheme.caption!.copyWith(
                                    color: AppColor.accentColor,
                                  ),
                          // color: AppColor.primaryDarkColor,
                          onPressed: () {
                            _navigateToInviteLawyerScreen(
                              context,
                              lawyerId: lawyer.id,
                            );
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToInviteLawyerScreen(BuildContext context,
      {required int lawyerId}) {
    RouteHelper().inviteLawyer(context,
        inviteLawyerArguments: InviteLawyerArguments(
          lawyerId: lawyerId,
        ));
  }
}
