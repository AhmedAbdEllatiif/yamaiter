import 'package:http/http.dart' as http;
import 'package:yamaiter/data/api/request_type.dart';

http.Client initHttpClient() {
  return http.Client();
}

///
///
/// return a post request
http.MultipartRequest initMultiPartPostRequest(
    {required RequestType requestType, required String token, String id = ""}) {
  // build url according to request type
  final url = requestType.toUriString(id: id);

  // build post request
  final request = http.MultipartRequest("POST", url);
  request.headers.addAll(
    {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  return request;
}

///
///
/// return a post request
Future<http.Response> initRawPostRequest(
    {required RequestType requestType,
    required Map<String, dynamic> body,
    Map<String, String> queryParams = const {"": ""},
    String id = "",
    required String token}) async {
  // build url according to request type
  final url = requestType.toUriString(id: id, queryParams: queryParams);

  // build post request
  final request = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body);

  return request;
}

///
///
/// return a get response
Future<http.Response> initGetRequest({
  required RequestType requestType,
  required String token,
  String id = "",
  Map<String, String> queryParams = const {"": ""},
}) async {
  // build url according to request type
  final url = requestType.toUriString(id: id, queryParams: queryParams);

  // build post request
  final response = await http.get(url, headers: {
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  });

  return response;
}

///
///
/// return a delete response
Future<http.Response> initDeleteRequest(
    {required RequestType requestType,
    required String token,
    String id = ""}) async {
  // build url according to request type
  final url = requestType.toUriString(id: id);

  // build post request
  final response = await http.delete(url, headers: {
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  });

  return response;
}
