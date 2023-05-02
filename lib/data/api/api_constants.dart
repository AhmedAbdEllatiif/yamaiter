class ApiConstants {
  /// base url
  static const String baseUrl = 'yamaitre.com';

  /// media url
  static const String mediaUrl = 'https://yamaitre.com/uploads/';

  /// apiVersion
  static const String apiVersion = "/api/";

  /// firebaseToken
  static String firebaseToken = "${apiVersion}fcm-token";
}

///
/// params constants
class ApiParamsConstant {
  static String offset = "offset";
  static String status = "status";
  static String governorates = "governorates";
  static String city = "city";
  static String orderBy = "order_by";
  static String applicantsCount = "count";
  static String announcementPlace = "place";
}
