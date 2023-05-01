enum PaymentMethod {
  card,
  kiosk,
}

/// Extension to convert PaymentMethod to string
extension ToString on PaymentMethod {
  String toShortArabicString() {
    switch (this) {
      case PaymentMethod.card:
        return "كارت بنكى";
      case PaymentMethod.kiosk:
        return "المحفظة";
    }
  }

  String toShortString() {
    switch (this) {
      case PaymentMethod.card:
        return "card";
      case PaymentMethod.kiosk:
        return "kiosk";
    }
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}
