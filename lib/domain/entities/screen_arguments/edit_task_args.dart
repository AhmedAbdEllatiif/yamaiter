import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/update_task/update_task_cubit.dart';

class EditTaskArguments {
  final UpdateTaskCubit? updateTaskCubit;
  final TaskEntity taskEntity;

  EditTaskArguments({this.updateTaskCubit, required this.taskEntity});
}
