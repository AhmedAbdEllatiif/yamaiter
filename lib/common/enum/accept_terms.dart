/// This enum helps to define the acceptance status of the current user
enum AcceptTerms {
  /// user accept the terms while registering for a new account
  /// * For both (client & Lawyer)
  firstAccept,

  /// lawyer user accept for second time before publishing his first Task
  /// * For lawyer user only
  secondAccept,

  /// for unKnown status
  unKnown,
}

AcceptTerms acceptTermsFromString(String acceptTermsInString) {
  switch (acceptTermsInString) {
    case "firstAccept":
      return AcceptTerms.firstAccept;
    case "secondAccept":
      return AcceptTerms.secondAccept;
    default:
      return AcceptTerms.unKnown;
  }
}

/// Extension to convert UserType to string
extension ToString on AcceptTerms {
  String toShortString() {
    return toString().split('.').last;
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}
