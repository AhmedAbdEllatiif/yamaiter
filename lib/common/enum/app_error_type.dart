enum AppErrorType {
  sharedPreferences,
  localDB,
  badRequest,
  pickImage,

  unHandledError,
  // apiErrors
  api,
  emailAlreadyExists,
  alreadyPhoneUsedBefore,
  unauthorizedUser,
  notActivatedUser,
  notAcceptedYet,
  notFound,
  idNotFound,
  userAlreadyExists,
  alreadyAppliedToThisTask,
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