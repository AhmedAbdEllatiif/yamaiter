import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/payment_args.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/single_task/applicant_lawyers/applicant_laywer_item.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../../../../domain/entities/data/lawyer_entity.dart';
import '../../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../../widgets/app_logo.dart';

class ListOfApplicantLawyers extends StatelessWidget {
  final List<LawyerEntity> applicants;
  final TaskEntity taskEntity;
  final PaymentAssignTaskCubit assignTaskCubit;

  const ListOfApplicantLawyers(
      {Key? key,
      required this.applicants,
      required this.taskEntity,
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
          onAssignPressed: (valueOfferedByAppliedLawyer) {
            showAppDialog(context,
                message: "عمولة يامتر ${taskEntity.costCommission} ",
                buttonText: "اسناد المهمة", onPressed: () {
              _payToAssignTask(
                context: context,
                lawyerId: applicants[index].id,
                value: valueOfferedByAppliedLawyer,
              );
            });
          },
        );
      },
    );
  }

  /// to assign a task to a lawyer
  void _payToAssignTask({
    required BuildContext context,
    required int lawyerId,
    required double value,
  }) {log("Heeeeeeereeee");
    // user token
    final userToken = context.read<UserTokenCubit>().state.userToken;

    assignTaskCubit.payToAssignTask(
      userId: lawyerId,
      taskEntity: taskEntity,
      value: value,
      token: userToken,
    );
  }
}
