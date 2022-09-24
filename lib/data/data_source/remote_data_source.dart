import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/api/requests/get_requests/about_app.dart';
import 'package:yamaiter/data/api/requests/post_requests/loginRequest.dart';
import 'package:yamaiter/data/api/requests/post_requests/registerLawyerRequest.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';

import '../../domain/entities/app_error.dart';

import '../models/app_settings_models/about_response_model.dart';
import '../models/auth/login/login_request.dart';
import '../models/auth/login/login_response.dart';

abstract class RemoteDataSource {
  /// login
  Future<dynamic> login(LoginRequestModel loginRequestModel);

  /// registerLawyer
  Future<dynamic> registerLawyer(RegisterRequestModel registerRequestModel);

  /// about
  Future<dynamic> getAbout(String userToken);

  /// termsAndConditions
  Future<dynamic> getTermsAndConditions(String userToken);

  /// privacyAndPolicy
  Future<dynamic> getPrivacyAndPolicy(String userToken);

  /// help
  Future<dynamic> getHelp(String userToken);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  RemoteDataSourceImpl();

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
  Future registerLawyer(RegisterRequestModel registerRequestModel) async {
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

  /// about
  @override
  Future getAbout(String userToken) async {
    log("getAbout >> Start request");
    // init request
    final getAbout = GetAboutRequest();

    // response
    final response = await getAbout(userToken);

    log("getAbout >> ResponseCode: ${response.statusCode}, Body:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfAboutModels(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return registerResponseModelFromJson(response.body);
      // default
      default:
        return AppError(AppErrorType.api,
            message: "Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// help
  @override
  Future getHelp(String userToken) {
    // TODO: implement getHelp
    throw UnimplementedError();
  }

  /// privacyAndPolicy
  @override
  Future getPrivacyAndPolicy(String userToken) {
    // TODO: implement getPrivacyAndPolicy
    throw UnimplementedError();
  }

  /// termsAndConditions
  @override
  Future getTermsAndConditions(String userToken) {
    // TODO: implement getTermsAndConditions
    throw UnimplementedError();
  }
}
