import 'package:http/http.dart' as http;


/// DeleteRequest<Params>
/// * [T] is the params you should pass to function
abstract class DeleteRequest<T> {
  Future<http.Response> call(T params);
}
