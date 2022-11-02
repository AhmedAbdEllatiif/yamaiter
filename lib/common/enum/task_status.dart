enum TaskType{
  todo,
  inprogress,
  inreview,
  completed
}

/// Extension to convert TaskType to string
extension ToString on TaskType {
  String toShortString() {
    return toString().split('.').last;
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}