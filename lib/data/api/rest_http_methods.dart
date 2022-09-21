import 'package:http/http.dart' as http;

import 'constants.dart';

class RestApiMethods {
  final http.Client restApiClient;

  const RestApiMethods({required this.restApiClient});
/*

  /// Post method for authentication with cognito
  Future<http.Response> postMethod(
      {required Object body,required String token}) async {
    var url = Uri.https(ApiConstants.baseUrl, "");
    final response = await http
        .post(
      url,
      headers: <String, String>{
        'Accept': "application/json",
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    //.timeout(const Duration(seconds: 15));
    return response;
  }
  Future<http.Response> postRequest(
      {required Object body,required String token}) async {
    var request =
    http.MultipartRequest("POST", Uri.parse(urlToInsertImage));
    request
    //.timeout(const Duration(seconds: 15));
    return response;
  }
  /// Get method for rest api
  Future<http.Response> getMethod({
    required String endPoint,
    required String userToken,
  }) async {
    var url = Uri.https("api.adzily.io", "/v1/dev/$endPoint");
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': userToken,
      },
    );
    return response;
  }*/
}
