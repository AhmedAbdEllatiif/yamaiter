enum UserType{
  lawyer,
  client,
  unDefined,
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