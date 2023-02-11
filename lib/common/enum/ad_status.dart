import 'package:yamaiter/common/constants/app_utils.dart';

enum AdStatus {
  unKnown,
  inprogress,
  published,
  expired,
}

/// Extension to convert AdStatus to string
extension ToString on AdStatus {
  String toShortString() {
    switch (this) {
      case AdStatus.unKnown:
        return AppUtils.undefined;
      case AdStatus.inprogress:
        return "قيد المراجعة";
      case AdStatus.published:
        return "تم نشره";
      case AdStatus.expired:
        return "منتهى";
    }
  }

  bool isEqual(String str) {
    return toShortString() == str;
  }
}
