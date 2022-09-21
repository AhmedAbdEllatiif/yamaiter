import 'package:flutter/foundation.dart';

class ApiConstants {
  static const String _baseUrl = 'http://ya-maitre.herokuapp.com/api';

  static final String _loginUrl = _baseUrl + EndPoints.login;

  static String buildUrl(RequestType requestType) {
    switch (requestType) {
      case RequestType.login:
        return _loginUrl;
    }
  }
}

class EndPoints {
  /// login
  static String login = "/login";
}

enum RequestType { login }
