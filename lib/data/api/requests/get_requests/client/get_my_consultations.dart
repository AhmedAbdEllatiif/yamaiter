import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/client/get_my_consultations_params.dart';

import '../../../api_constants.dart';
import '../../../request_type.dart';

class GetMyConsultationsRequest extends GetRequest<GetMyConsultationParams> {
  @override
  Future<http.Response> call(GetMyConsultationParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.myConsultations,
        token: params.userToken,
        queryParams: {
          ApiParamsConstant.offset: params.offset.toString(),
        });
    return response;
  }
}
