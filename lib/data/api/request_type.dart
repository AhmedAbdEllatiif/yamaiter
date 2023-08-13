import 'package:yamaiter/data/api/api_constants.dart';

///
/// This method to build uri upon to the current request type
Uri uriBuilder({
  required String endPoint,
  String id = "",
  Map<String, String> queryParams = const {"": ""},
}) {
  final urlStr =
      ApiConstants.apiVersion + (id.isNotEmpty ? "$endPoint/$id" : endPoint);
  return Uri.https(
    ApiConstants.baseUrl,
    urlStr,
    queryParams,
  );
}

///
/// The api request type
enum RequestType {
  ///==> firebase token,
  firebaseToken,

  /// ===> chat
  chatRoom,
  chatList,

  /// ===> auth
  login,
  updateClientProfile,
  updateLawyerProfile,
  registerClient,
  registerLawyer,
  changePassword,
  forgetPassword,
  deleteUser,

  /// ===> Client
  createTaskClient,
  myConsultations,
  payForConsultation,
  singleTaskClient,
  consultationDetails,

  ///==> app pages
  about,
  termsAndConditions,
  privacyAndPolicy,
  help,
  contactUs,
  distresses,

  /// sos
  mySosList,
  allSosList,
  deleteSos,
  updateSos,
  singleSos,

  /// articles
  allArticles,
  createArticle,
  updateArticle,
  singleArticle,
  myArticles,
  deleteArticle,

  /// ads
  createAd,
  myAds,
  appAnnouncements,

  /// task actions
  createTask,
  payToAssignTask,
  updateTask,
  deleteTask,
  endTask,
  applyForTask,
  uploadTaskFile,
  filterTasks,
  declineTask,
  inviteToTask,

  /// tasks
  allTasks,
  myTasks,
  mySingleTask,
  taskDetails,
  appliedTasks,
  invitedTask,

  /// acceptTerms
  acceptTerms,

  /// lawyers
  lawyers,
  searchForLawyer,

  /// tax
  payForTax,
  inProgressTaxes,
  completedTaxes,

  /// payment
  checkPaymentStatus,
  refund,
  payout,
  balance,
  chargeBalance,
}

/// Extension to convert RequestType
extension ToUriFromString on RequestType {
  Uri toUriString({
    String id = "",
    Map<String, String> queryParams = const {"": ""},
  }) {
    return uriBuilder(
      endPoint: toEndPoint(),
      id: id,
      queryParams: queryParams,
    );
  }

  String toEndPoint() {
    switch (this) {
      case RequestType.firebaseToken:
        return "fcm-token";
      case RequestType.chatRoom:
        return "chat";

      case RequestType.chatList:
        return "chats";

      /**
     *
     *
     * auth
     *
     * */
      case RequestType.login:
        return "login";

      case RequestType.updateClientProfile:
        return "update-client-profile";

      case RequestType.updateLawyerProfile:
        return "update-lawyer-profile";

      case RequestType.registerClient:
        return "client-register";

      case RequestType.registerLawyer:
        return "lawyer-register";

      case RequestType.changePassword:
        return "change-password";

      case RequestType.forgetPassword:
        return "forget-password";
      case RequestType.deleteUser:
        return "delete-profile";

      /**
     *
     *
     * tasks
     *
     * */
      case RequestType.createTaskClient:
        return "tasks";

      case RequestType.singleTaskClient:
        return "my-tasks";
      case RequestType.taskDetails:
        return "tasks";

      /**
     *
     *
     * consultation
     *
     * */
      case RequestType.payForConsultation:
        return "pay";

      case RequestType.myConsultations:
        return "consultations";

      case RequestType.consultationDetails:
        return "consultations";

      /**
     *
     *
     * App pages
     *
     * */
      case RequestType.about:
        return "about";

      case RequestType.termsAndConditions:
        return "terms-and-conditions";

      case RequestType.privacyAndPolicy:
        return "privacy-policy";

      case RequestType.help:
        return "help";

      case RequestType.contactUs:
        return "contact";

      case RequestType.distresses:
        return "distresses";

      /**
     *
     *
     * SOS
     *
     * */
      case RequestType.mySosList:
        return "show-distresses";

      case RequestType.allSosList:
        return "distresses";

      case RequestType.deleteSos:
        return "distresses";

      case RequestType.updateSos:
        return "update-distresses";

      case RequestType.singleSos:
        return "distresses";

      /**
     *
     *
     * articles
     *
     * */
      case RequestType.allArticles:
        return "articles";

      case RequestType.createArticle:
        return "articles";

      case RequestType.updateArticle:
        return "update-article";

      case RequestType.singleArticle:
        return "articles";

      case RequestType.myArticles:
        return "my-articles";

      case RequestType.deleteArticle:
        return "articles";

      /**
     *
     *
     * ads
     *
     * */
      case RequestType.createAd:
        return "announcements";

      case RequestType.myAds:
        return "show-announcements";

      case RequestType.appAnnouncements:
        return "announcements";

      /**
     *
     *
     * task actions
     *
     * */
      case RequestType.createTask:
        return "tasks";

      case RequestType.payToAssignTask:
        return "pay";

      case RequestType.updateTask:
        return "update-task";

      case RequestType.deleteTask:
        return "tasks";

      case RequestType.endTask:
        return "complete-task";

      case RequestType.applyForTask:
        return "apply-to-task";

      case RequestType.uploadTaskFile:
        return "upload-task-file";

      case RequestType.filterTasks:
        return "tasks";

      case RequestType.declineTask:
        return "refuse-invitaion";

      case RequestType.inviteToTask:
        return "recommend-task";

      /**
     *
     *
     * task lists
     *
     * */
      case RequestType.allTasks:
        return "tasks";

      case RequestType.myTasks:
        return "my-tasks";
      case RequestType.mySingleTask:
        return "my-tasks";

      case RequestType.appliedTasks:
        return "applied-tasks";

      case RequestType.invitedTask:
        return "invited-tasks";

      /**
     *
     *
     * lawyers
     *
     * */
      case RequestType.lawyers:
        return "search-lawyer";

      case RequestType.searchForLawyer:
        return "search-lawyer";

      /**
     *
     *
     * acceptTerms
     *
     * */
      case RequestType.acceptTerms:
        return "accept-terms";

      /**
     *
     *
     * taxes
     *
     * */
      case RequestType.payForTax:
        return "pay";

      case RequestType.inProgressTaxes:
        return "show-taxes";

      case RequestType.completedTaxes:
        return "taxes";

      /**
     *
     *
     * payment
     *
     * */
      case RequestType.checkPaymentStatus:
        return "payment-status";

      case RequestType.refund:
        return "refund";

      case RequestType.payout:
        return "pay-out";

      case RequestType.balance:
        return "transaction-data";

      case RequestType.chargeBalance:
        return "charge-balance";
    }
  }
}
