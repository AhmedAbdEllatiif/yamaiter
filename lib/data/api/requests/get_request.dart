import 'package:http/http.dart' as http;


/// UseCase<Type,Params>
/// * [Type] is the return type
/// * [Params] is the params you should pass to function
abstract class GetRequest<String> {
  Future<http.Response> call(String userToken);
}
