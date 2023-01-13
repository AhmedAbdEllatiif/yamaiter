import 'package:yamaiter/data/models/consultations/create_consultation_request_model.dart';

class PayForConsultationParams {
  final CreateConsultationRequestModel requestModel;
  final String token;

  PayForConsultationParams({
    required this.requestModel,
    required this.token,
  });
}
