import 'package:yamaiter/presentation/logic/cubit/delete_task/delete_task_cubit.dart';

class DeleteTaskArguments {
  final int taskId;

  final DeleteTaskCubit deleteTaskCubit;

  DeleteTaskArguments({
    required this.taskId,
    required this.deleteTaskCubit,
  });
}
