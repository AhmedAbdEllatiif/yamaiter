import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/params/all_articles_params.dart';
import 'package:yamaiter/data/params/apply_for_task.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';
import 'package:yamaiter/data/params/chat/fetch_chats_lists_params.dart';
import 'package:yamaiter/data/params/client/create_consultation_params.dart';
import 'package:yamaiter/data/params/client/get_consultation_details.dart';
import 'package:yamaiter/data/params/client/get_my_consultations_params.dart';
import 'package:yamaiter/data/params/create_ad_params.dart';

import 'package:yamaiter/data/params/create_sos_params.dart';
import 'package:yamaiter/data/params/create_task_params.dart';
import 'package:yamaiter/data/params/create_tax_params.dart';
import 'package:yamaiter/data/params/decline_task_params.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';
import 'package:yamaiter/data/params/delete_sos_params.dart';
import 'package:yamaiter/data/params/delete_task_params.dart';
import 'package:yamaiter/data/params/end_task_params.dart';
import 'package:yamaiter/data/params/filter_task_params.dart';
import 'package:yamaiter/data/params/get_all_task_params.dart';
import 'package:yamaiter/data/params/get_applied_tasks_params.dart';
import 'package:yamaiter/data/params/get_my_tasks_params.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';
import 'package:yamaiter/data/params/invite_to_task_params.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/data/params/my_single_task_params.dart';
import 'package:yamaiter/data/params/payment/charge_balance_params.dart';
import 'package:yamaiter/data/params/payment/check_payment_status_params.dart';
import 'package:yamaiter/data/params/payment/get_balance_params.dart';
import 'package:yamaiter/data/params/payment/pay_out_params.dart';
import 'package:yamaiter/data/params/payment/refund_params.dart';
import 'package:yamaiter/data/params/search_for_lawyer_params.dart';
import 'package:yamaiter/data/params/store_fb_token.dart';
import 'package:yamaiter/data/params/update_profile/update_client_params.dart';
import 'package:yamaiter/data/params/update_profile/update_lawyer_profile.dart';
import 'package:yamaiter/domain/entities/chat/received_chat_list_entity.dart';
import 'package:yamaiter/domain/entities/data/accept_terms/accept_terms_entity.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/domain/entities/data/balance_entity.dart';
import 'package:yamaiter/domain/entities/data/charge_balance_entity.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';

