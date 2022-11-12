import '../../../presentation/logic/cubit/assign_task/assign_task_cubit.dart';

class SingleTaskArguments {
  final int taskId;
  final AssignTaskCubit assignTaskCubit;

  SingleTaskArguments({required this.assignTaskCubit, required this.taskId});
}
