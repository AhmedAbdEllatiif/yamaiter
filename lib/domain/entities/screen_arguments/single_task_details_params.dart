import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/logic/common/check_payment_status/check_payment_status_cubit.dart';

import '../../../presentation/logic/cubit/delete_task/delete_task_cubit.dart';
import '../../../presentation/logic/cubit/update_task/update_task_cubit.dart';

class MySingleTaskArguments {
  final int taskId;
  final CheckPaymentStatusCubit? checkPaymentStatusCubit;
  final UpdateTaskCubit? updateTaskCubit;
  final DeleteTaskCubit? deleteTaskCubit;

  MySingleTaskArguments({
    required this.taskId,
    this.checkPaymentStatusCubit,
    this.updateTaskCubit,
    this.deleteTaskCubit,
  });
}
