import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/api/requests/loginRequest.dart';
import 'package:yamaiter/data/api/requests/registerLawyerRequest.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';

import '../../domain/entities/app_error.dart';
import '../api/rest_http_methods.dart';
import '../models/auth/login/login_request.dart';
import '../models/auth/login/login_response.dart';

abstract class RemoteDataSource {
  Future<dynamic> login(LoginRequestModel loginRequestModel);

  Future<dynamic> registerLawyer(RegisterRequestModel registerRequestModel);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final RestApiMethods restApiMethods;

  RemoteDataSourceImpl({required this.restApiMethods});

  /// Login
  @override
  Future<dynamic> login(LoginRequestModel loginRequestModel) async {
    // init request
    final loginRequest = LoginRequest();
    final request = await loginRequest(loginRequestModel);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("Login >> ResponseCode: ${response.statusCode}, Body:${response.body}");
    switch (response.statusCode) {
      // success
      case 200:
        return loginResponseModelFromJson(response.body);
      // wrong email
      case 422:
        return const AppError(AppErrorType.wrongEmail);
      // wrong password
      case 401:
        return const AppError(AppErrorType.wrongPassword);
      // default
      default:
        return AppError(AppErrorType.api,
            message: "Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future registerLawyer(RegisterRequestModel registerRequestModel) async{
    // init request
    final registerRequest = RegisterLawyerRequest();
    final request = await registerRequest(registerRequestModel);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("registerLawyer >> ResponseCode: ${response.statusCode}, Body:${jsonDecode(response.body)}");
    switch (response.statusCode) {
    // success
      case 200:
        return registerResponseModelFromJson(response.body);
    // default
      default:
        return AppError(AppErrorType.api,
            message: "Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }
}
