import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/logic/client_cubit/delete_task_client/delete_task_client_cubit.dart';

import '../../../presentation/logic/client_cubit/assign_task/assign_task_client_cubit.dart';
import '../../../presentation/logic/client_cubit/update_task/update_task_client_cubit.dart';

class SingleTaskClientArguments {
  final TaskEntity taskEntity;
  final AssignTaskClientCubit assignTaskClientCubit;
  final DeleteTaskClientCubit deleteTaskClientCubit;
  final UpdateTaskClientCubit updateTaskClientCubit;

  SingleTaskClientArguments({
    required this.assignTaskClientCubit,
    required this.deleteTaskClientCubit,
    required this.updateTaskClientCubit,
    required this.taskEntity,
  });
}
