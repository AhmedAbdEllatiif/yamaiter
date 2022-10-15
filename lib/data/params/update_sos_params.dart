import 'package:yamaiter/data/models/sos/create_sos/sos_request_model.dart';

class UpdateSosParams {
  final SosRequestModel sosRequestModel;
  final String token;
  final int sosId;

  UpdateSosParams(
      {required this.sosId,
      required this.sosRequestModel,
      required this.token});
}
