import '../../../presentation/logic/client_cubit/delete_task_client/delete_task_client_cubit.dart';

class DeleteTaskClientArguments {
  final int taskId;
  final DeleteTaskClientCubit deleteTaskClientCubit;

  DeleteTaskClientArguments({
    required this.taskId,
    required this.deleteTaskClientCubit,
  });
}
