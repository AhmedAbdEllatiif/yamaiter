import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/apply_for_task/apply_for_task_cubit.dart';

class InvitedTaskDetailsArguments {
  final TaskEntity taskEntity;
  final ApplyForTaskCubit applyForTaskCubit;

  InvitedTaskDetailsArguments({
    required this.taskEntity,
    required this.applyForTaskCubit,
  });
}
