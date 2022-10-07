import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'constants.dart';

http.Client initHttpClient() {
  return http.Client();
}

/// return a post request
http.MultipartRequest initMultiPartPostRequest(
    {required RequestType requestType, required String token}) {
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

/// return a post request
Future<http.Response> initRawPostRequest(
    {required RequestType requestType, required Map<String,
        dynamic> body, required String token}) async {
  // build url according to request type
  final url = ApiConstants.buildUrl(requestType);

  // build post request
  final request = await http.post(Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body);


  return request;
}

/// return a get response
Future<http.Response> initGetRequest(
    {required RequestType requestType, required String token,String id = ""}) async {
  // build url according to request type
  final url = ApiConstants.buildUrl(requestType,id: id);

  // build post request
  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  });


  return response;
}
