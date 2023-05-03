extension StringExtension on String {
  String intelliTrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }

  String intelliTrim_14() {
    return length > 14 ? '${substring(0, 14)}...' : this;
  }

  String removeHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }

  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
  bool get containsSpecialCharacter => contains(RegExp(r'(?=.*?[!@#\$&*~])'));
  bool get containsNumber => contains(RegExp(r'(?=.*?[0-9])'));
  bool get matchEmail => RegExp( r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

}