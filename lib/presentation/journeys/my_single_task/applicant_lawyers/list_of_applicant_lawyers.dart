import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/enum/payment_method.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';

import '../../../../../../../../common/functions/show_choose_payment_method_dialog.dart';
import '../../../../../../../../domain/entities/data/lawyer_entity.dart';
import 'applicant_laywer_item.dart';

class ListOfApplicantLawyers extends StatelessWidget {
  final List<LawyerEntity> applicants;
  final TaskEntity taskEntity;
  final PaymentAssignTaskCubit payToAssignTaskCubit;

  const ListOfApplicantLawyers(
      {Key? key,
      required this.applicants,
      required this.taskEntity,
      required this.payToAssignTaskCubit})
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
          assignTaskCubit: payToAssignTaskCubit,
          lawyerEntity: applicants[index],
          onAssignPressed: (valueOfferedByAppliedLawyer) {
            showChoosePaymentMethodDialog(context,
                onPaymentMethodSelected: (paymentMethod) {
                  log("PaymentMethod >> $paymentMethod");
              showAppDialog(
                context,
                message: "عمولة يامتر ${taskEntity.costCommission} ",
                buttonText: "اسناد المهمة",
                onPressed: () {
                  Navigator.pop(context);
                  _payToAssignTask(
                    paymentMethod: paymentMethod,
                    context: context,
                    lawyerId: applicants[index].id,
                    value: valueOfferedByAppliedLawyer,
                  );
                },
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
    required PaymentMethod paymentMethod,
    required int lawyerId,
    required double value,
  }) {
    payToAssignTaskCubit.payToAssignTask(
      paymentMethod: paymentMethod,
      userId: lawyerId,
      taskEntity: taskEntity,
      value: value,
      token: getUserToken(context),
    );
  }
}
