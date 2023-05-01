import 'package:yamaiter/common/enum/payment_method.dart';

class PayForTaskModel {
  final PaymentMethod paymentMethod;
  final String missionType;
  final String title;
  final num value;
  final String description;
  final int lawyerId;
  final int taskId;

  PayForTaskModel({
    required this.paymentMethod,
    required this.missionType,
    required this.title,
    required this.value,
    required this.description,
    required this.lawyerId,
    required this.taskId,
  });

  Map<String, dynamic> toJson() {
    return {
      "method": paymentMethod.toShortString(),
      "mission_type": "task",
      "mission_id": taskId.toString(),
      "name": title,
      "amount_cents": value.toString(),
      "description": description,
      "user_id": lawyerId.toString(),
    };
  }
}
