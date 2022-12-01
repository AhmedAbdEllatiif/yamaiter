import 'package:yamaiter/data/models/create_consultation_request_model.dart';

class CreateConsultationParams {
  final CreateConsultationRequestModel requestModel;
  final String token;

  CreateConsultationParams({
    required this.requestModel,
    required this.token,
  });
}
