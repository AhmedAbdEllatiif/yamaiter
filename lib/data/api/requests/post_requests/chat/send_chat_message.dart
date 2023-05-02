import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/init_rest_api_client.dart';
import 'package:yamaiter/data/api/requests/multi_part_post_request.dart';

import '../../../../params/chat/send_chat_message.dart';
import '../../../request_type.dart';
class SendChatMessageRequest
    extends MultiPartPostRequest<SendChatMessageParams> {
  @override
  Future<http.MultipartRequest> call(SendChatMessageParams params) async {
    var request = initMultiPartPostRequest(
      requestType: RequestType.chatRoom,
      token: params.userToken,
      id: params.chatId.toString(),
    );

    request.fields["content"] = params.sendChatModelRequest.content;

    // init filePath
    final filePath = params.sendChatModelRequest.filePath;

    // add file to the request if filePath is not empty
    if (filePath.isNotEmpty) {
      // create MultipartFile to add to files with request
      final file = fileMessageToUpload(params.sendChatModelRequest.filePath);

      // add file to upload
      request.files.add(file);
    }

    // return a request
    return request;
  }

  /// to return a file to upload
  http.MultipartFile fileMessageToUpload(String filePath) {
    http.MultipartFile fileToUpload = http.MultipartFile.fromBytes(
      "file", // field name
      File(filePath).readAsBytesSync(),
      filename: filePath,
    );

    // return the a MultipartFile
    return fileToUpload;
  }
}
