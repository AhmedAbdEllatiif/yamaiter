import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import '../../../models/sos/sos_request_model.dart';

class CreateSosRequest extends RawPostRequest<SosRequestModel, String> {
  @override
  Future<http.Response> call(SosRequestModel model, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.distresses,
      body: model.toJson(),
      token: token,
    );

    return response;
  }
}
