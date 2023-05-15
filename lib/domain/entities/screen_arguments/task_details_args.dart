import '../data/task_entity.dart';

class TaskDetailsArguments {
  final TaskEntity? taskEntity;
  final int? taskId;
  final bool isAlreadyApplied;

  TaskDetailsArguments({
     this.taskEntity,
     this.taskId,
    required this.isAlreadyApplied,
  });
}
