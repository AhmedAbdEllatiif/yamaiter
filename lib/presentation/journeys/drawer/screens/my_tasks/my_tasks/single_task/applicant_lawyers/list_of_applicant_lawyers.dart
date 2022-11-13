import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/single_task/applicant_lawyers/applicant_laywer_item.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';

import '../../../../../../../../domain/entities/data/lawyer_entity.dart';
import '../../../../../../../logic/cubit/user_token/user_token_cubit.dart';

class ListOfApplicantLawyers extends StatelessWidget {
  final List<LawyerEntity> applicants;
  final int taskId;
  final AssignTaskCubit assignTaskCubit;

  const ListOfApplicantLawyers(
      {Key? key,
      required this.applicants,
      required this.taskId,
      required this.assignTaskCubit})
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
          assignTaskCubit: assignTaskCubit,
          lawyerEntity: applicants[index],
          onAssignPressed: () {
            _assignTask(context: context, lawyerId: applicants[index].id);
          },
        );
      },
    );
  }

  /// to assign a task to a lawyer
  void _assignTask({required BuildContext context, required int lawyerId}) {
    // user token
    final userToken = context.read<UserTokenCubit>().state.userToken;

    assignTaskCubit.assignTask(
      userId: lawyerId,
      taskId: taskId,
      token: userToken,
    );
  }
}
