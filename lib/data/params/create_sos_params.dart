import 'package:yamaiter/data/models/sos/sos_request_model.dart';

class CreateSosParams {
  final SosRequestModel sosRequestModel;
  final String token;

  CreateSosParams({required this.sosRequestModel, required this.token});
}
