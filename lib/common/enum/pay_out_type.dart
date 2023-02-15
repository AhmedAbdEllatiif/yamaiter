enum PayoutType {
  vodafone,
  etisalat,
  orange,
  bankWallet,
  unKnown,
}

/// Extension to convert PayoutType to string
extension ToString on PayoutType {
  String toShortString() {
    switch (this) {
      case PayoutType.vodafone:
       return "vodafone";
      case PayoutType.etisalat:
       return "etisalat";
      case PayoutType.orange:
        return "orange";
      case PayoutType.bankWallet:
         return "bank_wallet";
      case PayoutType.unKnown:
         return "unKnown";
    }
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}
