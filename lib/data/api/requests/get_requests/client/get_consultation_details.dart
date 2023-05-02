import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/client/get_consultation_details.dart';

import '../../../request_type.dart';

class GetConsultationDetailsRequest
    extends GetRequest<GetConsultationDetailsParams> {
  @override
  Future<http.Response> call(GetConsultationDetailsParams params) async {
    var response = await initGetRequest(
      requestType: RequestType.singleTaskClient,
      token: params.userToken,
      id: params.consultationId.toString(),
    );
    return response;
  }
}
