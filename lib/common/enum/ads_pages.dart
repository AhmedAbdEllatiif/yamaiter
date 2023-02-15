enum AdsPage {
  main,
  innerPage,
}

/// Extension to convert AdsPage to string
extension ToString on AdsPage {
  String toShortString() {
    switch (this) {
      case AdsPage.main:
        return "home";
      case AdsPage.innerPage:
        return "pages";
    }
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}
