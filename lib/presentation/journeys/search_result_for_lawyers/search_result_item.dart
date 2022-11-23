import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../domain/entities/screen_arguments/invite_lawyer_args.dart';

class SearchResultItem extends StatelessWidget {
  final LawyerEntity lawyerEntity;

  const SearchResultItem({
    Key? key,
    required this.lawyerEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            /// image
            ImageNameRatingWidget(
              imgUrl: lawyerEntity.profileImage,
              name: lawyerEntity.name,
              rating: lawyerEntity.rating.toDouble(),
              withRow: false,
              nameColor: AppColor.primaryDarkColor,
              ratedColor: AppColor.accentColor,
              unRatedColor: AppColor.primaryColor,
            ),

            /// description
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lawyerEntity.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${lawyerEntity.tasksCount} مهمة"),
                    AppButton(
                        text: "دعوة لمهمة",
                        padding: EdgeInsets.zero,
                        textStyle:
                            Theme.of(context).textTheme.caption!.copyWith(
                                  color: AppColor.accentColor,
                                ),
                        color: AppColor.primaryDarkColor,
                        onPressed: () {
                          _navigateToInviteLawyerScreen(
                            context,
                            lawyerId: lawyerEntity.id,
                          );
                        })
                  ],
                )
              ],
            ))
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
