import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/store_fb_token_request_model.dart';
import 'package:yamaiter/data/params/store_fb_token.dart';
import '../../request_type.dart';
class StoreFirebaseTokenRequest
    extends RawPostRequest<StoreFirebaseTokenParams, String> {
  @override
  Future<http.Response> call(
      StoreFirebaseTokenParams params, String token) async {
    final requestModel =
        StoreFirebaseTokenRequestModel.fromParams(params: params);

    var response = await initRawPostRequest(
      requestType: RequestType.firebaseToken,
      body: requestModel.toJson(),
      token: token,
    );

    return response;
  }
}
