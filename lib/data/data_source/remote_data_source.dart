import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/api/requests/delete_requests/delete_article.dart';
import 'package:yamaiter/data/api/requests/get_requests/about_app.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_all_sos.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_my_articles.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_my_sos.dart';
import 'package:yamaiter/data/api/requests/get_requests/help.dart';
import 'package:yamaiter/data/api/requests/get_requests/policy_and_privacy.dart';
import 'package:yamaiter/data/api/requests/get_requests/terms_and_conditions.dart';
import 'package:yamaiter/data/api/requests/post_requests/create_article.dart';
import 'package:yamaiter/data/api/requests/post_requests/loginRequest.dart';
import 'package:yamaiter/data/api/requests/post_requests/registerLawyerRequest.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/models/article/create_article_request_model.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/params/create_article_params.dart';
import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';

import '../../domain/entities/app_error.dart';
import '../api/requests/get_requests/get_single_article.dart';
import '../api/requests/post_requests/create_sos.dart';
import '../api/requests/post_requests/update_article.dart';
import '../models/article/article_model.dart';
import '../models/auth/login/login_request.dart';
import '../models/auth/login/login_response.dart';
import '../models/sos/sos_model.dart';

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

  /// create sos
  Future<dynamic> createSos(CreateSosParams params);

  /// get my sos
  Future<dynamic> getMySos(String userToken);

  /// get all sos
  Future<dynamic> getAllSos(String userToken);

  /// createArticle
  Future<dynamic> createArticle(CreateOrUpdateArticleParams params);

  /// updateArticle
  Future<dynamic> updateArticle(CreateOrUpdateArticleParams params);

  /// fetchSingleArticleArticle
  Future<dynamic> fetchSingleArticleArticle(GetSingleArticleParams params);

  /// fetchSingleArticleArticle
  Future<dynamic> fetchMyArticles(String userToken);

  /// delete article
  Future<dynamic> deleteArticle(DeleteArticleParams params);
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
    log("registerLawyer >> ResponseCode: ${response.statusCode}");
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

    log("getAbout >> ResponseCode: ${response.statusCode}, ");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfSideMenuResponseModels(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// help
  @override
  Future getHelp(String userToken) async {
    log("getHelp >> Start request");
    // init request
    final getHelpRequest = GetHelpRequest();

    // response
    final response = await getHelpRequest(userToken);

    log("getHelp >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfHelpQuestionModel(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "getHelp Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "getHelp Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// privacyAndPolicy
  @override
  Future getPrivacyAndPolicy(String userToken) async {
    log("getPrivacyAndPolicy >> Start request");
    // init request
    final getPrivacyRequest = GetPrivacyRequest();

    // response
    final response = await getPrivacyRequest(userToken);

    log("getPrivacyAndPolicy >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfSideMenuResponseModels(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "getPrivacyAndPolicy Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "getPrivacyAndPolicy Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// termsAndConditions
  @override
  Future getTermsAndConditions(String userToken) async {
    log("termsAndConditions >> Start request");
    // init request
    final getTermsAndConditions = GetTermsAndConditionsRequest();

    // response
    final response = await getTermsAndConditions(userToken);

    log("termsAndConditions >> ResponseCode: ${response.statusCode},");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfSideMenuResponseModels(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "termsAndConditions Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "termsAndConditions Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// CreateSosParams
  @override
  Future createSos(CreateSosParams params) async {
    log("createSos >> Start request");
    // init request
    final createSos = CreateSosRequest();

    // response
    final response = await createSos(params.sosRequestModel, params.token);

    log("createSos >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createSos Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createSos Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "createSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future getMySos(String userToken) async {
    try {
      log("getMySos >> Start request");
      // init request
      final getMySos = GetMySosRequest();

      // response
      final response = await getMySos(userToken);

      log("getMySos >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

      switch (response.statusCode) {
        // success
        case 200:
          return mySosResponseModelFromDistressDataJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getMySos Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getMySos Status Code >> ${response.statusCode}");
        // default
        default:
          return AppError(AppErrorType.api,
              message: "getMySos Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future getAllSos(String userToken) async {
    log("getAllSos >> Start request");
    // init request
    final allSosRequest = GetAllSosRequest();

    // response
    final response = await allSosRequest(userToken);

    log("getAllSos >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return mySosResponseModelFromAllDistressDataCallsJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "getAllSos Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "getAllSos Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "getAllSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// createArticle
  @override
  Future createArticle(CreateOrUpdateArticleParams params) async {
    // init request
    final createArticleRequest = CreateArticleRequest();
    final request = await createArticleRequest(params);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("createArticle >> ResponseCode: ${response.statusCode}");
    log("createArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createArticle Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createArticle Status Code >> ${response.statusCode}");
      // default
      default:
        log("createArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "createArticle Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future fetchSingleArticleArticle(GetSingleArticleParams params) async {
    log("fetchSingleArticleArticle >> Start request");
    // init request
    final getRequest = GetSingleArticleRequest();

    // response
    final response = await getRequest(params);

    log("fetchSingleArticleArticle >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return articleModelFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message:
                "fetchSingleArticleArticle Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "fetchSingleArticleArticle Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message:
                "fetchSingleArticleArticle Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future fetchMyArticles(String userToken) async {
    log("fetchMyArticles >> Start request");
    // init request
    final getRequest = GetMyArticlesRequest();

    // response
    final response = await getRequest(userToken);

    log("fetchMyArticles >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return myArticlesFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "fetchMyArticles Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "fetchMyArticles Status Code >> ${response.statusCode}");
      // default
      default:
        log("fetchMyArticles >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "fetchMyArticles Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// DeleteArticleParams
  @override
  Future deleteArticle(DeleteArticleParams params) async {
    log("deleteArticle >> Start request");
    // init request
    final deleteRequest = DeleteArticleRequest();

    // response
    final response = await deleteRequest(params);

    log("deleteArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "deleteArticle Status Code >> ${response.statusCode}");
      // not found
      case 404:
        return AppError(AppErrorType.notFound,
            message: "deleteArticle Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "deleteArticle Status Code >> ${response.statusCode}");
      // default
      default:
        log("deleteArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "deleteArticle Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// updateArticle
  @override
  Future updateArticle(CreateOrUpdateArticleParams params) async{
    // init request
    final updateArticleRequest = UpdateArticleRequest();
    final request = await updateArticleRequest(params);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("updateArticle >> ResponseCode: ${response.statusCode}");
    log("updateArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
    switch (response.statusCode) {
    // success
      case 200:
        return SuccessModel();
    // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "updateArticle Status Code >> ${response.statusCode}");
    // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "updateArticle Status Code >> ${response.statusCode}");
    // default
      default:
        log("createArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "createArticle Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }
}
