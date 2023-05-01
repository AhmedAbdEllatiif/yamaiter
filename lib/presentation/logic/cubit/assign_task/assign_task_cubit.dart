import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/payment_method.dart';
import 'package:yamaiter/data/models/tasks/pay_for_task_model.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/my_tasks/assign_task.dart';

part 'assign_task_state.dart';

class PaymentAssignTaskCubit extends Cubit<PaymentToAssignTaskState> {
  PaymentAssignTaskCubit() : super(PaymentToAssignTaskInitial());

  /// to assignTask
  void payToAssignTask({
    required PaymentMethod paymentMethod,
    required int userId,
    required TaskEntity taskEntity,
    required double value,
    required String token,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingPaymentToAssignTask());

    //==> init case
    final useCase = getItInstance<AssignTaskCase>();

    //==> init params
    final params = PayForTaskParams(
      payForTaskModel: PayForTaskModel(
        paymentMethod: paymentMethod,
        missionType: "task",
        lawyerId: userId,
        taskId: taskEntity.id,
        title: taskEntity.title,
        description: taskEntity.description,
        value: value,
      ),
      userToken: token,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold((appError) => _emitError(appError), (payEntity) {
      if (paymentMethod == PaymentMethod.kiosk) {
        _emitIfNotClosed(TaskAssignedSuccessfullyWithWallet());
      } else {
        _emitIfNotClosed(
          PaymentLinkToAssignTaskFetched(payEntity: payEntity),
        );
      }
    });
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedPayToAssignTask());
    } else if (appError.appErrorType == AppErrorType.insufficientWalletFund) {
      _emitIfNotClosed(InsufficientWalletFundToAssignTask());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToPayToAssignTask());
    } else {
      _emitIfNotClosed(ErrorWhilePaymentToAssignTask(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(PaymentToAssignTaskState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
