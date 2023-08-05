import '../data/task_entity.dart';

class TaskDetailsArguments {
  final int taskId;
  final bool isAlreadyApplied;

  TaskDetailsArguments({
    required this.taskId,
    required this.isAlreadyApplied,
  });
}
