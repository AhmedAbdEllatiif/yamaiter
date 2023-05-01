import 'package:yamaiter/common/enum/payment_mission_type.dart';

import '../../../common/enum/payment_method.dart';

class CreateConsultationRequestModel {
  final PaymentMethod paymentMethod;
  final PaymentMissionType paymentMissionType;
  final double consultFees;
  final String title;
  final String description;
  final List<String> imageList;

  CreateConsultationRequestModel({
    required this.paymentMethod,
    required this.title,
    required this.paymentMissionType,
    required this.consultFees,
    required this.description,
    required this.imageList,
  });
}
