enum PaymentMissionType {
  tax,
  consultation,
  task,
  undefined,
}

/// Extension to convert PaymentMission to string
extension ToString on PaymentMissionType {
  String toShortString() {
    return toString().split('.').last;
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}
