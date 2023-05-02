import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/accept_terms/accept_terms_request_model.dart';

import '../../request_type.dart';

class AcceptTermsRequest extends RawPostRequest<AcceptTermsModel, String> {
  @override
  Future<http.Response> call(AcceptTermsModel params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.acceptTerms,
      body: params.toJson(),
      token: token,
    );

    return response;
  }
}
