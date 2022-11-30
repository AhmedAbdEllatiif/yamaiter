import 'package:yamaiter/data/models/tasks/client/create_task_request_model_client.dart';

class CreateTaskParamsClient {
  final CreateTaskRequestModelClient createTaskRequestModelClient;
  final String userToken;

  CreateTaskParamsClient({
    required this.createTaskRequestModelClient,
    required this.userToken,
  });
}
