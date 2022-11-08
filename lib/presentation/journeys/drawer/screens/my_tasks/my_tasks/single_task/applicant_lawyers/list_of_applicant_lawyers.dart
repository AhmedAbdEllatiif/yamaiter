import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/single_task/applicant_lawyers/applicant_laywer_item.dart';

import '../../../../../../../../domain/entities/data/lawyer_entity.dart';

class ListOfApplicantLawyers extends StatelessWidget {
  final List<LawyerEntity> applicants;

  const ListOfApplicantLawyers({Key? key, required this.applicants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: applicants.length,

      /// separator
      separatorBuilder: (context, index) => SizedBox(
        height: Sizes.dimen_5.h,
      ),

      /// item
      itemBuilder: (context, index) {
        return ApplicantLawyerItem(
          lawyerEntity: applicants[index],
        );
      },
    );
  }
}