import '../../data/models/success_model.dart';
import '../../data/models/tasks/upload_task_params.dart';
import '../../data/params/accept_terms_params.dart';
import '../../data/params/all_sos_params.dart';
import '../../data/params/change_password_params.dart';
import '../../data/params/chat_room_by_id_params.dart';
import '../../data/params/client/get_lawyers_params.dart';
import '../../data/params/create_article_params.dart';
import '../../data/params/forget_password_params.dart';
import '../../data/params/get_app_announcements.dart';
import '../../data/params/get_invited_task_params.dart';
import '../../data/params/get_taxes_params.dart';
import '../../data/params/register_client_params.dart';
import '../../data/params/register_lawyer_request_params.dart';
import '../../data/params/chat/send_chat_message.dart';
import '../../data/params/update_sos_params.dart';
import '../../data/params/update_task_params.dart';
import '../entities/app_error.dart';
import '../entities/data/app_announcements_entity.dart';
import '../entities/data/article_entity.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class RemoteRepository {
  ///=============================>  Fb_Token <=========+===============\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  Future<Either<AppError, SuccessModel>> storeFirebaseToken(
      StoreFirebaseTokenParams params);

  ///============================>  chat <==============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  Future<Either<AppError, List<types.Message>>> getChatRoomById(
      ChatRoomByIdParams chatRoomByIdParams);

  /// sendChatMessage
  Future<Either<AppError, SuccessModel>> sendChatMessage(
      SendChatMessageParams sendChatMessageParams);

  /// fetchChatList
  Future<Either<AppError, List<ReceivedChatListEntity>>> fetchChatList(
      FetchChatsListParams fetchChatsListParams);

  ///========================>  Update profile <========================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  Future<Either<AppError, AuthorizedUserEntity>> updateClientProfile(
      UpdateClientParams updateClientParams);

  /// updateLawyerProfile
  Future<Either<AppError, AuthorizedUserEntity>> updateLawyerProfile(
      UpdateLawyerParams updateLawyerParams);

  /// changePassword
  Future<Either<AppError, SuccessModel>> changePassword(
      ChangePasswordParams params);

  /// forgetPassword
  Future<Either<AppError, SuccessModel>> forgetPassword(
      ForgetPasswordParams params);

  ///============================>  Client <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  /// registerClient
  Future<Either<AppError, RegisterResponseEntity>> registerClient(
      RegisterClientParams params);

  /// getMyConsultations
  Future<Either<AppError, List<ConsultationEntity>>> getMyConsultations(
      GetMyConsultationParams params);

  /// create consultation
  Future<Either<AppError, PayEntity>> createConsultation(
      PayForConsultationParams params);

  /// getConsultationDetails
  Future<Either<AppError, ConsultationEntity>> getConsultationDetails(
      GetConsultationDetailsParams params);

  /// fetch lawyers
  Future<Either<AppError, List<LawyerEntity>>> fetchLawyers(
      GetLawyersParams params);

  ///============================>  Lawyer <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  /// login
  Future<Either<AppError, LoginResponseEntity>> login(
      LoginRequestParams loginRequestParams);

  /// registerLawyer
  Future<Either<AppError, RegisterResponseEntity>> registerLawyer(
      RegisterLawyerRequestParams registerLawyerRequestParams);

  /// about
  Future<Either<AppError, SideMenuPageResponseModel>> getAboutApp(
      String userToken);

  /// terms and conditions
  Future<Either<AppError, SideMenuPageResponseModel>> getTermsAndConditions(
      String userToken);

  /// privacy
  Future<Either<AppError, SideMenuPageResponseModel>> getPrivacy(
      String userToken);

  /// ContactUs
  Future<Either<AppError, SideMenuPageResponseModel>> getContactUs(
      String userToken);

  /// help
  Future<Either<AppError, List<HelpResponseModel>>> getHelp(String userToken);

  /// create sos
  Future<Either<AppError, SuccessModel>> createSos(
      CreateSosParams createSosParams);

  /// update sos
  Future<Either<AppError, SuccessModel>> updateSos(
      UpdateSosParams updateSosParams);

  /// return a list of current user sos
  Future<Either<AppError, List<SosEntity>>> getMySosList(GetSosParams params);

  /// delete sos
  Future<Either<AppError, SuccessModel>> deleteSos(
      DeleteSosParams deleteSosParams);

  /// return a list of all  sos
  Future<Either<AppError, List<SosEntity>>> getAllSosList(GetSosParams params);

  /// return a list of current user sos
  Future<Either<AppError, List<ArticleEntity>>> getAllArticlesList(
      GetArticlesParams params);

  /// create article
  Future<Either<AppError, SuccessModel>> createArticle(
      CreateOrUpdateArticleParams params);

  /// update article
  Future<Either<AppError, SuccessModel>> updateArticle(
      CreateOrUpdateArticleParams params);

  /// get single article
  Future<Either<AppError, ArticleEntity>> getSingleArticle(
      GetSingleArticleParams params);

  /// get my articles
  Future<Either<AppError, List<ArticleEntity>>> getMyArticles(String params);

  /// delete article
  Future<Either<AppError, SuccessModel>> deleteArticle(
      DeleteArticleParams deleteArticleParams);

  /// create sos
  Future<Either<AppError, SuccessModel>> createAd(
      CreateAdParams createAdParams);

  /// create tax
  Future<Either<AppError, PayEntity>> payForTax(CreateTaxParams params);

  /// get my in progress taxes
  Future<Either<AppError, List<TaxEntity>>> getInProgressTaxes(
      GetTaxesParams params);

  /// get my completed taxes
  Future<Either<AppError, List<TaxEntity>>> getCompletedTaxes(
      GetTaxesParams params);

  /// return a list my  ads
  Future<Either<AppError, List<AdEntity>>> getMyAdsList(String userToken);

  /// return [AppAnnouncementsEntity]
  Future<Either<AppError, AppAnnouncementsEntity>> getAppAnnouncements(
      GetAnnouncementsParams params);

  /// create task
  Future<Either<AppError, SuccessModel>> createTask(CreateTaskParams params);

  /// getSingleTaskDetails
  Future<Either<AppError, TaskEntity>> getSingleTaskDetails(
      GetSingleTaskParams params);

  /// assign task
  Future<Either<AppError, PayEntity>> assignTask(PayForTaskParams params);

  /// get my posted_tasks
  Future<Either<AppError, List<TaskEntity>>> getMyTasks(
      GetMyTasksParams params);

  /// get single task
  Future<Either<AppError, TaskEntity>> getMySingleTask(
      GetSingleTaskParams params);

  /// update task
  Future<Either<AppError, SuccessModel>> updateTask(UpdateTaskParams params);

  /// delete task
  Future<Either<AppError, SuccessModel>> deleteTask(DeleteTaskParams params);

  /// end task
  Future<Either<AppError, SuccessModel>> endTask(EndTaskParams params);

  /// get AppliedTasks
  Future<Either<AppError, List<TaskEntity>>> getAppliedTasks(
      GetAppliedTasksParams params);

  /// apply for task
  Future<Either<AppError, SuccessModel>> applyForTask(
      ApplyForTaskParams params);

  /// upload task file
  Future<Either<AppError, SuccessModel>> uploadTaskFile(
      UploadTaskFileParams params);

  /// get accept terms
  Future<Either<AppError, AcceptTermsEntity>> getAcceptTerms(String userToken);

  /// accept terms
  Future<Either<AppError, SuccessModel>> acceptTerms(AcceptTermsParams params);

  /// get my posted_tasks
  Future<Either<AppError, List<TaskEntity>>> getAllTasks(
      GetAllTasksParams params);

  /// get InvitedTasks
  Future<Either<AppError, List<TaskEntity>>> getInvitedTasks(
      GetInvitedTasksParams params);

  /// decline tax
  Future<Either<AppError, SuccessModel>> declineTask(DeclineTaskParams params);

  /// search for lawyers
  Future<Either<AppError, List<LawyerEntity>>> searchForLawyers(
      SearchForLawyerParams params);

  /// invite to task
  Future<Either<AppError, SuccessModel>> inviteToTask(
      InviteToTaskParams params);

  /// filter tasks
  Future<Either<AppError, List<TaskEntity>>> filterTasks(
      FilterTasksParams params);

  ///============================>  Common <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  /// check payment status
  Future<Either<AppError, SuccessModel>> checkForPaymentStatus(
      CheckPaymentStatusParams params);

  /// check payment status
  Future<Either<AppError, SuccessModel>> refundPayment(RefundParams params);

  /// to send payout request
  Future<Either<AppError, SuccessModel>> payout(PayoutParams params);

  /// to get user balance
  Future<Either<AppError, BalanceEntity>> getBalance(GetBalanceParams params);

  /// to charge user balance
  Future<Either<AppError, ChargeBalanceEntity>> chargeBalance(
      ChargeBalanceParams params);
}
