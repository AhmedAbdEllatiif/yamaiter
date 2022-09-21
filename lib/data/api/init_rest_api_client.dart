import 'dart:io';

import 'package:http/http.dart' as http;

import 'constants.dart';

http.Client initHttpClient() {
  return http.Client();
}


/// return a post request
http.MultipartRequest initPostRequest(
    RequestType requestType, String token) {
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
