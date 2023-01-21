import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/api/requests/delete_requests/client/delete_task.dart';
import 'package:yamaiter/data/api/requests/delete_requests/decline_task.dart';
import 'package:yamaiter/data/api/requests/delete_requests/delete_article.dart';
import 'package:yamaiter/data/api/requests/delete_requests/delete_sos.dart';
import 'package:yamaiter/data/api/requests/delete_requests/delete_task.dart';
import 'package:yamaiter/data/api/requests/get_requests/about_app.dart';
import 'package:yamaiter/data/api/requests/get_requests/client/get_consultation_details.dart';
import 'package:yamaiter/data/api/requests/get_requests/client/get_my_tasks_client.dart';
import 'package:yamaiter/data/api/requests/get_requests/filter_tasks.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_accept_terms.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_all_articles.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_all_sos.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_in_progress_taxes.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_invited_tasks.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_my_articles.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_my_sos.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_my_tasks.dart';
import 'package:yamaiter/data/api/requests/get_requests/get_single_task_details.dart';
import 'package:yamaiter/data/api/requests/get_requests/help.dart';
import 'package:yamaiter/data/api/requests/get_requests/paymeny/check_payment_status.dart';
import 'package:yamaiter/data/api/requests/get_requests/policy_and_privacy.dart';
import 'package:yamaiter/data/api/requests/get_requests/terms_and_conditions.dart';
import 'package:yamaiter/data/api/requests/post_requests/accept_terms.dart';
import 'package:yamaiter/data/api/requests/post_requests/apply_for_task.dart';
import 'package:yamaiter/data/api/requests/post_requests/assign_task_request.dart';
import 'package:yamaiter/data/api/requests/post_requests/chat/send_chat_message.dart';
import 'package:yamaiter/data/api/requests/post_requests/client/pay_for_consultation.dart';
import 'package:yamaiter/data/api/requests/post_requests/client/create_task_client.dart';
import 'package:yamaiter/data/api/requests/post_requests/client/register_client.dart';
import 'package:yamaiter/data/api/requests/post_requests/client/lawyers.dart';
import 'package:yamaiter/data/api/requests/post_requests/create_ad.dart';
import 'package:yamaiter/data/api/requests/post_requests/create_article.dart';
import 'package:yamaiter/data/api/requests/post_requests/create_task.dart';
import 'package:yamaiter/data/api/requests/post_requests/end_task.dart';
import 'package:yamaiter/data/api/requests/post_requests/invite_to_task.dart';
import 'package:yamaiter/data/api/requests/post_requests/loginRequest.dart';
import 'package:yamaiter/data/api/requests/post_requests/registerLawyerRequest.dart';
import 'package:yamaiter/data/api/requests/post_requests/search_for_lawyer.dart';
import 'package:yamaiter/data/api/requests/post_requests/update_task.dart';
import 'package:yamaiter/data/api/requests/post_requests/upload_task_file.dart';
import 'package:yamaiter/data/models/accept_terms/accept_terms_request_model.dart';
import 'package:yamaiter/data/models/ads/ad_model.dart';
import 'package:yamaiter/data/models/ads/create_ad_request_model.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/models/auth/register_client/register_client_request_model.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';
import 'package:yamaiter/data/models/chats/chat_room_by_id_request_model.dart';
import 'package:yamaiter/data/models/chats/received_chat_list_model.dart';
import 'package:yamaiter/data/models/success_model.dart';
import 'package:yamaiter/data/models/tasks/client/update_task_request_model.dart';
import 'package:yamaiter/data/models/tasks/create_task_request_model.dart';
import 'package:yamaiter/data/models/tasks/task_model.dart';
import 'package:yamaiter/data/models/tasks/update_task_request_model.dart';
import 'package:yamaiter/data/models/tasks/upload_task_params.dart';
import 'package:yamaiter/data/models/tax/tax_model.dart';
import 'package:yamaiter/data/params/accept_terms_params.dart';
import 'package:yamaiter/data/params/all_articles_params.dart';
import 'package:yamaiter/data/params/all_sos_params.dart';
import 'package:yamaiter/data/params/apply_for_task.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';
import 'package:yamaiter/data/params/chat/fetch_chats_lists_params.dart';
import 'package:yamaiter/data/params/chat_room_by_id_params.dart';
import 'package:yamaiter/data/params/client/create_consultation_params.dart';
import 'package:yamaiter/data/params/client/get_consultation_details.dart';
import 'package:yamaiter/data/params/client/get_my_consultations_params.dart';
import 'package:yamaiter/data/params/client/get_my_task_params_client.dart';
import 'package:yamaiter/data/params/client/get_single_task_params_client.dart';
import 'package:yamaiter/data/params/client/update_task_params.dart';
import 'package:yamaiter/data/params/create_ad_params.dart';
import 'package:yamaiter/data/params/create_article_params.dart';
import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/data/params/create_task_params.dart';
import 'package:yamaiter/data/params/create_tax_params.dart';
import 'package:yamaiter/data/params/decline_task_params.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';
import 'package:yamaiter/data/params/delete_task_params.dart';
import 'package:yamaiter/data/params/end_task_params.dart';
import 'package:yamaiter/data/params/filter_task_params.dart';
import 'package:yamaiter/data/params/get_all_task_params.dart';
import 'package:yamaiter/data/params/get_invited_task_params.dart';
import 'package:yamaiter/data/params/get_my_tasks_params.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';
import 'package:yamaiter/data/params/invite_to_task_params.dart';
import 'package:yamaiter/data/params/my_single_task_params.dart';
import 'package:yamaiter/data/params/no_params.dart';
import 'package:yamaiter/data/params/payment/check_payment_status_params.dart';
import 'package:yamaiter/data/params/payment/refund_params.dart';
import 'package:yamaiter/data/params/search_for_lawyer_params.dart';
import 'package:yamaiter/data/params/update_sos_params.dart';

