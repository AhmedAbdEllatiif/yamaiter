import 'git_it_instance.dart';

import 'package:http/http.dart' as http;

import '../data/api/init_rest_api_client.dart';

Future init() async {
  ///************************ init ApiClient ********************************\\\

  /// RestApi
  getItInstance.registerFactory<http.Client>(() => initHttpClient());


}
