enum AppErrorType {
  sharedPreferences,
  localDB,
  badRequest,
  pickImage,

  // apiErrors
  api,
  unauthorizedUser,
  notActivatedUser,
  userAlreadyExists,
  wrongPassword,
  wrongEmail,

  unDefined,
}

/// Extension to convert AppErrorType to string
extension ToString on AppErrorType {
  String toShortString() {
    return toString().split('.').last;
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}