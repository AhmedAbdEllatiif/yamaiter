enum AppErrorType {
  api,
  sharedPreferences,
  localDB,
  unauthorizedUser,
  badRequest,
  pickImage,
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