import '../../domain/entities/app_error.dart';
import '../api/requests/get_requests/chat/get_chat_room.dart';
import '../api/requests/get_requests/chat/get_chats_list.dart';
import '../api/requests/get_requests/client/get_my_consultations.dart';
import '../api/requests/get_requests/client/get_single_task_details.dart';
import '../api/requests/get_requests/get_all_tasks.dart';
import '../api/requests/get_requests/get_applied_tasks_for_other.dart';
import '../api/requests/get_requests/get_completed_taxes.dart';
import '../api/requests/get_requests/get_my_ads.dart';
import '../api/requests/get_requests/get_single_article.dart';
import '../api/requests/post_requests/client/assign_task_client.dart';
import '../api/requests/post_requests/client/end_task_client.dart';
import '../api/requests/post_requests/client/update_task_client.dart';
import '../api/requests/post_requests/create_sos.dart';
import '../api/requests/post_requests/pay_for_tax.dart';
import '../api/requests/post_requests/payment/refund_request.dart';
import '../api/requests/post_requests/update_article.dart';
import '../api/requests/post_requests/update_sos.dart';
import '../models/accept_terms/accept_terms_response_model.dart';
import '../models/article/article_model.dart';
import '../models/auth/login/login_request.dart';
import '../models/auth/login/login_response.dart';
import '../models/auth/register_client/register_client_response_model.dart';
import '../models/chats/received_chat_room_response_model.dart';
import '../models/consultations/consultation_model.dart';
import '../models/pay_response_model.dart';
import '../models/sos/sos_model.dart';
import '../models/user_lawyer_model.dart';
import '../params/client/assign_task_params_client.dart';
import '../params/client/create_task_params.dart';
import '../params/client/delete_task_params.dart';
import '../params/client/end_task_params_client.dart';
import '../params/client/get_lawyers_params.dart';
import '../params/delete_sos_params.dart';
import '../params/get_applied_tasks_params.dart';
import '../params/get_taxes_params.dart';
import '../params/chat/send_chat_message.dart';
import '../params/update_task_params.dart';

abstract class RemoteDataSource {
  ///=============================>  chat_room <=============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  Future<dynamic> getChatRoomById(ChatRoomByIdParams chatRoomByIdParams);

  /// sendChatMessage
  Future<dynamic> sendChatMessage(SendChatMessageParams sendChatMessageParams);

  /// fetchChatList
  Future<dynamic> fetchChatList(FetchChatsListParams fetchChatsListParams);

  ///============================>  Client <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  /// registerClient
  Future<dynamic> registerClient(RegisterClientRequestModel params);

  /// getMyConsultations
  Future<dynamic> getMyConsultations(GetMyConsultationParams params);

  /// createConsultation
  Future<dynamic> createConsultation(PayForConsultationParams params);

  /// getConsultationDetails
  Future<dynamic> getConsultationDetails(GetConsultationDetailsParams params);

  /// createTaskClient
  Future<dynamic> createTaskClient(CreateTaskParamsClient params);

  /// getMyTaskClient
  Future<dynamic> getMyTaskClient(GetMyTasksClientParams params);

  /// get  single task client
  Future<dynamic> getSingleTaskClient(GetSingleTaskParamsClient params);

  /// end task client
  Future<dynamic> endTaskClient(EndTaskParamsClient params);

  /// assign task client
  Future<dynamic> assignTaskClient(AssignTaskParamsClient params);

  /// delete task client
  Future<dynamic> deleteTaskClient(DeleteTaskClientParams params);

  /// update task client
  Future<dynamic> updateTaskClient(UpdateTaskClientParams params);

  /// fetch lawyers
  Future<dynamic> fetchLawyers(GetLawyersParams params);

  ///============================>  Lawyer <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  /// login
  Future<dynamic> login(LoginRequestModel loginRequestModel);

  /// registerLawyer
  Future<dynamic> registerLawyer(RegisterRequestModel registerRequestModel);

  /// about
  Future<dynamic> getAbout(String userToken);

  /// termsAndConditions
  Future<dynamic> getTermsAndConditions(String userToken);

  /// privacyAndPolicy
  Future<dynamic> getPrivacyAndPolicy(String userToken);

  /// help
  Future<dynamic> getHelp(String userToken);

  /// create sos
  Future<dynamic> createSos(CreateSosParams params);

  /// get my sos
  Future<dynamic> getMySos(GetSosParams params);

  /// delete sos
  Future<dynamic> deleteSos(DeleteSosParams params);

  /// update sos
  Future<dynamic> updateSos(UpdateSosParams params);

  /// get all sos
  Future<dynamic> getAllSos(GetSosParams params);

  /// createTax
  Future<dynamic> payForTax(CreateTaxParams params);

  /// createArticle
  Future<dynamic> getAllArticles(GetArticlesParams params);

  /// createArticle
  Future<dynamic> createArticle(CreateOrUpdateArticleParams params);

  /// updateArticle
  Future<dynamic> updateArticle(CreateOrUpdateArticleParams params);

  /// fetchSingleArticleArticle
  Future<dynamic> fetchSingleArticleArticle(GetSingleArticleParams params);

  /// fetchSingleArticleArticle
  Future<dynamic> fetchMyArticles(String userToken);

  /// delete article
  Future<dynamic> deleteArticle(DeleteArticleParams params);

  /// create new ad
  Future<dynamic> createAd(CreateAdParams params);

  /// fetchInProgressTaxes
  Future<dynamic> fetchInProgressTaxes(GetTaxesParams params);

  /// fetchCompletedTaxes
  Future<dynamic> fetchCompletedTaxes(GetTaxesParams params);

  /// get my ads
  Future<dynamic> getMyAds(String userToken);

  /// create task
  Future<dynamic> createTask(CreateTaskParams params);

  /// pay to assign task
  Future<dynamic> payToAssignTask(PayForTaskParams params);

  /// get my my_tasks
  Future<dynamic> getMyTasks(GetMyTasksParams params);

  /// get my single my_tasks
  Future<dynamic> getMySingleTasks(GetSingleTaskParams params);

  /// update task
  Future<dynamic> updateTask(UpdateTaskParams params);

  /// delete task
  Future<dynamic> deleteTask(DeleteTaskParams params);

  /// update task
  Future<dynamic> endTask(EndTaskParams params);

  /// get my my_tasks
  Future<dynamic> getAppliedTasks(GetAppliedTasksParams params);

  /// get single task
  Future<dynamic> applyForTask(ApplyForTaskParams params);

  /// get accept terms
  Future<dynamic> getAcceptTerms(String token);

  /// upload task file
  Future<dynamic> uploadTaskFile(UploadTaskFileParams params);

  /// accept terms
  Future<dynamic> acceptTerms(AcceptTermsParams params);

  /// get all my_tasks
  Future<dynamic> getAllTasks(GetAllTasksParams params);

