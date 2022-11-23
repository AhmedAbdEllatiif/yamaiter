import 'package:yamaiter/presentation/logic/cubit/create_task/create_task_cubit.dart';

class CreateTaskArguments {
  final CreateTaskCubit createTaskCubit;
  final bool goBackAfterSuccess;

  CreateTaskArguments({
    required this.createTaskCubit,
    required this.goBackAfterSuccess,
  });
}
