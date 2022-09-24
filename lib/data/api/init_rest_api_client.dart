import 'dart:io';

import 'package:http/http.dart' as http;

import 'constants.dart';

http.Client initHttpClient() {
  return http.Client();
}

/// return a post request
http.MultipartRequest initPostRequest({required RequestType requestType, required String token}) {
  // build url according to request type
  final url = ApiConstants.buildUrl(requestType);

  // build post request
  final request = http.MultipartRequest("POST", Uri.parse(url));
  request.headers.addAll(
    {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  return request;
}

/// return a get response
Future<http.Response> initGetRequest(
    {required RequestType requestType, required String token}) async {
  // build url according to request type
  final url = ApiConstants.buildUrl(requestType);

  // build post request
  final response = await http.get(Uri.parse(url),headers: {
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  });


  return response;
}
