import 'package:http/http.dart' as http;

class RestApiMethods {
  final http.Client restApiClient;

  const RestApiMethods({required this.restApiClient});
}
