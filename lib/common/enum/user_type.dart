enum UserType {
  lawyer,
  client,
  unDefined,
}

UserType userTypeFromString(String userTypeInString) {
  switch (userTypeInString) {
    case "lawyer":
      return UserType.lawyer;
    case "client":
      return UserType.client;
    default:
      return UserType.unDefined;
  }
}

/// Extension to convert UserType to string
extension ToString on UserType {
  String toShortString() {
    return toString().split('.').last;
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}
