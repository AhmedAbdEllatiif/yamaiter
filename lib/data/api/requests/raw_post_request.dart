import 'package:http/http.dart' as http;


/// UseCase<Type,Params>
/// * [Type] is the return type
/// * [Params] is the params you should pass to function
abstract class RawPostRequest<Param1,Param2> {
  Future<http.Response> call(Param1 model,Param2 token);
}
