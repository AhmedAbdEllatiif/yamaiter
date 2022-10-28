import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/api/requests/delete_requests/delete_article.dart';
import 'package:yamaiter/data/api/requests/delete_requests/delete_sos.dart';
import 'package:yamaiter/data/api/requests/get_requests/about_app.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_all_articles.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_all_sos.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_in_progress_taxes.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_my_articles.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_my_sos.dart';
import 'package:yamaiter/data/api/requests/get_requests/help.dart';
import 'package:yamaiter/data/api/requests/get_requests/policy_and_privacy.dart';
import 'package:yamaiter/data/api/requests/get_requests/terms_and_conditions.dart';
import 'package:yamaiter/data/api/requests/post_requests/accept_terms.dart';
import 'package:yamaiter/data/api/requests/post_requests/create_ad.dart';
import 'package:yamaiter/data/api/requests/post_requests/create_article.dart';
import 'package:yamaiter/data/api/requests/post_requests/create_task.dart';
import 'package:yamaiter/data/api/requests/post_requests/loginRequest.dart';
import 'package:yamaiter/data/api/requests/post_requests/registerLawyerRequest.dart';
import 'package:yamaiter/data/models/accept_terms_model.dart';
import 'package:yamaiter/data/models/ads/ad_model.dart';
import 'package:yamaiter/data/models/ads/create_ad_request_model.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/models/tasks/create_task_request_model.dart';
import 'package:yamaiter/data/models/tax/tax_model.dart';
import 'package:yamaiter/data/params/accept_terms_params.dart';
import 'package:yamaiter/data/params/all_articles_params.dart';
import 'package:yamaiter/data/params/all_sos_params.dart';
import 'package:yamaiter/data/params/create_ad_params.dart';
import 'package:yamaiter/data/params/create_article_params.dart';
import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/data/params/create_task_params.dart';
import 'package:yamaiter/data/params/create_tax_params.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';
import 'package:yamaiter/data/params/update_sos_params.dart';

