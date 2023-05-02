import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/api_constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import '../../../models/sos/create_sos/sos_request_model.dart';

import '../../request_type.dart';

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