  /// get invited tasks
  Future<dynamic> getInvitedTasks(GetInvitedTasksParams params);

  /// get invited tasks
  Future<dynamic> declineInvitedTasks(DeclineTaskParams params);

  /// search for lawyer
  Future<dynamic> searchForLawyer(SearchForLawyerParams params);

  /// invite to task
  Future<dynamic> inviteToTask(InviteToTaskParams params);

  /// filter tasks
  Future<dynamic> filterTasks(FilterTasksParams params);

  ///===========================>  Payment <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  /// check payment status tasks
  Future<dynamic> getPaymentStatus(CheckPaymentStatusParams params);

  /// refund
  Future<dynamic> refundPayment(RefundParams params);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  RemoteDataSourceImpl();

  ///============================>  Chat <==============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  @override
  Future<dynamic> getChatRoomById(ChatRoomByIdParams chatRoomByIdParams) async {
    try {
      log("createTaskClient >> Start request");
      // init request
      final request = GetChatRoom();

      // response
      final response = await request(chatRoomByIdParams);

      log("getChatRoomById >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return receivedChatRoomResponseModelFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getChatRoomById body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getChatRoomById body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getChatRoomById body >> ${response.body}");
        // default
        default:
          log("getChatRoomById >> ResponseCode: ${response.body}");
          return AppError(AppErrorType.api,
              message: "getChatRoomById body >> ${response.body}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getChatRoomById >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "createTaskClient UnHandledError >> $e");
    }
  }

  /// sendChatMessage
  @override
  Future<dynamic> sendChatMessage(
      SendChatMessageParams sendChatMessageParams) async {
    try {
      log("sendChatMessage >> Start request"); // init request

      // sendChatMessageRequest
      final sendChatMessageRequest = SendChatMessageRequest();

      // init request
      final request = await sendChatMessageRequest(sendChatMessageParams);

      // send a request
      final streamResponse = await request.send();

      // retrieve a response from stream response
      final response = await http.Response.fromStream(streamResponse);

      log("sendChatMessage >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "sendChatMessage body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "sendChatMessage body >> ${response.body}");
        // default
        default:
          log("sendChatMessage >> ResponseCode: ${response.body}");
          return AppError(AppErrorType.api,
              message: "sendChatMessage body >> ${response.body}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("sendChatMessage >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "sendChatMessage UnHandledError >> $e");
    }
  }

  @override
  Future<dynamic> fetchChatList(
      FetchChatsListParams fetchChatsListParams) async {
    try {
      log("fetchChatList >> Start request"); // init request

      // init request
      final request = GetChatListRequest();

      // response
      final response = await request(fetchChatsListParams);

      log("fetchChatList >> ResponseCode: ${response.statusCode}");
      switch (response.statusCode) {
        // success
        case 200:
          return receivedChatListResponseModelFromJson(response.body);
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "fetchChatList body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "fetchChatList body >> ${response.body}");
        // default
        default:
          log("fetchChatList >> ResponseCode: ${response.body}");
          return AppError(AppErrorType.api,
              message: "fetchChatList body >> ${response.body}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("fetchChatList >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "fetchChatList UnHandledError >> $e");
    }
  }

  ///============================>  Client <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  /// registerClient
  @override
  Future registerClient(RegisterClientRequestModel params) async {
    try {
      log("registerClient >> Start request");
      // init request
      final request = RegisterClientRequest();

      // response
      final response = await request(params, NoParams());

      log("registerClient >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return registerClientResponseModelFromJson(response.body);
        // UnProcessable Entity
        case 422:
          log("registerClient >> ResponseBody: ${response.body}");
          //==> alreadyEmailUsedBefore
          if (response.body.contains("alreadyEmailUsedBefore")) {
            return AppError(AppErrorType.emailAlreadyExists,
                message:
                    "registerClient Status Code >> ${response.statusCode}");
          }

          //==> alreadyEmailUsedBefore
          else if (response.body.contains("alreadyPhoneUsedBefore")) {
            return AppError(AppErrorType.alreadyPhoneUsedBefore,
                message:
                    "registerClient Status Code >> ${response.statusCode}");
          }

          return AppError(AppErrorType.api,
              message: "registerClient Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
        // unAuthorized
        case 401:
          log("registerClient >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.unauthorizedUser,
              message: "registerClient Status Code >> ${response.statusCode}");
        // default
        default:
          log("registerClient >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.api,
              message: "registerClient Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("registerClient >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "registerClient UnHandledError >> $e");
    }
  }

  /// createTaskClient
  @override
  Future<dynamic> createTaskClient(CreateTaskParamsClient params) async {
    try {
      log("createTaskClient >> Start request");
      // init request
      final request = CreateTaskClientRequest();

      // response
      final response =
          await request(params.createTaskRequestModelClient, params.userToken);

      log("createTaskClient >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "createTaskClient body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "createTaskClient body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "createTaskClient body >> ${response.body}");
        // default
        default:
          log("createTaskClient >> ResponseCode: ${response.body}");
          return AppError(AppErrorType.api,
              message: "createTaskClient body >> ${response.body}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("createTaskClient >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "createTaskClient UnHandledError >> $e");
    }
  }

  /// getMyConsultations
  @override
  Future<dynamic> getMyConsultations(GetMyConsultationParams params) async {
    try {
      log("getMyConsultations >> Start request");
      // init request
      final request = GetMyConsultationsRequest();

      // response
      final response = await request(params);

      log("getMyConsultations >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return listOfMyConsultationsFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getMyConsultations body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getMyConsultations body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getMyConsultations body >> ${response.body}");
        // default
        default:
          log("getMyConsultations >> ResponseCode: ${response.body}");
          return AppError(AppErrorType.api,
              message: "getMyConsultations body >> ${response.body}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getMyConsultations >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getMyConsultations UnHandledError >> $e");
    }
  }

  /// createConsultation
  @override
  Future<dynamic> createConsultation(PayForConsultationParams params) async {
    // init request
    final createConsultationRequest = PayForConsultationRequest();
    final request = await createConsultationRequest(params);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("createConsultation >> ResponseCode: ${response.statusCode}");
    log("createConsultation >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
    switch (response.statusCode) {
      // success
      case 200:
        return payResponseFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message:
                "createConsultation Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "createConsultation Status Code >> ${response.statusCode}");
      // default
      default:
        log("createConsultation >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "createConsultation Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
    try {} catch (e) {
      log("createConsultation >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "createConsultation UnHandledError >> $e");
    }
  }

  /// getMyTaskClient
  @override
  Future<dynamic> getMyTaskClient(GetMyTasksClientParams params) async {
    try {
      // init request
      final request = GetMyTasksClientRequest();

      // response
      final response = await request(params);

      log("getMyTaskClient >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return listOfTasksFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getMyTaskClient body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getMyTaskClient body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getMyTaskClient body >> ${response.body}");
        // default
        default:
          log("getMyTaskClient >> ResponseCode: ${response.body}");
          return AppError(AppErrorType.api,
              message: "getMyTaskClient body >> ${response.body}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getMyTaskClient >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getMyTaskClient UnHandledError >> $e");
    }
  }

  /// get  single task client
  @override
  Future<dynamic> getSingleTaskClient(GetSingleTaskParamsClient params) async {
    try {
      log("getSingleTaskClient >> Start request");
      // init request
      final request = GetSingleTaskClientRequest();

      // response
      final response = await request(params);

      log("getSingleTaskClient >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return taskModelFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getSingleTaskClient body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getSingleTaskClient body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getSingleTaskClient body >> ${response.body}");
        // default
        default:
          log("getSingleTaskClient body >> ${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message:
                  "getSingleTaskClient Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getSingleTaskClient >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getSingleTaskClient UnHandledError >> $e");
    }
  }

  /// endTaskClient
  @override
  Future<dynamic> endTaskClient(EndTaskParamsClient params) async {
    try {
      log("endTaskClient >> Start request");
      // init request
      final request = EndTaskClientRequest();

      // response
      final response = await request(params, params.userToken);

      log("endTaskClient >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          {
            if (response.body.contains("notAllowedToCompleted")) {
              return const AppError(AppErrorType.idNotFound,
                  message: "The task is not found");
            } else {
              return SuccessModel();
            }
          }

        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "endTaskClient body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "endTaskClient body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "endTaskClient body >> ${response.body}");
        // default
        default:
          log("endTaskClient >> body:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "endTaskClient Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("endTaskClient >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "endTaskClient UnHandledError >> $e");
    }
  }

  /// assignTaskClient
  @override
  Future<dynamic> assignTaskClient(AssignTaskParamsClient params) async {
    try {
      log("assignTaskClient >> Start request");
      // init request
      final request = AssignTaskClientRequest();

      // response
      final response = await request(params, params.userToken);

      log("assignTaskClient >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          {
            if (response.body.contains("notAllowedToCompleted")) {
              return const AppError(AppErrorType.idNotFound,
                  message: "The task is not found");
            } else {
              return SuccessModel();
            }
          }

        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "assignTaskClient body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "assignTaskClient body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "assignTaskClient body >> ${response.body}");
        // default
        default:
          log("assignTaskClient >> body:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "assignTaskClient Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("assignTaskClient >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "assignTaskClient UnHandledError >> $e");
    }
  }

  /// deleteTaskClient
  @override
  Future<dynamic> deleteTaskClient(DeleteTaskClientParams params) async {
    try {
      log("deleteTaskClient >> Start request");
      // init request
      final request = DeleteTaskClientRequest();

      // response
      final response = await request(params);

      log("deleteTaskClient >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();

        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "deleteTaskClient body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "deleteTaskClient body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "deleteTaskClient body >> ${response.body}");
        // default
        default:
          log("deleteTaskClient >> body:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "deleteTaskClient Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("deleteTaskClient >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "deleteTaskClient UnHandledError >> $e");
    }
  }

  /// updateTaskClient
  @override
  Future<dynamic> updateTaskClient(UpdateTaskClientParams params) async {
    try {
      log("updateTaskClient >> Start request");
      // init request
      final request = UpdateTaskClientRequest();

      // response
      final response = await request(
        UpdateTaskClientRequestModel.fromParams(params: params),
        params.userToken,
      );

      log("updateTaskClient >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();

        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "updateTaskClient body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "updateTaskClient body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "updateTaskClient body >> ${response.body}");
        // default
        default:
          log("updateTaskClient >> body:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "updateTaskClient Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("updateTaskClient >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "updateTaskClient UnHandledError >> $e");
    }
  }

  /// fetchLawyers
  @override
  Future<dynamic> fetchLawyers(GetLawyersParams params) async {
    try {
      log("topRatedLawyers >> Start request");
      // init request
      final request = FetchLawyersRequest();

      // response
      final response = await request(params, params.userToken);

      log("topRatedLawyers >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return lawyersListFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "topRatedLawyers body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "topRatedLawyers body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "topRatedLawyers body >> ${response.body}");
        // default
        default:
          log("topRatedLawyers >> body:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "topRatedLawyers Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("topRatedLawyers >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "topRatedLawyers UnHandledError >> $e");
    }
  }

  /// getConsultationDetails
  @override
  Future<dynamic> getConsultationDetails(
      GetConsultationDetailsParams params) async {
    try {
      log("getConsultationDetails >> Start request");
      // init request
      final request = GetConsultationDetailsRequest();

      // response
      final response = await request(params);

      log("getConsultationDetails >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return consultationFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getConsultationDetails body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getConsultationDetails body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getConsultationDetails body >> ${response.body}");
        // default
        default:
          log("getConsultationDetails >> body:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message:
                  "getConsultationDetails Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getConsultationDetails >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getConsultationDetails UnHandledError >> $e");
    }
  }

  ///============================>  Lawyer <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  /// Login
  @override
  Future<dynamic> login(LoginRequestModel loginRequestModel) async {
    // init request
    final loginRequest = LoginRequest();
    final request = await loginRequest(loginRequestModel);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("Login >> ResponseCode: ${response.statusCode}, Body:${response.body}");
    switch (response.statusCode) {
      // success
      case 200:
        return loginResponseModelFromJson(response.body);
      // wrong email or password
      case 422:
        if (response.body.contains("incorrectUserPassword")) {
          return const AppError(AppErrorType.wrongPassword);
        } else {
          return const AppError(AppErrorType.wrongEmail);
        }
      // wrong password
      case 401:
        return const AppError(AppErrorType.wrongPassword);
      // default
      default:
        return AppError(AppErrorType.api,
            message: "Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future registerLawyer(RegisterRequestModel registerRequestModel) async {
    // init request
    final registerRequest = RegisterLawyerRequest();
    final request = await registerRequest(registerRequestModel);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("registerLawyer >> ResponseCode: ${response.statusCode}");
    switch (response.statusCode) {
      // success
      case 200:
        return registerResponseModelFromJson(response.body);
      // default
      default:
        return AppError(AppErrorType.api,
            message: "Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// about
  @override
  Future getAbout(String userToken) async {
    log("getAbout >> Start request");
    // init request
    final getAbout = GetAboutRequest();

    // response
    final response = await getAbout(userToken);

    log("getAbout >> ResponseCode: ${response.statusCode}, ");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfSideMenuResponseModels(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// help
  @override
  Future getHelp(String userToken) async {
    log("getHelp >> Start request");
    // init request
    final getHelpRequest = GetHelpRequest();

    // response
    final response = await getHelpRequest(userToken);

    log("getHelp >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfHelpQuestionModel(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "getHelp Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "getHelp Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// privacyAndPolicy
  @override
  Future getPrivacyAndPolicy(String userToken) async {
    log("getPrivacyAndPolicy >> Start request");
    // init request
    final getPrivacyRequest = GetPrivacyRequest();

    // response
    final response = await getPrivacyRequest(userToken);

    log("getPrivacyAndPolicy >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfSideMenuResponseModels(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "getPrivacyAndPolicy Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "getPrivacyAndPolicy Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// termsAndConditions
  @override
  Future getTermsAndConditions(String userToken) async {
    log("termsAndConditions >> Start request");
    // init request
    final getTermsAndConditions = GetTermsAndConditionsRequest();

    // response
    final response = await getTermsAndConditions(userToken);

    log("termsAndConditions >> ResponseCode: ${response.statusCode},");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfSideMenuResponseModels(jsonDecode(response.body)["data"]);
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "termsAndConditions Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "termsAndConditions Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// CreateSosParams
  @override
  Future createSos(CreateSosParams params) async {
    log("createSos >> Start request");
    // init request
    final createSos = CreateSosRequest();

    // response
    final response = await createSos(params.sosRequestModel, params.token);

    log("createSos >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createSos Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createSos Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "createSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// updateSos
  @override
  Future updateSos(UpdateSosParams params) async {
    log("updateSos >> Start request");
    // init request
    final updateRequest = UpdateSosRequest();

    // response
    final response = await updateRequest(params, params.token);

    log("updateSos >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "updateSos Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "updateSos Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "updateSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future getMySos(GetSosParams params) async {
    try {
      log("getMySos >> Start request");
      // init request
      final getMySos = GetMySosRequest();

      // response
      final response = await getMySos(params);

      log("getMySos >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return mySosResponseModelFromDistressDataJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getMySos Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getMySos Status Code >> ${response.statusCode}");
        // default
        default:
          return AppError(AppErrorType.api,
              message: "getMySos Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } on Exception catch (ze) {
      rethrow;
    }
  }

  @override
  Future getAllSos(GetSosParams params) async {
    try {
      log("getAllSos >> Start request");
      // init request
      final allSosRequest = GetAllSosRequest();

      // response
      final response = await allSosRequest(params);

      log("getAllSos >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return mySosResponseModelFromAllDistressDataCallsJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getAllSos Status Body >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getAllSos Status Body >> ${response.body}");
        // default
        default:
          log("getAllSos >> ResponseCode: ${response.statusCode} \n Body: ${response.body}");
          return AppError(AppErrorType.api,
              message: "getAllSos Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getAllSos >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getAllSos UnHandledError >> $e");
    }
  }

  @override
  Future getAllArticles(GetArticlesParams params) async {
    log("getAllArticles >> Start request");
    // init request
    final getRequest = GetAllArticlesRequest();

    // response
    final response = await getRequest(params);

    log("getAllArticles >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return allArticlesFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "getAllArticles Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "getAllArticles Status Code >> ${response.statusCode}");
      // default
      default:
        log("getAllArticles >> ResponseCode: ${response.statusCode} \n Body: ${response.body}");
        return AppError(AppErrorType.api,
            message: "getAllArticles Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// createArticle
  @override
  Future createArticle(CreateOrUpdateArticleParams params) async {
    // init request
    final createArticleRequest = CreateArticleRequest();
    final request = await createArticleRequest(params);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("createArticle >> ResponseCode: ${response.statusCode}");
    log("createArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createArticle Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createArticle Status Code >> ${response.statusCode}");
      // default
      default:
        log("createArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "createArticle Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future fetchSingleArticleArticle(GetSingleArticleParams params) async {
    log("fetchSingleArticleArticle >> Start request");
    // init request
    final getRequest = GetSingleArticleRequest();

    // response
    final response = await getRequest(params);

    log("fetchSingleArticleArticle >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return articleModelFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message:
                "fetchSingleArticleArticle Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "fetchSingleArticleArticle Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message:
                "fetchSingleArticleArticle Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future fetchMyArticles(String userToken) async {
    log("fetchMyArticles >> Start request");
    // init request
    final getRequest = GetMyArticlesRequest();

    // response
    final response = await getRequest(userToken);

    log("fetchMyArticles >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return myArticlesFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "fetchMyArticles Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "fetchMyArticles Status Code >> ${response.statusCode}");
      // default
      default:
        log("fetchMyArticles >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "fetchMyArticles Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// DeleteArticleParams
  @override
  Future deleteArticle(DeleteArticleParams params) async {
    log("deleteArticle >> Start request");
    // init request
    final deleteRequest = DeleteArticleRequest();

    // response
    final response = await deleteRequest(params);

    log("deleteArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "deleteArticle Status Code >> ${response.statusCode}");
      // not found
      case 404:
        return AppError(AppErrorType.notFound,
            message: "deleteArticle Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "deleteArticle Status Code >> ${response.statusCode}");
      // default
      default:
        log("deleteArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "deleteArticle Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// updateArticle
  @override
  Future updateArticle(CreateOrUpdateArticleParams params) async {
    // init request
    final updateArticleRequest = UpdateArticleRequest();
    final request = await updateArticleRequest(params);

    // send a request
    final streamResponse = await request.send();

    // retrieve a response from stream response
    final response = await http.Response.fromStream(streamResponse);
    log("updateArticle >> ResponseCode: ${response.statusCode}");
    log("updateArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "updateArticle Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "updateArticle Status Code >> ${response.statusCode}");
      // default
      default:
        log("createArticle >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "createArticle Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// createAd
  @override
  Future createAd(CreateAdParams params) async {
    log("createAd >> Start request");
    // init request
    final createAd = CreateAdRequest();

    // response
    final response = await createAd(
      CreateAdRequestModel(place: params.place),
      params.userToken,
    );

    log("createAd >> ResponseCode: ${response.statusCode},Body: ${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createAd Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createAd Status Code >> ${response.statusCode}");
      // default
      default:
        return AppError(AppErrorType.api,
            message: "createAd Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future payForTax(CreateTaxParams params) async {
    try {
      // init request
      final createTaxRequest = CreateTaxRequest();
      final request = await createTaxRequest(params);

      // send a request
      final streamResponse = await request.send();

      // retrieve a response from stream response
      final response = await http.Response.fromStream(streamResponse);
      log("payForTax >> ResponseCode: ${response.statusCode}");
      switch (response.statusCode) {
        // success
        case 200:
          {
            log("payForTax >> body:${response.body}");
            return payResponseFromJson(response.body);
          }
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "payForTax Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "payForTax Status Code >> ${response.statusCode}");
        // default
        default:
          log("payForTax >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "payForTax Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("payForTax >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "payForTax UnHandledError >> $e");
    }
  }

  /// fetchInProgressTaxes
  @override
  Future fetchInProgressTaxes(GetTaxesParams params) async {
    log("fetchInProgressTaxes >> Start request");
    // init request
    final getRequest = GetInProgressTaxesRequest();

    // response
    final response = await getRequest(params);

    log("fetchInProgressTaxes >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfInProgressTaxesFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message:
                "fetchInProgressTaxes Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "fetchInProgressTaxes Status Code >> ${response.statusCode}");
      // default
      default:
        log("fetchInProgressTaxes >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message:
                "fetchInProgressTaxes Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future fetchCompletedTaxes(GetTaxesParams params) async {
    log("fetchCompletedTaxes >> Start request");
    // init request
    final getRequest = GetCompletedTaxesRequest();

    // response
    final response = await getRequest(params);

    log("fetchCompletedTaxes >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfCompletedTaxesFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message:
                "fetchCompletedTaxes Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message:
                "fetchCompletedTaxes Status Code >> ${response.statusCode}");
      // default
      default:
        log("fetchCompletedTaxes >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "fetchCompletedTaxes Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  @override
  Future getMyAds(String userToken) async {
    log("getMyAds >> Start request");
    // init request
    final getRequest = GetMyAdsRequest();

    // response
    final response = await getRequest(userToken);

    log("getMyAds >> ResponseCode: ${response.statusCode}");

    switch (response.statusCode) {
      // success
      case 200:
        return listOfAdsFromJson(response.body);
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "getMyAds Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "getMyAds Status Code >> ${response.statusCode}");
      // default
      default:
        log("getMyAds >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "getMyAds Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// deleteSos
  @override
  Future deleteSos(DeleteSosParams params) async {
    log("deleteSos >> Start request");
    // init request
    final deleteRequest = DeleteSosRequest();

    // response
    final response = await deleteRequest(params);

    log("deleteSos >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "deleteSos Status Code >> ${response.statusCode}");
      // not found
      case 404:
        return AppError(AppErrorType.notFound,
            message: "deleteSos Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "deleteSos Status Code >> ${response.statusCode}");
      // default
      default:
        log("deleteSos >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "deleteSos Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// getAcceptTerms
  @override
  Future getAcceptTerms(String token) async {
    try {
      log("getAcceptTerms >> Start request");
      // init request
      final request = GetAcceptTermsRequest();

      // response
      final response = await request(token);

      log("getAcceptTerms >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

      switch (response.statusCode) {
        // success
        case 200:
          return acceptTermsResponseModel(jsonDecode(response.body));
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getAcceptTerms Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getAcceptTerms Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getAcceptTerms Status Code >> ${response.statusCode}");
        // default
        default:
          log("getAcceptTerms >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "acceptTerms Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("acceptTerms >> Exception: $e");
      return AppError(AppErrorType.unHandledError,
          message: "acceptTerms UnHandledError >> $e");
    }
  }

  /// acceptTerms
  @override
  Future acceptTerms(AcceptTermsParams params) async {
    log("acceptTerms >> Start request");
    // init request
    final request = AcceptTermsRequest();

    // response
    final response =
        await request(AcceptTermsModel.fromParams(params), params.userToken);

    log("acceptTerms >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        return SuccessModel();
      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "acceptTerms Status Code >> ${response.statusCode}");
      // not found
      case 404:
        return AppError(AppErrorType.notFound,
            message: "acceptTerms Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "acceptTerms Status Code >> ${response.statusCode}");
      // default
      default:
        log("acceptTerms >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "acceptTerms Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// createTask
  @override
  Future createTask(CreateTaskParams params) async {
    log("createTask >> Start request");
    // init request
    final request = CreateTaskRequest();

    // response
    final response = await request(
        CreateTaskRequestModel.fromParams(params: params), params.userToken);

    log("createTask >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

    switch (response.statusCode) {
      // success
      case 200:
        {
          return response.body.contains("notAcceptedYet")
              ? AppError(AppErrorType.notAcceptedYet,
                  message: "createTask Status Code >> ${response.statusCode}")
              : SuccessModel();
        }

      // notActivatedUser
      case 403:
        return AppError(AppErrorType.notActivatedUser,
            message: "createTask Status Code >> ${response.statusCode}");
      // not found
      case 404:
        return AppError(AppErrorType.notFound,
            message: "createTask Status Code >> ${response.statusCode}");
      // unAuthorized
      case 401:
        return AppError(AppErrorType.unauthorizedUser,
            message: "createTask Status Code >> ${response.statusCode}");
      // default
      default:
        log("createTask >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
        return AppError(AppErrorType.api,
            message: "createTask Status Code >> ${response.statusCode}"
                " \n Body: ${response.body}");
    }
  }

  /// getMyTasks
  @override
  Future getMyTasks(GetMyTasksParams params) async {
    try {
      log("getMyTasks >> Start request");
      // init request
      final request = GetMyTasksRequest();

      // response
      final response = await request(params);

      log("getMyTasks >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return listOfTasksFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getMyTasks Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getMyTasks Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getMyTasks Status Code >> ${response.statusCode}");
        // default
        default:
          log("getMyTasks >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "getMyTasks Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getMyTasks >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getMyTasks UnHandledError >> $e");
    }
  }

  @override
  Future getMySingleTasks(GetSingleTaskParams params) async {
    try {
      log("getMySingleTasks >> Start request");
      // init request
      final request = GetMySingleTaskRequest();

      // response
      final response = await request(params);

      log("getMySingleTasks >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return taskModelFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message:
                  "getMySingleTasks Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message:
                  "getMySingleTasks Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message:
                  "getMySingleTasks Status Code >> ${response.statusCode}");
        // default
        default:
          log("getMySingleTasks >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "getMyTasks Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getMySingleTasks >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getMySingleTasks UnHandledError >> $e");
    }
  }

  @override
  Future updateTask(UpdateTaskParams params) async {
    try {
      log("updateTask >> Start request");
      // init request
      final request = UpdateTaskRequest();

      // response
      final response = await request(
          UpdateTaskRequestModel.fromParams(params: params), params.userToken);

      log("updateTask >> ResponseCode: ${response.statusCode},\nBody: ${response.body}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "updateTask Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "updateTask Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "updateTask Status Code >> ${response.statusCode}");
        // default
        default:
          log("updateTask >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "updateTask Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      return AppError(AppErrorType.unHandledError,
          message: "updateTask UnHandledError >> $e");
    }
  }

  @override
  Future deleteTask(DeleteTaskParams params) async {
    try {
      log("deleteTask >> Start request");
      // init request
      final request = DeleteTaskRequest();

      // response
      final response = await request(params);

      log("deleteTask >> ResponseCode: ${response.statusCode},\nBody: ${response.body}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "deleteTask Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "deleteTask Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "updateTask Status Code >> ${response.statusCode}");
        // default
        default:
          log("deleteTask >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "deleteTask Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("deleteTask >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "deleteTask UnHandledError >> $e");
    }
  }

  /// getAllTasks
  @override
  Future getAllTasks(GetAllTasksParams params) async {
    try {
      log("getAllTasks >> Start request");
      // init request
      final request = GetAllTasksRequest();

      // response
      final response = await request(params);

      log("getAllTasks >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return listOfTasksFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getAllTasks Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getAllTasks Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getAllTasks Status Code >> ${response.statusCode}");
        // default
        default:
          log("getAllTasks >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "getAllTasks Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getAllTasks >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getAllTasks UnHandledError >> $e");
    }
  }

  /// payToAssignTask
  @override
  Future payToAssignTask(PayForTaskParams params) async {
    try {
      log("payToAssignTask >> Start request");
      // init request
      final request = PayToAssignTaskRequest();

      // response
      final response = await request(params, params.userToken);

      log("payToAssignTask >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return payResponseFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "payToAssignTask body >> ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "payToAssignTask Status Code >> ${response.body}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "payToAssignTask body >> ${response.body}");
        // default
        default:
          log("payToAssignTask >> body:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "payToAssignTask Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("payToAssignTask >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "payToAssignTask UnHandledError >> $e");
    }
  }

  @override
  Future endTask(EndTaskParams params) async {
    try {
      log("endTask >> Start request");
      // init request
      final request = EndTaskRequest();

      // response
      final response = await request(params, params.userToken);

      log("endTask >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          {
            if (response.body.contains("notAllowedToCompleted")) {
              return const AppError(AppErrorType.idNotFound,
                  message: "The task is not found");
            } else {
              return SuccessModel();
            }
          }

        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "endTask Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "endTask Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "endTask Status Code >> ${response.statusCode}");
        // default
        default:
          log("endTask >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "assignTask Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("endTask >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "endTask UnHandledError >> $e");
    }
  }

  /// getAppliedTasksTasks
  @override
  Future getAppliedTasks(GetAppliedTasksParams params) async {
    try {
      log("getAppliedTasksTasks >> Start request");
      // init request
      final request = GetAppliedTasksForOtherRequest();

      // response
      final response = await request(params);

      log("getAppliedTasksTasks >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return listOfTasksFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message:
                  "getAppliedTasksTasks Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message:
                  "getAppliedTasksTasks Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message:
                  "getAppliedTasksTasks Status Code >> ${response.statusCode}");
        // default
        default:
          log("getAppliedTasksTasks >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message:
                  "getAppliedTasksTasks Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getAppliedTasksTasks >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getAppliedTasksTasks UnHandledError >> $e");
    }
  }

  /// getSingleTask
  @override
  Future applyForTask(ApplyForTaskParams params) async {
    try {
      log("applyForTask >> Start request");
      // init request
      final request = ApplyForTaskRequest();

      // response
      final response = await request(params, params.userToken);

      log("applyForTask >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();
        // notActivatedUser
        case 403:
          log("applyForTask >> body:${jsonDecode(response.body)}");
          if (response.body.contains("alreadyAppliedBefore")) {
            return AppError(AppErrorType.alreadyAppliedToThisTask,
                message:
                    "applyForTask Status Code >> ${response.statusCode},Body: ${response.body}");
          }
          return AppError(AppErrorType.notActivatedUser,
              message:
                  "applyForTask Status Code >> ${response.statusCode},Body: ${response.body}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "applyForTask Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "applyForTask Status Code >> ${response.statusCode}");
        // default
        default:
          log("applyForTask >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "assignTask Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("applyForTask >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "assignTask UnHandledError >> $e");
    }
  }

  /// uploadTaskFile
  @override
  Future uploadTaskFile(UploadTaskFileParams params) async {
    try {
      log("uploadTaskFile >> Start request");

      // init request
      final createArticleRequest = UploadTaskFileRequest();
      final request = await createArticleRequest(params);

      // send a request
      final streamResponse = await request.send();

      // retrieve a response from stream response
      final response = await http.Response.fromStream(streamResponse);
      log("uploadTaskFile >> ResponseCode: ${response.statusCode}");
      log("uploadTaskFile >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "uploadTaskFile Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "uploadTaskFile Status Code >> ${response.statusCode}");
        // default
        default:
          log("uploadTaskFile >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "uploadTaskFile Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("uploadTaskFile >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "uploadTaskFile UnHandledError >> $e");
    }
  }

  /// getInvitedTasks
  @override
  Future getInvitedTasks(GetInvitedTasksParams params) async {
    try {
      log("getInvitedTasks >> Start request");
      // init request
      final request = GetInvitedTasksRequest();

      // response
      final response = await request(params);

      log("getInvitedTasks >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return listOfTasksFromJson(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "getInvitedTasks Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "getInvitedTasks Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "getInvitedTasks Status Code >> ${response.statusCode}");
        // default
        default:
          log("getInvitedTasks >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "getInvitedTasks Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getInvitedTasks >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getInvitedTasks UnHandledError >> $e");
    }
  }

  /// declineInvitedTasks
  @override
  Future declineInvitedTasks(DeclineTaskParams params) async {
    try {
      log("declineInvitedTasks >> Start request");
      // init request
      final request = DeclineTaskRequest();

      // response
      final response = await request(params);

      log("declineInvitedTasks >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message:
                  "declineInvitedTasks Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message:
                  "declineInvitedTasks Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message:
                  "declineInvitedTasks Status Code >> ${response.statusCode}");
        // default
        default:
          log("declineInvitedTasks >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message:
                  "declineInvitedTasks Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("declineInvitedTasks >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "declineInvitedTasks UnHandledError >> $e");
    }
  }

  /// searchForLawyer
  @override
  Future searchForLawyer(SearchForLawyerParams params) async {
    try {
      log("searchForLawyer >> Start request");
      // init request
      final request = SearchForLawyerRequest();

      // response
      final response = await request(params, params.userToken);

      log("searchForLawyer >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return resultOfSearchForLawyer(response.body);
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "searchForLawyer Status Code >> ${response.statusCode}");
        // not found
        case 404:
          return AppError(AppErrorType.notFound,
              message: "searchForLawyer Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "searchForLawyer Status Code >> ${response.statusCode}");
        // default
        default:
          log("searchForLawyer >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "searchForLawyer Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("searchForLawyer >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "searchForLawyer UnHandledError >> $e");
    }
  }

  /// inviteToTask
  @override
  Future inviteToTask(InviteToTaskParams params) async {
    try {
      log("inviteToTask >> Start request");
      // init request
      final request = InviteToTaskTaskRequest();

      // response
      final response = await request(params, params.userToken);

      log("inviteToTask >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return SuccessModel();
        // notActivatedUser
        case 403:
          return AppError(AppErrorType.notActivatedUser,
              message: "inviteToTask Status Code >> ${response.statusCode}");
        // not found
        case 404:
          log("inviteToTask >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.notFound,
              message: "inviteToTask Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          return AppError(AppErrorType.unauthorizedUser,
              message: "inviteToTask Status Code >> ${response.statusCode}");
        // default
        default:
          log("inviteToTask >> ResponseCode: ${response.statusCode}, \nbody:${jsonDecode(response.body)}");
          return AppError(AppErrorType.api,
              message: "inviteToTask Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("inviteToTask >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "inviteToTask UnHandledError >> $e");
    }
  }

  /// filterTasks
  @override
  Future filterTasks(FilterTasksParams params) async {
    try {
      log("filterTasks >> Start request");
      // init request
      final request = FilterTasksRequest();

      // response
      final response = await request(params);

      log("filterTasks >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          return listOfTasksFromJson(response.body);
        // notActivatedUser
        case 403:
          log("filterTasks >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.notActivatedUser,
              message: "filterTasks Status Code >> ${response.statusCode}");
        // not found
        case 404:
          log("filterTasks >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.notFound,
              message: "filterTasks Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          log("filterTasks >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.unauthorizedUser,
              message: "filterTasks Status Code >> ${response.statusCode}");
        // default
        default:
          log("filterTasks >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.api,
              message: "filterTasks Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("filterTasks >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "filterTasks UnHandledError >> $e");
    }
  }

  /// getPaymentStatus
  @override
  Future getPaymentStatus(CheckPaymentStatusParams params) async {
    try {
      log("getPaymentStatus >> Start request");
      // init request
      final request = CheckPaymentStatusRequest();

      // response
      final response = await request(params);

      log("getPaymentStatus >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          log("getPaymentStatus >> ResponseBody: ${json.decode(response.body)}");
          return SuccessModel();
        // notAPaymentProcess
        case 403:
          log("getPaymentStatus >> ResponseBody: ${json.decode(response.body)}");
          return AppError(AppErrorType.notAPaymentProcess,
              message:
                  "getPaymentStatus Status Code >> ${response.statusCode}");
        // payment Failed
        case 422:
          log("getPaymentStatus >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.paymentFailed,
              message:
                  "getPaymentStatus Status Code >> ${response.statusCode}");
        // not found
        case 404:
          log("getPaymentStatus >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.notFound,
              message:
                  "getPaymentStatus Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          log("getPaymentStatus >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.unauthorizedUser,
              message:
                  "getPaymentStatus Status Code >> ${response.statusCode}");

        // default
        default:
          log("getPaymentStatus >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.api,
              message: "getPaymentStatus Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("getPaymentStatus >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getPaymentStatus UnHandledError >> $e");
    }
  }

  @override
  Future refundPayment(RefundParams params) async {
    try {
      log("refundPayment >> Start request");
      // init request
      final request = RefundRequest();

      // response
      final response = await request(params, params.userToken);
      log("refundPayment >> MissionId: ${params.model.missionId},MissionType: ${params.model.missionType}");
      log("refundPayment >> ResponseCode: ${response.statusCode}");

      switch (response.statusCode) {
        // success
        case 200:
          log("refundPayment >> ResponseBody: ${json.decode(response.body)}");
          return SuccessModel();
        // // notAPaymentProcess
        // case 403:
        //   log("refundPayment >> ResponseBody: ${json.decode(response.body)}");
        //   return AppError(AppErrorType.notAPaymentProcess,
        //       message:
        //           "refundPayment Status Code >> ${response.statusCode}");
        // // payment Failed
        // case 422:
        //   log("refundPayment >> ResponseBody: ${response.body}");
        //   return AppError(AppErrorType.paymentFailed,
        //       message:
        //           "refundPayment Status Code >> ${response.statusCode}");
        // not found
        case 404:
          log("refundPayment >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.notFound,
              message: "refundPayment Status Code >> ${response.statusCode}");
        // unAuthorized
        case 401:
          log("refundPayment >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.unauthorizedUser,
              message: "refundPayment Status Code >> ${response.statusCode}");

        // default
        default:
          log("refundPayment >> ResponseBody: ${response.body}");
          return AppError(AppErrorType.api,
              message: "refundPayment Status Code >> ${response.statusCode}"
                  " \n Body: ${response.body}");
      }
    } catch (e) {
      log("refundPayment >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "refundPayment UnHandledError >> $e");
    }
  }
}
