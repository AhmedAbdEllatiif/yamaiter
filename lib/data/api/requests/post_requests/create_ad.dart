import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/models/ads/create_ad_request_model.dart';

class CreateAdRequest extends RawPostRequest<CreateAdRequestModel, String> {
  @override
  Future<http.Response> call(CreateAdRequestModel model, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.createAd,
      body: model.toJson(),
      token: token,
    );

    return response;
  }
}
