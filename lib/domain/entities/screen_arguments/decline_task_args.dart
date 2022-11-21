import 'package:yamaiter/presentation/logic/cubit/decline_invited_task/decline_task_cubit.dart';

class DeclineTaskArguments {
  final int taskId;
  final DeclineTaskCubit? declineTaskCubit;

  DeclineTaskArguments({
    required this.taskId,
    this.declineTaskCubit,
  });
}
