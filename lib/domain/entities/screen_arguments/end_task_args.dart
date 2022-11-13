import 'package:yamaiter/presentation/logic/cubit/end_task/end_task_cubit.dart';

class EndTaskArguments {
  final int taskId;
  final EndTaskCubit endTaskCubit;

  EndTaskArguments({
    required this.taskId,
    required this.endTaskCubit,
  });
}
