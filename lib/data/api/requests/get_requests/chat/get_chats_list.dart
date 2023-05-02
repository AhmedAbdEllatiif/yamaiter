import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';
import 'package:yamaiter/data/params/chat/fetch_chats_lists_params.dart';

import '../../../request_type.dart';

class GetChatListRequest extends GetRequest<FetchChatsListParams> {
  @override
  Future<http.Response> call(FetchChatsListParams params) async {
    var response = await initGetRequest(
      requestType: RequestType.chatList,
      token: params.userToken,
    );
    return response;
  }
}
