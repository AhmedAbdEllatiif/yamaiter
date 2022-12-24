import '../models/tasks/pay_for_task_model.dart';

class PayForTaskParams {
  final String userToken;
  final PayForTaskModel payForTaskModel;

  PayForTaskParams({
    required this.userToken,
    required this.payForTaskModel,
  });
}
