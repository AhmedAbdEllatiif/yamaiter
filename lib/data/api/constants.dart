class ApiConstants {
  static const String _baseUrl = 'http://ya-maitre.herokuapp.com/api';

  static const String mediaUrl = 'https://ya-maitre.herokuapp.com/uploads/';

  static final String _loginUrl = _baseUrl + EndPoints.login;
  static final String _registerUrl = _baseUrl + EndPoints.registerLawyer;
  static final String _about = _baseUrl + EndPoints.about;
  static final String _privacyAndPolicy = _baseUrl + EndPoints.privacyAndPolicy;
  static final String _help = _baseUrl + EndPoints.help;
  static final String _termsAndConditions =
      _baseUrl + EndPoints.termsAndConditions;
  static final String _distresses = _baseUrl + EndPoints.distresses;
  static final String _mySosList = _baseUrl + EndPoints.mySosList;
  static final String _allSosList = _baseUrl + EndPoints.allSosList;
  static final String _createArticle = _baseUrl + EndPoints.articles;
  static final String _singleArticle = _baseUrl + EndPoints.articles;
  static final String _myArticles = _baseUrl + EndPoints.myArticles;

  static String buildUrl(RequestType requestType, {String id = ""}) {
    switch (requestType) {
      // login
      case RequestType.login:
        return _loginUrl;
      // registerLawyer
      case RequestType.registerLawyer:
        return _registerUrl;
      // about
      case RequestType.about:
        return _about;
      case RequestType.termsAndConditions:
        return _termsAndConditions;
      // privacyAndPolicy
      case RequestType.privacyAndPolicy:
        return _privacyAndPolicy;
      // help
      case RequestType.help:
        return _help;
      // distresses
      case RequestType.distresses:
        return _distresses;
      // mySosList
      case RequestType.mySosList:
        return _mySosList;
      // allSosList
      case RequestType.allSosList:
        return _allSosList;
      // createArticle
      case RequestType.createArticle:
        return _createArticle;
      // single article
      case RequestType.singleArticle:
        return "$_singleArticle/$id";
      // myArticles
      case RequestType.myArticles:
        return _myArticles;
    }
  }
}

class EndPoints {
  /// login
  static String login = "/login";

  /// registerLawyer
  static String registerLawyer = "/lawyer-register";

  /// about
  static String about = "/about";

  /// terms-and-conditions
  static String termsAndConditions = "/terms-and-conditions";

  /// privacy-policy
  static String privacyAndPolicy = "/privacy-policy";

  /// help
  static String help = "/help";

  /// distresses
  static String distresses = "/distresses";

  /// my sos
  static String mySosList = "/show-distresses";

  /// all sos
  static String allSosList = "/distresses";

  /// createArticle
  static String articles = "/articles";

  /// myArticles
  static String myArticles = "/my-articles";
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
  createArticle,
  singleArticle,
  myArticles,
}
