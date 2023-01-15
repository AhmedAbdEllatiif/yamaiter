import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/get_request.dart';

import '../../../../params/chat_room_by_id_params.dart';
import '../../../constants.dart';


class GetChatRoom extends GetRequest<ChatRoomByIdParams> {
  @override
  Future<http.Response> call(ChatRoomByIdParams params) async {
    var response = await initGetRequest(
        requestType: RequestType.chatRoom,
        token: params.userToken,
        id: params.chatId.toString(),
       );
    return response;
  }
}
