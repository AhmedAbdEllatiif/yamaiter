import '../api/rest_http_methods.dart';

abstract class RemoteDataSource {}

class RemoteDataSourceImpl extends RemoteDataSource {
  final RestApiMethods restApiMethods;

  RemoteDataSourceImpl({required this.restApiMethods});
}
