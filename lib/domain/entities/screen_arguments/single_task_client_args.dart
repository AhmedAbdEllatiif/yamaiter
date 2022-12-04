import '../../../presentation/logic/client_cubit/assign_task/assign_task_client_cubit.dart';

class SingleTaskClientArguments {
  final int taskId;
  final AssignTaskClientCubit assignTaskClientCubit;

  SingleTaskClientArguments({
    required this.assignTaskClientCubit,
    required this.taskId,
  });
}
