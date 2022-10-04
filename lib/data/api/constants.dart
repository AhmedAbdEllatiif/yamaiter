

class ApiConstants {
  static const String _baseUrl = 'http://ya-maitre.herokuapp.com/api';

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

  static String buildUrl(RequestType requestType) {
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
      case RequestType.mySosList:
        return _mySosList;
      case RequestType.allSosList:
        return _allSosList;
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
}
