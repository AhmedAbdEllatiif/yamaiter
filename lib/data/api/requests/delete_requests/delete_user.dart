import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/delete_request.dart';

import '../../../params/delete_user_params.dart';
import '../../request_type.dart';

class DeleteUserRequest extends DeleteRequest<DeleteUserParams> {
  @override
  Future<http.Response> call(DeleteUserParams params) async {
    var response = await initDeleteRequest(
      requestType: RequestType.deleteUser,
      token: params.userToken,
      id: params.userId.toString(),
    );
    return response;
  }
}
