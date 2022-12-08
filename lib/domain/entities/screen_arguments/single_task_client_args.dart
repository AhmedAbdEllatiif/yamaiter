import 'package:yamaiter/presentation/logic/client_cubit/delete_task_client/delete_task_client_cubit.dart';

import '../../../presentation/logic/client_cubit/assign_task/assign_task_client_cubit.dart';

class SingleTaskClientArguments {
  final int taskId;
  final AssignTaskClientCubit assignTaskClientCubit;
  final DeleteTaskClientCubit deleteTaskClientCubit;

  SingleTaskClientArguments({
    required this.assignTaskClientCubit,
    required this.deleteTaskClientCubit,
    required this.taskId,
  });
}
