import 'package:dartz/dartz.dart';

class ApiConstants {
  static const String _baseUrl = 'yamaitre.com';

  static const String mediaUrl = 'https://yamaitre.com/uploads/';

  /* final uri = Uri.https(url, [
    {"offset": 1}
  ]);*/

  static Uri _loginUrl() => Uri.https(_baseUrl, EndPoints.login);

  static Uri _registerUrl() => Uri.https(_baseUrl, EndPoints.registerLawyer);

  static Uri _about() => Uri.https(_baseUrl, EndPoints.about);

  static Uri _privacyAndPolicy() =>
      Uri.https(_baseUrl, EndPoints.privacyAndPolicy);

  static Uri _help() => Uri.https(_baseUrl, EndPoints.help);

  static Uri _termsAndConditions() =>
      Uri.https(_baseUrl, EndPoints.termsAndConditions);

  static Uri _distresses() => Uri.https(_baseUrl, EndPoints.distresses);

  static Uri _mySosList({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.mySosList, queryParams);

  static Uri _allSosList({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.allSosList, queryParams);

  static Uri _deleteSos(String id) =>
      Uri.https(_baseUrl, "${EndPoints.deleteSos}/$id");

  static Uri _updateSos(String id) =>
      Uri.https(_baseUrl, "${EndPoints.updateSos}/$id");

  static Uri _allArticles({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.allArticles, queryParams);

  static Uri _createArticle() => Uri.https(_baseUrl, EndPoints.articles);

  static Uri _singleArticle(String id) =>
      Uri.https(_baseUrl, "${EndPoints.articles}/$id");

  static Uri _myArticles() => Uri.https(_baseUrl, EndPoints.myArticles);

  static Uri _deleteArticle(String id) =>
      Uri.https(_baseUrl, "${EndPoints.deleteArticle}/$id");

  static Uri _updateArticle(String id) =>
      Uri.https(_baseUrl, "${EndPoints.updateArticle}/$id");

  static Uri _createAd() => Uri.https(_baseUrl, EndPoints.createAd);

  static Uri _createTax() => Uri.https(_baseUrl, EndPoints.createTax);

  static Uri _inProgressTaxes({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.inProgressTaxes, queryParams);

  static Uri _completedTaxes({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.completedTaxes, queryParams);

  static Uri _myAds() => Uri.https(_baseUrl, EndPoints.myAds);

  static Uri _createTask() => Uri.https(_baseUrl, EndPoints.createTask);

  static Uri _myTasks({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.myTasks, queryParams);

  static Uri _updateTask(String id) =>
      Uri.https(_baseUrl, "${EndPoints.updateTask}/$id");

  static Uri _deleteTask(String id) =>
      Uri.https(_baseUrl, "${EndPoints.deleteTask}/$id");

  static Uri _acceptTerms() => Uri.https(_baseUrl, EndPoints.acceptTerms);

  static Uri _allTasks({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.allTasks, queryParams);

  static Uri buildUrl(
    RequestType requestType, {
    String id = "",
    Map<String, String> queryParams = const {"": ""},
  }) {
    switch (requestType) {
      // login
      case RequestType.login:
        return _loginUrl();
      // registerLawyer
      case RequestType.registerLawyer:
        return _registerUrl();
      // about
      case RequestType.about:
        return _about();
      case RequestType.termsAndConditions:
        return _termsAndConditions();
      // privacyAndPolicy
      case RequestType.privacyAndPolicy:
        return _privacyAndPolicy();
      // help
      case RequestType.help:
        return _help();
      // distresses
      case RequestType.distresses:
        return _distresses();
      // mySosList
      case RequestType.mySosList:
        return _mySosList(queryParams: queryParams);
      // delete sos
      case RequestType.deleteSos:
        return _deleteSos(id);
      // update sos
      case RequestType.updateSos:
        return _updateSos(id);
      // allSosList
      case RequestType.allSosList:
        return _allSosList(queryParams: queryParams);
      // allArticles
      case RequestType.allArticles:
        return _allArticles(queryParams: queryParams);
      // createArticle
      case RequestType.createArticle:
        return _createArticle();
      // single article
      case RequestType.singleArticle:
        return _singleArticle(id);
      // myArticles
      case RequestType.myArticles:
        return _myArticles();
      // delete article
      case RequestType.deleteArticle:
        return _deleteArticle(id);
      // update article
      case RequestType.updateArticle:
        return _updateArticle(id);
      // createAd
      case RequestType.createAd:
        return _createAd();
      // createAd
      case RequestType.createTax:
        return _createTax();
      // inProgressTaxes
      case RequestType.inProgressTaxes:
        return _inProgressTaxes(queryParams: queryParams);
      // completedTaxes
      case RequestType.completedTaxes:
        return _completedTaxes(queryParams: queryParams);
      // myAds
      case RequestType.myAds:
        return _myAds();
      // createTask
      case RequestType.createTask:
        return _createTask();
      // myTasks
      case RequestType.myTasks:
        return _myTasks(queryParams: queryParams);
      // updateTask
      case RequestType.updateTask:
        return _updateTask(id);
      // deleteTask
      case RequestType.deleteTask:
        return _deleteTask(id);
      // acceptTerms
      case RequestType.acceptTerms:
        return _acceptTerms();
      // allTasks
      case RequestType.allTasks:
        return _allTasks(queryParams: queryParams);
    }
  }
}

class EndPoints {
  static const String _apiVersion = "/api/";

  /// login
  static String login = "${_apiVersion}login";

  /// registerLawyer
  static String registerLawyer = "${_apiVersion}lawyer-register";

  /// about
  static String about = "${_apiVersion}about";

  /// terms-and-conditions
  static String termsAndConditions = "${_apiVersion}terms-and-conditions";

  /// privacy-policy
  static String privacyAndPolicy = "${_apiVersion}privacy-policy";

  /// help
  static String help = "${_apiVersion}help";

  /// distresses
  static String distresses = "${_apiVersion}distresses";

  /// my sos
  static String mySosList = "${_apiVersion}show-distresses";

  /// delete sos
  static String deleteSos = "${_apiVersion}distresses";

  /// update sos
  static String updateSos = "${_apiVersion}update-distresses";

  /// all sos
  static String allSosList = "${_apiVersion}distresses";

  /// allArticles
  static String allArticles = "${_apiVersion}articles";

  /// createArticle
  static String articles = "${_apiVersion}articles";

  /// myArticles
  static String myArticles = "${_apiVersion}my-articles";

  /// deleteArticle
  static String deleteArticle = "${_apiVersion}articles";

  /// updateArticle
  static String updateArticle = "${_apiVersion}update-article";

  /// createAd
  static String createAd = "${_apiVersion}announcements";

  /// createAd
  static String createTax = "${_apiVersion}taxes";

  /// inProgressTaxes
  static String inProgressTaxes = "${_apiVersion}show-taxes";

  /// completedTaxes
  static String completedTaxes = "${_apiVersion}taxes";

  /// myAds
  static String myAds = "${_apiVersion}show-announcements";

  /// createTask
  static String createTask = "${_apiVersion}tasks";

  /// deleteTask
  static String deleteTask = "${_apiVersion}tasks";

  /// myTasks
  static String myTasks = "${_apiVersion}my-tasks";

  /// myTasks
  static String updateTask = "${_apiVersion}update-task";

  /// acceptTerms
  static String acceptTerms = "${_apiVersion}accept-terms";

  /// allTasks
  static String allTasks = "${_apiVersion}tasks";
}

/// The api request type
enum RequestType {
  login,
  registerLawyer,
  about,
  termsAndConditions,
  privacyAndPolicy,
  help,
  distresses,
  mySosList,
  allSosList,
  deleteSos,
  updateSos,
  allArticles,
  createArticle,
  updateArticle,
  singleArticle,
  myArticles,
  deleteArticle,
  createAd,
  createTax,
  inProgressTaxes,
  completedTaxes,
  myAds,
  createTask,
  myTasks,
  updateTask,
  deleteTask,
  acceptTerms,
  allTasks,
}

class ApiParamsConstant {
  static String offset = "offset";
  static String status = "status";
}
