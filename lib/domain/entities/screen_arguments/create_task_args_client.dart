import 'package:yamaiter/presentation/logic/client_cubit/create_task/create_task_client_cubit.dart';

class CreateTaskArgumentsClient {
  final CreateTaskClientCubit createTaskClientCubit;
  final bool goBackAfterSuccess;

  CreateTaskArgumentsClient({
    required this.createTaskClientCubit,
    required this.goBackAfterSuccess,
  });
}
