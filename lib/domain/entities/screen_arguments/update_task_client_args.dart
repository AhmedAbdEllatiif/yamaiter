import 'package:yamaiter/domain/entities/data/task_entity.dart';

import '../../../presentation/logic/client_cubit/update_task/update_task_client_cubit.dart';

class UpdateTaskClientArguments {
  final UpdateTaskClientCubit? updateTaskClientCubit;
  final TaskEntity taskEntity;

  UpdateTaskClientArguments({this.updateTaskClientCubit, required this.taskEntity});
}