import '../../domain/entities/app_error.dart';
import '../api/requests/get_requests/get_completed_taxes.dart';
import '../api/requests/get_requests/get_my_ads.dart';
import '../api/requests/get_requests/get_single_article.dart';
import '../api/requests/post_requests/create_sos.dart';
import '../api/requests/post_requests/create_tax.dart';
import '../api/requests/post_requests/update_article.dart';
import '../api/requests/post_requests/update_sos.dart';
import '../models/article/article_model.dart';
import '../models/auth/login/login_request.dart';
import '../models/auth/login/login_response.dart';
import '../models/sos/sos_model.dart';
import '../params/delete_sos_params.dart';
import '../params/get_taxes_params.dart';

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
  Future<dynamic> getMySos(GetSosParams params);

  /// delete sos
  Future<dynamic> deleteSos(DeleteSosParams params);

  /// update sos
  Future<dynamic> updateSos(UpdateSosParams params);

  /// get all sos
  Future<dynamic> getAllSos(GetSosParams params);

  /// createTax
  Future<dynamic> createTax(CreateTaxParams params);

  /// createArticle
  Future<dynamic> getAllArticles(GetArticlesParams params);

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

  /// create new ad
  Future<dynamic> createAd(CreateAdParams params);

  /// fetchInProgressTaxes
  Future<dynamic> fetchInProgressTaxes(GetTaxesParams params);

  /// fetchCompletedTaxes
  Future<dynamic> fetchCompletedTaxes(GetTaxesParams params);

  /// get my ads
  Future<dynamic> getMyAds(String userToken);

  /// accept terms
  Future<dynamic> acceptTerms(AcceptTermsParams params);

  /// create task
  Future<dynamic> createTask(CreateTaskParams params);
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

  /// updateSos
  @override
  Future updateSos(UpdateSosParams params) async {
    log("updateSos >> Start request");
    // init request
    final updateRequest = UpdateSosRequest();

    // response
    final response = await updateRequest(params, params.token);

    log("updateSos >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "updateSos Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "updateSos Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "updateSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future getMySos(GetSosParams params) async {
    try {
      log("getMySos >> Start request");
      // init request
      final getMySos = GetMySosRequest();

      // response
      final response = await getMySos(params);

      log("getMySos >> ResponseCode: ${response.statusCode}");

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
  Future getAllSos(GetSosParams params) async {
    log("getAllSos >> Start request");
    // init request
    final allSosRequest = GetAllSosRequest();

    // response
    final response = await allSosRequest(params);

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
        log("getAllSos >> ResponseCode: ${response.statusCode} \n Body: ${response.body}");
        return AppError(AppErrorType.api,
            message: "getAllSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future getAllArticles(GetArticlesParams params) async {
    log("getAllArticles >> Start request");
    // init request
    final getRequest = GetAllArticlesRequest();

    // response
    final response = await getRequest(params);

    log("getAllArticles >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return allArticlesFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "getAllArticles Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "getAllArticles Status Code >> ${response.statusCode}");
      // default
      default:
        log("getAllArticles >> ResponseCode: ${response.statusCode} \n Body: ${response.body}");
        return AppError(AppErrorType.api,
            message: "getAllArticles Status Code >> ${response.statusCode}"
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
  Future updateArticle(CreateOrUpdateArticleParams params) async {
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

  /// createAd
  @override
  Future createAd(CreateAdParams params) async {
    log("createAd >> Start request");
    // init request
    final createAd = CreateAdRequest();

    // response
    final response = await createAd(
      CreateAdRequestModel(place: params.place),
      params.userToken,
    );

    log("createAd >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createAd Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createAd Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "createAd Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future createTax(CreateTaxParams params) async {
    // init request
    final createTaxRequest = CreateTaxRequest();
    final request = await createTaxRequest(params);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("createTax >> ResponseCode: ${response.statusCode}");
    log("createTax >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createTax Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createTax Status Code >> ${response.statusCode}");
      // default
      default:
        log("createTax >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "createTax Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// fetchInProgressTaxes
  @override
  Future fetchInProgressTaxes(GetTaxesParams params) async {
    log("fetchInProgressTaxes >> Start request");
    // init request
    final getRequest = GetInProgressTaxesRequest();

    // response
    final response = await getRequest(params);

    log("fetchInProgressTaxes >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfInProgressTaxesFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message:
                "fetchInProgressTaxes Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "fetchInProgressTaxes Status Code >> ${response.statusCode}");
      // default
      default:
        log("fetchInProgressTaxes >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message:
                "fetchInProgressTaxes Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future fetchCompletedTaxes(GetTaxesParams params) async {
    log("fetchCompletedTaxes >> Start request");
    // init request
    final getRequest = GetCompletedTaxesRequest();

    // response
    final response = await getRequest(params);

    log("fetchCompletedTaxes >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfCompletedTaxesFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message:
                "fetchCompletedTaxes Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "fetchCompletedTaxes Status Code >> ${response.statusCode}");
      // default
      default:
        log("fetchCompletedTaxes >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "fetchCompletedTaxes Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future getMyAds(String userToken) async {
    log("getMyAds >> Start request");
    // init request
    final getRequest = GetMyAdsRequest();

    // response
    final response = await getRequest(userToken);

    log("getMyAds >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfAdsFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "getMyAds Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "getMyAds Status Code >> ${response.statusCode}");
      // default
      default:
        log("getMyAds >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "getMyAds Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// deleteSos
  @override
  Future deleteSos(DeleteSosParams params) async {
    log("deleteSos >> Start request");
    // init request
    final deleteRequest = DeleteSosRequest();

    // response
    final response = await deleteRequest(params);

    log("deleteSos >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "deleteSos Status Code >> ${response.statusCode}");
      // not found
      case 404:
        return AppError(AppErrorType.notFound,
            message: "deleteSos Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "deleteSos Status Code >> ${response.statusCode}");
      // default
      default:
        log("deleteSos >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "deleteSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// acceptTerms
  @override
  Future acceptTerms(AcceptTermsParams params) async {
    log("acceptTerms >> Start request");
    // init request
    final request = AcceptTermsRequest();

    // response
    final response =
        await request(AcceptTermsModel.fromParams(params), params.userToken);

    log("acceptTerms >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "acceptTerms Status Code >> ${response.statusCode}");
      // not found
      case 404:
        return AppError(AppErrorType.notFound,
            message: "acceptTerms Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "acceptTerms Status Code >> ${response.statusCode}");
      // default
      default:
        log("acceptTerms >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "acceptTerms Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// createTask
  @override
  Future createTask(CreateTaskParams params) async {
    log("createTask >> Start request");
    // init request
    final request = CreateTaskRequest();

    // response
    final response = await request(
        CreateTaskRequestModel.fromParams(params: params), params.userToken);

    log("createTask >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        {
          return response.body.contains("notAcceptedYet")
              ? AppError(AppErrorType.notAcceptedYet,
                  message: "createTask Status Code >> ${response.statusCode}")
              : SuccessModel();
        }

      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createTask Status Code >> ${response.statusCode}");
      // not found
      case 404:
        return AppError(AppErrorType.notFound,
            message: "createTask Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createTask Status Code >> ${response.statusCode}");
      // default
      default:
        log("deleteSos >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "deleteSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }
}
