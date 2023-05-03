import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/api_constants.dart';
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/raw_post_request.dart';
import 'package:yamaiter/data/params/search_for_lawyer_params.dart';
import '../../request_type.dart';
class SearchForLawyerRequest
    extends RawPostRequest<SearchForLawyerParams, String> {
  @override
  Future<http.Response> call(SearchForLawyerParams params, String token) async {
    var response = await initRawPostRequest(
      requestType: RequestType.searchForLawyer,
      body: {},
      token: token,
      queryParams: {
        ApiParamsConstant.offset: params.offset.toString(),
        ApiParamsConstant.governorates: params.governorates,
      },
    );

    return response;
  }
}
