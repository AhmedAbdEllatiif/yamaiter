import 'package:flutter/foundation.dart';

class ApiConstants {
  static const String _baseUrl = 'http://ya-maitre.herokuapp.com/api';

  static final String _loginUrl = _baseUrl + EndPoints.login;
  static final String _registerUrl = _baseUrl + EndPoints.register;

  static String buildUrl(RequestType requestType) {
    switch (requestType) {
      case RequestType.login:
        return _loginUrl;
      case RequestType.registerLawyer:
        return _registerUrl;
    }
  }
}

class EndPoints {
  /// login
  static String login = "/login";

  /// register
  static String register = "/register";
}

enum RequestType { login ,registerLawyer}
