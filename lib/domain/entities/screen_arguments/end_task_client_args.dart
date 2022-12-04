import '../../../presentation/logic/client_cubit/end_task_client/end_task_client_cubit.dart';

class EndTaskClientArguments {
  final int taskId;
  final EndTaskClientCubit endTaskClientCubit;

  EndTaskClientArguments({
    required this.taskId,
    required this.endTaskClientCubit,
  });
}
