import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/delete_request.dart';
import 'package:yamaiter/data/params/delete_sos_params.dart';

import '../../constants.dart';

class DeleteSosRequest extends DeleteRequest<DeleteSosParams> {
  @override
  Future<http.Response> call(DeleteSosParams params) async {
    var response = await initDeleteRequest(
      requestType: RequestType.deleteSos,
      token: params.userToken,
      id: params.id.toString(),
    );
    return response;
  }
}
