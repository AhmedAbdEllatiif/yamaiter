import 'package:dartz/dartz.dart';

class ApiConstants {
  static const String _baseUrl = 'yamaitre.com';

  static const String mediaUrl = 'https://yamaitre.com/uploads/';

  /* final uri = Uri.https(url, [
    {"offset": 1}
  ]);*/

  static Uri _chatRoomById({required String id}) =>
      Uri.https(_baseUrl, "${EndPoints.chatRoom}/$id");

  ///==> _chatList
  static Uri _chatList() => Uri.https(_baseUrl, EndPoints.chatList);

  ///==> updateClientProfile
  static Uri _updateClientProfile() =>
      Uri.https(_baseUrl, EndPoints.updateClientProfile);

  ///==> Client
  static Uri _registerClient() => Uri.https(_baseUrl, EndPoints.registerClient);

  /// _createTaskClient
  static Uri _createTaskClient() =>
      Uri.https(_baseUrl, EndPoints.createTaskClient);

  /// _myConsultations
  static Uri _myConsultations({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.myConsultations, queryParams);

  static Uri _consultationDetails(String id) =>
      Uri.https(_baseUrl, "${EndPoints.consultationDetails}/$id");

  /// _payForConsultation
  static Uri _payForConsultation() =>
      Uri.https(_baseUrl, EndPoints.payForConsultation);

  /// _myTasksClient
  static Uri _myTasksClient({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.myTasksClient, queryParams);

  /// _singleTaskClient
  static Uri _singleTaskClient(String id) =>
      Uri.https(_baseUrl, "${EndPoints.singleTasksClient}/$id");

  /// _endTaskClient
  static Uri _endTaskClient(String id) =>
      Uri.https(_baseUrl, "${EndPoints.endTaskClient}/$id");

  /// _assignTaskClient
  static Uri _assignTaskClient() =>
      Uri.https(_baseUrl, EndPoints.assignTaskClient);

  /// _deleteTaskClient
  static Uri _deleteTaskClient(String id) =>
      Uri.https(_baseUrl, "${EndPoints.deleteTaskClient}/$id");

  /// _updateTaskClient
  static Uri _updateTaskClient(String id) =>
      Uri.https(_baseUrl, "${EndPoints.updateTaskClient}/$id");

  /// _lawyers
  static Uri _lawyers({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.lawyers, queryParams);

  static Uri _loginUrl() => Uri.https(_baseUrl, EndPoints.login);

  static Uri _registerUrl() => Uri.https(_baseUrl, EndPoints.registerLawyer);

  static Uri _about() => Uri.https(_baseUrl, EndPoints.about);

  static Uri _privacyAndPolicy() =>
      Uri.https(_baseUrl, EndPoints.privacyAndPolicy);

  static Uri _help() => Uri.https(_baseUrl, EndPoints.help);

  static Uri _contactUs() => Uri.https(_baseUrl, EndPoints.contactUs);

  static Uri _termsAndConditions() =>
      Uri.https(_baseUrl, EndPoints.termsAndConditions);

  static Uri _distresses() => Uri.https(_baseUrl, EndPoints.distresses);

  static Uri _mySosList({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.mySosList, queryParams);

  static Uri _allSosList({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.allSosList, queryParams);

  static Uri _deleteSos(String id) =>
      Uri.https(_baseUrl, "${EndPoints.deleteSos}/$id");

  static Uri _updateSos(String id) =>
      Uri.https(_baseUrl, "${EndPoints.updateSos}/$id");

  static Uri _allArticles({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.allArticles, queryParams);

  static Uri _createArticle() => Uri.https(_baseUrl, EndPoints.articles);

  static Uri _singleArticle(String id) =>
      Uri.https(_baseUrl, "${EndPoints.articles}/$id");

  static Uri _myArticles() => Uri.https(_baseUrl, EndPoints.myArticles);

  static Uri _deleteArticle(String id) =>
      Uri.https(_baseUrl, "${EndPoints.deleteArticle}/$id");

  static Uri _updateArticle(String id) =>
      Uri.https(_baseUrl, "${EndPoints.updateArticle}/$id");

  static Uri _createAd() => Uri.https(_baseUrl, EndPoints.createAd);

  static Uri _payForTax() => Uri.https(_baseUrl, EndPoints.payForTax);

  static Uri _inProgressTaxes({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.inProgressTaxes, queryParams);

  static Uri _completedTaxes({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.completedTaxes, queryParams);

  static Uri _myAds() => Uri.https(_baseUrl, EndPoints.myAds);

  static Uri _createTask() => Uri.https(_baseUrl, EndPoints.createTask);

  static Uri _myTasks({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.myTasks, queryParams);

  static Uri _payToAssignTask() =>
      Uri.https(_baseUrl, EndPoints.payToAssignTask);

  static Uri _mySingleTask(String id) =>
      Uri.https(_baseUrl, "${EndPoints.myTasks}/$id");

  static Uri _updateTask(String id) =>
      Uri.https(_baseUrl, "${EndPoints.updateTask}/$id");

  static Uri _deleteTask(String id) =>
      Uri.https(_baseUrl, "${EndPoints.deleteTask}/$id");

  static Uri _endTask(String id) =>
      Uri.https(_baseUrl, "${EndPoints.endTask}/$id");

  static Uri _applyForTask(String id) =>
      Uri.https(_baseUrl, "${EndPoints.applyForTask}/$id");

  static Uri _appliedTasks({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.appliedTasks, queryParams);

  static Uri _uploadTaskFile(String id) =>
      Uri.https(_baseUrl, "${EndPoints.uploadTaskFile}/$id");

  static Uri _acceptTerms() => Uri.https(_baseUrl, EndPoints.acceptTerms);

  static Uri _allTasks({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.allTasks, queryParams);

  static Uri _invitedTasks({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.invitedTasks, queryParams);

  static Uri _declineTask(String id) =>
      Uri.https(_baseUrl, "${EndPoints.declineTask}/$id");

  static Uri _searchForLawyer({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.searchForLawyer, queryParams);

  static Uri _inviteToTask(
          {required String lawyerId,
          required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, "${EndPoints.inviteToTask}/$lawyerId", queryParams);

  static Uri _filterTasks({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.filterTask, queryParams);

  static Uri _checkPaymentStatus({required Map<String, dynamic> queryParams}) =>
      Uri.https(_baseUrl, EndPoints.checkPaymentStatus, queryParams);

  static Uri _refund() => Uri.https(_baseUrl, EndPoints.refund);

  static Uri buildUrl(
    RequestType requestType, {
    String id = "",
    Map<String, String> queryParams = const {"": ""},
  }) {
    switch (requestType) {
      case RequestType.chatRoom:
        return _chatRoomById(id: id);

      case RequestType.chatList:
        return _chatList();

      ///============================>  Common <============================\\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///===================================================================\\\\
      // login
      case RequestType.login:
        return _loginUrl();
      // about
      case RequestType.about:
        return _about();
      case RequestType.termsAndConditions:
        return _termsAndConditions();
      // privacyAndPolicy
      case RequestType.privacyAndPolicy:
        return _privacyAndPolicy();
      // help
      case RequestType.help:
        return _help();
      // help
      case RequestType.contactUs:
        return _contactUs();

      ///===================================================================\\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///=========================> End of Common <=========================\\\\

      ///============================>  Client <============================\\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///===================================================================\\\\

      // updateClientProfile
      case RequestType.updateClientProfile:
        return _updateClientProfile();
      // registerClient
      case RequestType.registerClient:
        return _registerClient();
      // createTaskClient
      case RequestType.createTaskClient:
        return _createTaskClient();
      // consultationDetails
      case RequestType.consultationDetails:
        return _consultationDetails(id);
      // myConsultations
      case RequestType.myConsultations:
        return _myConsultations(queryParams: queryParams);
      // payForConsultation
      case RequestType.payForConsultation:
        return _payForConsultation();
      // myTasksClient
      case RequestType.myTasksClient:
        return _myTasksClient(queryParams: queryParams);
      // singleTaskClient
      case RequestType.singleTaskClient:
        return _singleTaskClient(id);
      // endTaskClient
      case RequestType.endTaskClient:
        return _endTaskClient(id);
      // assignTaskClient
      case RequestType.assignTaskClient:
        return _assignTaskClient();
      // deleteTaskClient
      case RequestType.deleteTaskClient:
        return _deleteTaskClient(id);
      // updateTaskClient
      case RequestType.updateTaskClient:
        return _updateTaskClient(id);
      // lawyers
      case RequestType.lawyers:
        return _lawyers(queryParams: queryParams);

      ///===================================================================\\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///=========================> End of Client <=========================\\\\

      // registerLawyer
      case RequestType.registerLawyer:
        return _registerUrl();

      // distresses
      case RequestType.distresses:
        return _distresses();
      // mySosList
      case RequestType.mySosList:
        return _mySosList(queryParams: queryParams);
      // delete sos
      case RequestType.deleteSos:
        return _deleteSos(id);
      // update sos
      case RequestType.updateSos:
        return _updateSos(id);
      // allSosList
      case RequestType.allSosList:
        return _allSosList(queryParams: queryParams);
      // allArticles
      case RequestType.allArticles:
        return _allArticles(queryParams: queryParams);
      // createArticle
      case RequestType.createArticle:
        return _createArticle();
      // single article
      case RequestType.singleArticle:
        return _singleArticle(id);
      // myArticles
      case RequestType.myArticles:
        return _myArticles();
      // delete article
      case RequestType.deleteArticle:
        return _deleteArticle(id);
      // update article
      case RequestType.updateArticle:
        return _updateArticle(id);
      // createAd
      case RequestType.createAd:
        return _createAd();
      // createAd
      case RequestType.payForTax:
        return _payForTax();
      // inProgressTaxes
      case RequestType.inProgressTaxes:
        return _inProgressTaxes(queryParams: queryParams);
      // completedTaxes
      case RequestType.completedTaxes:
        return _completedTaxes(queryParams: queryParams);
      // myAds
      case RequestType.myAds:
        return _myAds();
      // createTask
      case RequestType.createTask:
        return _createTask();
      // myTasks
      case RequestType.myTasks:
        return _myTasks(queryParams: queryParams);
      // updateTask
      case RequestType.updateTask:
        return _updateTask(id);
      // deleteTask
      case RequestType.deleteTask:
        return _deleteTask(id);
      // acceptTerms
      case RequestType.acceptTerms:
        return _acceptTerms();
      // allTasks
      case RequestType.allTasks:
        return _allTasks(queryParams: queryParams);
      //  mySingleTask
      case RequestType.mySingleTask:
        return _mySingleTask(id);
      // assignTask
      case RequestType.payToAssignTask:
        return _payToAssignTask();
      // endTask
      case RequestType.endTask:
        return _endTask(id);
      // appliedTasks
      case RequestType.appliedTasks:
        return _appliedTasks(queryParams: queryParams);
      // applyForTask
      case RequestType.applyForTask:
        return _applyForTask(id);
      // uploadTaskFile
      case RequestType.uploadTaskFile:
        return _uploadTaskFile(id);
      // invitedTasks
      case RequestType.invitedTask:
        return _invitedTasks(queryParams: queryParams);
      // declineTask
      case RequestType.declineTask:
        return _declineTask(id);
      // searchForLawyer
      case RequestType.searchForLawyer:
        return _searchForLawyer(queryParams: queryParams);
      // inviteToTask
      case RequestType.inviteToTask:
        return _inviteToTask(lawyerId: id, queryParams: queryParams);
      // filterTasks
      case RequestType.filterTasks:
        return _filterTasks(queryParams: queryParams);

      ///===================================================================\\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///                                                                   \\\\
      ///============================> Payment <============================\\\\
      // checkPaymentStatus
      case RequestType.checkPaymentStatus:
        return _checkPaymentStatus(queryParams: queryParams);
      // refund
      case RequestType.refund:
        return _refund();
    }
  }
}

class EndPoints {
  static const String _apiVersion = "/api/";

  ///===============================> Chat <================================\\\\

  /// chatRoom
  static String chatRoom = "${_apiVersion}chat";
  static String chatList = "${_apiVersion}chats";

  ///===============================> end of  Chat <========================\\\\
  ///===============================> Client <==============================\\\\
  /// updateClientProfile
  static String updateClientProfile = "${_apiVersion}update-client-profile";

  /// registerClient
  static String registerClient = "${_apiVersion}client-register";

  /// create task client
  static String createTaskClient = "${_apiVersion}tasks";

  /// consultationDetails
  static String consultationDetails = "${_apiVersion}consultations";

  /// my consultations
  static String myConsultations = "${_apiVersion}consultations";

  /// create consultation
  static String payForConsultation = "${_apiVersion}pay";

  /// create tasks client
  static String myTasksClient = "${_apiVersion}my-tasks";

  /// single task client
  static String singleTasksClient = "${_apiVersion}my-tasks";

  /// end task client
  static String endTaskClient = "${_apiVersion}client-complete-task";

  /// assign task client
  static String assignTaskClient = "${_apiVersion}assign-task";

  /// deleteTask
  static String deleteTaskClient = "${_apiVersion}client-tasks";

  /// updateTaskClient
  static String updateTaskClient = "${_apiVersion}client-update-task";

  /// lawyers
  static String lawyers = "${_apiVersion}search-lawyer";

  ///===========================> End of Client <===========================\\\\

  ///==============================> Lawyer <===============================\\\\
  /// login
  static String login = "${_apiVersion}login";

  /// registerLawyer
  static String registerLawyer = "${_apiVersion}lawyer-register";

  /// about
  static String about = "${_apiVersion}about";

  /// terms-and-conditions
  static String termsAndConditions = "${_apiVersion}terms-and-conditions";

  /// privacy-policy
  static String privacyAndPolicy = "${_apiVersion}privacy-policy";

  /// help
  static String help = "${_apiVersion}help";

  /// contactUs
  static String contactUs = "${_apiVersion}contact";

  /// distresses
  static String distresses = "${_apiVersion}distresses";

  /// my sos
  static String mySosList = "${_apiVersion}show-distresses";

  /// delete sos
  static String deleteSos = "${_apiVersion}distresses";

  /// update sos
  static String updateSos = "${_apiVersion}update-distresses";

  /// all sos
  static String allSosList = "${_apiVersion}distresses";

  /// allArticles
  static String allArticles = "${_apiVersion}articles";

  /// createArticle
  static String articles = "${_apiVersion}articles";

  /// myArticles
  static String myArticles = "${_apiVersion}my-articles";

  /// deleteArticle
  static String deleteArticle = "${_apiVersion}articles";

  /// updateArticle
  static String updateArticle = "${_apiVersion}update-article";

  /// createAd
  static String createAd = "${_apiVersion}announcements";

  /// createAd
  static String payForTax = "${_apiVersion}pay";

  /// inProgressTaxes
  static String inProgressTaxes = "${_apiVersion}show-taxes";

  /// completedTaxes
  static String completedTaxes = "${_apiVersion}taxes";

  /// myAds
  static String myAds = "${_apiVersion}show-announcements";

  /// createTask
  static String createTask = "${_apiVersion}tasks";

  /// deleteTask
  static String deleteTask = "${_apiVersion}tasks";

  /// myTasks
  static String myTasks = "${_apiVersion}my-tasks";

  /// assignTask
  static String payToAssignTask = "${_apiVersion}pay";

  /// updateTask
  static String updateTask = "${_apiVersion}update-task";

  /// endTask
  static String endTask = "${_apiVersion}complete-task";

  /// appliedTasks
  static String appliedTasks = "${_apiVersion}applied-tasks";

  /// apply for task
  static String applyForTask = "${_apiVersion}apply-to-task";

  /// upload task file
  static String uploadTaskFile = "${_apiVersion}upload-task-file";

  /// acceptTerms
  static String acceptTerms = "${_apiVersion}accept-terms";

  /// allTasks
  static String allTasks = "${_apiVersion}tasks";

  /// invitedTask
  static String invitedTasks = "${_apiVersion}invited-tasks";

  /// invitedTask
  static String declineTask = "${_apiVersion}refuse-invitaion";

  /// searchForLawyer
  static String searchForLawyer = "${_apiVersion}search-lawyer";

  /// searchForLawyer
  static String inviteToTask = "${_apiVersion}recommend-task";

  /// filterTask
  static String filterTask = "${_apiVersion}tasks";

  /// checkPaymentStatus
  static String checkPaymentStatus = "${_apiVersion}payment-status";

  /// refund
  static String refund = "${_apiVersion}refund";
}

/// The api request type
enum RequestType {
  /// ===> chat
  chatRoom,
  chatList,

  /// ===> Client
  updateClientProfile,
  registerClient,
  createTaskClient,
  myConsultations,
  payForConsultation,
  myTasksClient,
  singleTaskClient,
  endTaskClient,
  assignTaskClient,
  lawyers,
  deleteTaskClient,
  updateTaskClient,
  consultationDetails,

  ///==> Lawyer
  login,
  registerLawyer,
  about,
  termsAndConditions,
  privacyAndPolicy,
  help,
  contactUs,
  distresses,
  mySosList,
  allSosList,
  deleteSos,
  updateSos,
  allArticles,
  createArticle,
  updateArticle,
  singleArticle,
  myArticles,
  deleteArticle,
  createAd,
  payForTax,
  inProgressTaxes,
  completedTaxes,
  myAds,
  createTask,
  myTasks,
  mySingleTask,
  payToAssignTask,
  updateTask,
  deleteTask,
  endTask,
  appliedTasks,
  acceptTerms,
  allTasks,
  applyForTask,
  uploadTaskFile,
  invitedTask,
  declineTask,
  searchForLawyer,
  inviteToTask,
  filterTasks,
  checkPaymentStatus,
  refund,
}

class ApiParamsConstant {
  static String offset = "offset";
  static String status = "status";
  static String governorates = "governorates";
  static String city = "city";
  static String orderBy = "order_by";
  static String applicantsCount = "count";
}
