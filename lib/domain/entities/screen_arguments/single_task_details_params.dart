import 'package:yamaiter/domain/entities/data/task_entity.dart';

import '../../../presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import '../../../presentation/logic/cubit/delete_task/delete_task_cubit.dart';
import '../../../presentation/logic/cubit/update_task/update_task_cubit.dart';

class SingleTaskArguments {
  final TaskEntity taskEntity;
  final PaymentAssignTaskCubit assignTaskCubit;
  final UpdateTaskCubit updateTaskCubit;
  final DeleteTaskCubit deleteTaskCubit;

  SingleTaskArguments({
    required this.taskEntity,
    required this.assignTaskCubit,
    required this.updateTaskCubit,
    required this.deleteTaskCubit,
  });
}
