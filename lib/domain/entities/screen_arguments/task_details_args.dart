import '../data/task_entity.dart';

class TaskDetailsArguments {
  final TaskEntity taskEntity;
  final bool isAlreadyApplied;

  TaskDetailsArguments({
    required this.taskEntity,
    required this.isAlreadyApplied,
  });
}
