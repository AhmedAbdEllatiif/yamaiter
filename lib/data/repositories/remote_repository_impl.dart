import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/data/models/accept_terms/accept_terms_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/models/article/article_model.dart';
import 'package:yamaiter/data/models/auth/login/login_response.dart';
import 'package:yamaiter/data/models/auth/register_client/register_client_request_model.dart';
import 'package:yamaiter/data/models/auth/register_client/register_client_response_model.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_request.dart';
import 'package:yamaiter/data/models/auth/register_lawyer/register_lawyer_response.dart';
import 'package:yamaiter/data/models/authorized_user_model.dart';
import 'package:yamaiter/data/models/chats/received_chat_room_response_model.dart';
import 'package:yamaiter/data/models/consultations/consultation_model.dart';
import 'package:yamaiter/data/models/pay_response_model.dart';
import 'package:yamaiter/data/models/payment/balance_model.dart';
import 'package:yamaiter/data/models/sos/sos_model.dart';
import 'package:yamaiter/data/models/tasks/task_model.dart';
import 'package:yamaiter/data/models/tasks/upload_task_params.dart';
import 'package:yamaiter/data/models/tax/tax_model.dart';
import 'package:yamaiter/data/params/accept_terms_params.dart';
import 'package:yamaiter/data/params/all_articles_params.dart';
import 'package:yamaiter/data/params/all_sos_params.dart';
import 'package:yamaiter/data/params/apply_for_task.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';
import 'package:yamaiter/data/params/create_ad_params.dart';
import 'package:yamaiter/data/params/create_article_params.dart';
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
import 'package:yamaiter/data/params/get_invited_task_params.dart';
import 'package:yamaiter/data/params/get_my_tasks_params.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';
import 'package:yamaiter/data/params/invite_to_task_params.dart';
import 'package:yamaiter/data/params/login_request_params.dart';
import 'package:yamaiter/data/params/my_single_task_params.dart';
import 'package:yamaiter/data/params/register_lawyer_request_params.dart';
import 'package:yamaiter/data/params/search_for_lawyer_params.dart';
import 'package:yamaiter/data/params/update_sos_params.dart';
import 'package:yamaiter/domain/entities/app_error.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';
import 'package:yamaiter/domain/repositories/remote_repository.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../domain/entities/chat/received_chat_list_entity.dart';
import '../../domain/entities/data/accept_terms/accept_terms_entity.dart';
import '../../domain/entities/data/app_announcements_entity.dart';
import '../../domain/entities/data/authorized_user_entity.dart';
import '../../domain/entities/data/balance_entity.dart';
import '../../domain/entities/data/client/consultation_entity.dart';
import '../data_source/remote_data_source.dart';
import '../models/announcements/ad_model.dart';
import '../models/announcements/announcemnets_response_model.dart';
import '../models/auth/login/login_request.dart';
import '../models/success_model.dart';
import '../params/change_password_params.dart';
import '../params/chat/fetch_chats_lists_params.dart';
import '../params/chat_room_by_id_params.dart';
import '../params/client/assign_task_params_client.dart';
import '../params/client/create_consultation_params.dart';
import '../params/client/create_task_params.dart';
import '../params/client/delete_task_params.dart';
import '../params/client/end_task_params_client.dart';
import '../params/client/get_consultation_details.dart';
import '../params/client/get_lawyers_params.dart';
import '../params/client/get_my_consultations_params.dart';
import '../params/client/get_my_task_params_client.dart';
import '../params/client/get_single_task_params_client.dart';
import '../params/client/update_task_params.dart';
import '../params/forget_password_params.dart';
import '../params/get_app_announcements.dart';
import '../params/get_taxes_params.dart';
import '../params/payment/check_payment_status_params.dart';
import '../params/payment/get_balance_params.dart';
import '../params/payment/pay_out_params.dart';
import '../params/payment/refund_params.dart';
import '../params/register_client_params.dart';
import '../params/chat/send_chat_message.dart';
import '../params/update_profile/update_client_params.dart';
import '../params/update_task_params.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RemoteDataSource remoteDataSource;

  RemoteRepositoryImpl({
    required this.remoteDataSource,
  });

  ///=============================>  chat_room <=============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  @override
  Future<Either<AppError, List<types.Message>>> getChatRoomById(
      ChatRoomByIdParams chatRoomByIdParams) async {
    try {
      // send request
      final result = await remoteDataSource.getChatRoomById(chatRoomByIdParams);

      // success
      if (result is ReceivedChatRoomResponseModel) {
        final List<types.Message> convertedMessages = result.content
            .map((e) => types.Message.fromJson(e.toChatMessageJson()))
            .toList();

        return Right(convertedMessages);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// sendChatMessage
  @override
  Future<Either<AppError, SuccessModel>> sendChatMessage(
      SendChatMessageParams sendChatMessageParams) async {
    try {
      // send request
      final result =
          await remoteDataSource.sendChatMessage(sendChatMessageParams);

      // success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// fetchChatList
  @override
  Future<Either<AppError, List<ReceivedChatListEntity>>> fetchChatList(
      FetchChatsListParams fetchChatsListParams) async {
    try {
      // send request
      final result = await remoteDataSource.fetchChatList(fetchChatsListParams);

      // success
      if (result is List<ReceivedChatListEntity>) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  ///========================>  Update profile <========================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  @override
  Future<Either<AppError, AuthorizedUserEntity>> updateClientProfile(
      UpdateClientParams updateClientParams) async {
    try {
      // send request
      final result =
          await remoteDataSource.updateClientProfile(updateClientParams);

      // success
      if (result is AuthorizedUserModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// changePassword
  @override
  Future<Either<AppError, SuccessModel>> changePassword(
      ChangePasswordParams params) async {
    try {
      // send request
      final result = await remoteDataSource.changePassword(params);

      // success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      log("RepoImpl >> changePassword >> error: $e");
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }


  /// forgetPassword
  @override
  Future<Either<AppError, SuccessModel>> forgetPassword(
      ForgetPasswordParams params) async {
    try {
      // send request
      final result = await remoteDataSource.forgetPassword(params);

      // success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      log("RepoImpl >> forgetPassword >> error: $e");
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  ///============================>  Client <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  @override
  Future<Either<AppError, RegisterResponseEntity>> registerClient(
      RegisterClientParams params) async {
    try {
      // build a model
      final registerRequestModel = RegisterClientRequestModel(
        firstName: params.firstName,
        lastName: params.lastName,
        phone: params.phone,
        email: params.email,
        governorates: params.governorates,
        password: params.password,
        acceptTerms: params.isTermsAccepted,
      );

      // send request
      final result =
          await remoteDataSource.registerClient(registerRequestModel);

      // success
      if (result is RegisterClientResponseModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createTaskClient
  @override
  Future<Either<AppError, SuccessModel>> createTaskClient(
      CreateTaskParamsClient params) async {
    try {
      // send request
      final result = await remoteDataSource.createTaskClient(params);

      // success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, List<ConsultationEntity>>> getMyConsultations(
      GetMyConsultationParams params) async {
    try {
      // send request
      final result = await remoteDataSource.getMyConsultations(params);

      // success
      if (result is List<ConsultationEntity>) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createConsultation
  @override
  Future<Either<AppError, PayEntity>> createConsultation(
      PayForConsultationParams params) async {
    try {
      // send request
      final result = await remoteDataSource.createConsultation(params);

      // success
      if (result is PayResponseModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// get consultation details
  @override
  Future<Either<AppError, ConsultationEntity>> getConsultationDetails(
      GetConsultationDetailsParams params) async {
    try {
      // send request
      final result = await remoteDataSource.getConsultationDetails(params);

      // success
      if (result is ConsultationModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// get my tasks client
  @override
  Future<Either<AppError, List<TaskEntity>>> getMyTasksClient(
      GetMyTasksClientParams params) async {
    try {
      // send request
      final result = await remoteDataSource.getMyTaskClient(params);

      // success
      if (result is List<TaskModel>) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// get single task client
  @override
  Future<Either<AppError, TaskEntity>> getSingleTaskClient(
      GetSingleTaskParamsClient params) async {
    try {
      // send request
      final result = await remoteDataSource.getSingleTaskClient(params);

      // success
      if (result is TaskModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// endTaskClient
  @override
  Future<Either<AppError, SuccessModel>> endTaskClient(
      EndTaskParamsClient params) async {
    try {
      // send request
      final result = await remoteDataSource.endTaskClient(params);

      // success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// assignTaskClient
  @override
  Future<Either<AppError, SuccessModel>> assignTaskClient(
      AssignTaskParamsClient params) async {
    try {
      // send request
      final result = await remoteDataSource.assignTaskClient(params);

      // success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// deleteTaskClient
  @override
  Future<Either<AppError, SuccessModel>> deleteTaskClient(
      DeleteTaskClientParams params) async {
    try {
      // send request
      final result = await remoteDataSource.deleteTaskClient(params);

      // success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// updateTaskClient
  @override
  Future<Either<AppError, SuccessModel>> updateTaskClient(
      UpdateTaskClientParams params) async {
    try {
      // send request
      final result = await remoteDataSource.updateTaskClient(params);

      // success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// fetchLawyers
  @override
  Future<Either<AppError, List<LawyerEntity>>> fetchLawyers(
      GetLawyersParams params) async {
    try {
      // send request
      final result = await remoteDataSource.fetchLawyers(params);

      // success
      if (result is List<LawyerEntity>) {
        return Right(result);
      }

      // failed
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  ///============================>  Lawyer <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  /// Login
  @override
  Future<Either<AppError, LoginResponseEntity>> login(
      LoginRequestParams loginRequestParams) async {
    try {
      // build a LoginRequestModel
      final loginRequestModel = LoginRequestModel(
          email: loginRequestParams.email,
          password: loginRequestParams.password,
          rememberMe: "true");

      // send login request
      final result = await remoteDataSource.login(loginRequestModel);

      // success to login
      if (result is LoginResponseModel) {
        return Right(result);
      }

      // failed to login
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// register lawyer
  @override
  Future<Either<AppError, RegisterResponseEntity>> registerLawyer(
      RegisterLawyerRequestParams registerLawyerRequestParams) async {
    try {
      // build a RegisterRequestModel
      final registerRequestModel = RegisterRequestModel(
        firstName: registerLawyerRequestParams.firstName,
        lastName: registerLawyerRequestParams.lastName,
        phone: registerLawyerRequestParams.phone,
        email: registerLawyerRequestParams.email,
        governorates: registerLawyerRequestParams.governorates,
        courtName: registerLawyerRequestParams.courtName,
        password: registerLawyerRequestParams.password,
        acceptTerms: "yes",
        idPhoto: File(registerLawyerRequestParams.idPhotoPath),
      );

      // send login request
      final result =
          await remoteDataSource.registerLawyer(registerRequestModel);

      // success to register
      if (result is RegisterResponseModel) {
        return Right(result);
      }

      // failed to register
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, SideMenuPageResponseModel>> getAboutApp(
      String userToken) async {
    try {
      // send get about request
      final result = await remoteDataSource.getAbout(userToken);

      // received about
      if (result is SideMenuPageResponseModel) {
        return Right(result);
      }

      // failed to get about
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// TermsAndConditionResponseModel
  @override
  Future<Either<AppError, SideMenuPageResponseModel>> getTermsAndConditions(
      String userToken) async {
    try {
      // send get about request
      final result = await remoteDataSource.getTermsAndConditions(userToken);

      // received about
      if (result is SideMenuPageResponseModel) {
        return Right(result);
      }

      // failed to get about
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// privacy
  @override
  Future<Either<AppError, SideMenuPageResponseModel>> getPrivacy(
      String userToken) async {
    try {
      // send get privacy request
      final result = await remoteDataSource.getPrivacyAndPolicy(userToken);

      // received privacy
      if (result is SideMenuPageResponseModel) {
        return Right(result);
      }

      // failed to get about
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// Help
  @override
  Future<Either<AppError, List<HelpResponseModel>>> getHelp(
      String userToken) async {
    try {
      // send get help request
      final result = await remoteDataSource.getHelp(userToken);

      // received help
      if (result is List<HelpResponseModel>) {
        return Right(result);
      }

      // failed to get help
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// ContactUs
  @override
  Future<Either<AppError, SideMenuPageResponseModel>> getContactUs(
      String userToken) async {
    try {
      // send get privacy request
      final result = await remoteDataSource.getContactUs(userToken);

      // received privacy
      if (result is SideMenuPageResponseModel) {
        return Right(result);
      }

      // failed to get about
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createSos
  @override
  Future<Either<AppError, SuccessModel>> createSos(
      CreateSosParams createSosParams) async {
    try {
      // send create sos request
      final result = await remoteDataSource.createSos(createSosParams);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to create sos
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// updateSos
  @override
  Future<Either<AppError, SuccessModel>> updateSos(
      UpdateSosParams updateSosParams) async {
    try {
      // send update sos request
      final result = await remoteDataSource.updateSos(updateSosParams);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to update sos
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getMySosList
  @override
  Future<Either<AppError, List<SosEntity>>> getMySosList(
      GetSosParams params) async {
    try {
      // send get my sos list request
      final result = await remoteDataSource.getMySos(params);

      // received my sos list
      if (result is SosResponseModel) {
        return Right(result.mySosList);
      }

      // failed to get my sos
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// deleteSos
  @override
  Future<Either<AppError, SuccessModel>> deleteSos(
      DeleteSosParams deleteSosParams) async {
    try {
      // send delete sos request
      final result = await remoteDataSource.deleteSos(deleteSosParams);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to delete sos
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getAllSosList
  @override
  Future<Either<AppError, List<SosEntity>>> getAllSosList(
      GetSosParams params) async {
    try {
      // send get all sos list request
      final result = await remoteDataSource.getAllSos(params);

      // received all sos list
      if (result is SosResponseModel) {
        return Right(result.mySosList);
      }

      // failed to get all sos
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      log("Error: $e");
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createArticle
  @override
  Future<Either<AppError, SuccessModel>> createArticle(
      CreateOrUpdateArticleParams params) async {
    try {
      // send create article request
      final result = await remoteDataSource.createArticle(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to create article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, ArticleEntity>> getSingleArticle(
      GetSingleArticleParams params) async {
    try {
      // send create article request
      final result = await remoteDataSource.fetchSingleArticleArticle(params);

      // received success
      if (result is ArticleModel) {
        return Right(result);
      }

      // failed to create article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getAllArticlesList
  @override
  Future<Either<AppError, List<ArticleEntity>>> getAllArticlesList(
      GetArticlesParams params) async {
    try {
      // send fetch my articles request
      final result = await remoteDataSource.getAllArticles(params);

      // received success
      if (result is List<ArticleModel>) {
        return Right(result);
      }

      // failed to fetch my  articles
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getMyArticles
  @override
  Future<Either<AppError, List<ArticleEntity>>> getMyArticles(
      String params) async {
    try {
      // send fetch my articles request
      final result = await remoteDataSource.fetchMyArticles(params);

      // received success
      if (result is List<ArticleModel>) {
        return Right(result);
      }

      // failed to fetch my  articles
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// deleteArticle
  @override
  Future<Either<AppError, SuccessModel>> deleteArticle(
      DeleteArticleParams deleteArticleParams) async {
    try {
      // send delete article request
      final result = await remoteDataSource.deleteArticle(deleteArticleParams);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to delete article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// updateArticle
  @override
  Future<Either<AppError, SuccessModel>> updateArticle(
      CreateOrUpdateArticleParams params) async {
    try {
      // send update article request
      final result = await remoteDataSource.updateArticle(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to update article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// createAd
  @override
  Future<Either<AppError, SuccessModel>> createAd(
      CreateAdParams createAdParams) async {
    try {
      // send update article request
      final result = await remoteDataSource.createAd(createAdParams);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to update article
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// payForTax
  @override
  Future<Either<AppError, PayEntity>> payForTax(CreateTaxParams params) async {
    try {
      // send create tax request
      final result = await remoteDataSource.payForTax(params);

      // received success
      if (result is PayResponseModel) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getInProgressTaxes
  @override
  Future<Either<AppError, List<TaxEntity>>> getInProgressTaxes(
      GetTaxesParams params) async {
    try {
      // send create tax request
      final result = await remoteDataSource.fetchInProgressTaxes(params);

      // received success
      if (result is List<TaxModel>) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getCompletedTaxes
  @override
  Future<Either<AppError, List<TaxEntity>>> getCompletedTaxes(
      GetTaxesParams params) async {
    try {
      // send create tax request
      final result = await remoteDataSource.fetchCompletedTaxes(params);

      // received success
      if (result is List<TaxModel>) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, List<AdEntity>>> getMyAdsList(
      String userToken) async {
    try {
      // send create tax request
      final result = await remoteDataSource.getMyAds(userToken);

      // received success
      if (result is List<AdModel>) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// GetAcceptTerms
  @override
  Future<Either<AppError, AcceptTermsEntity>> getAcceptTerms(
      String userToken) async {
    try {
      // send get accept request
      final result = await remoteDataSource.getAcceptTerms(userToken);

      // received success
      if (result is AcceptTermsResponseModel) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// acceptTerms
  @override
  Future<Either<AppError, SuccessModel>> acceptTerms(
      AcceptTermsParams params) async {
    try {
      // send create tax request
      final result = await remoteDataSource.acceptTerms(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to create tax
      else {
        return Left(result);
      }
    } catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// createTask
  @override
  Future<Either<AppError, SuccessModel>> createTask(
      CreateTaskParams params) async {
    try {
      // send create task request
      final result = await remoteDataSource.createTask(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to create task
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getMyTasks
  @override
  Future<Either<AppError, List<TaskEntity>>> getMyTasks(
      GetMyTasksParams params) async {
    try {
      // send get my_tasks request
      final result = await remoteDataSource.getMyTasks(params);

      // received success
      if (result is List<TaskEntity>) {
        return Right(result);
      }

      // failed to get my my_tasks
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, SuccessModel>> updateTask(
      UpdateTaskParams params) async {
    try {
      // send update task request
      final result = await remoteDataSource.updateTask(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to update task
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  @override
  Future<Either<AppError, SuccessModel>> deleteTask(
      DeleteTaskParams params) async {
    try {
      // send delete task request
      final result = await remoteDataSource.deleteTask(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to delete task
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: "Message: $e"));
    }
  }

  /// getAllTasks
  @override
  Future<Either<AppError, List<TaskEntity>>> getAllTasks(
      GetAllTasksParams params) async {
    try {
      // send get my_tasks request
      final result = await remoteDataSource.getAllTasks(params);

      // received success
      if (result is List<TaskEntity>) {
        return Right(result);
      }

      // failed to get all my_tasks
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// getMySingleTask
  @override
  Future<Either<AppError, TaskEntity>> getMySingleTask(
      GetSingleTaskParams params) async {
    try {
      // send get my_tasks request
      final result = await remoteDataSource.getMySingleTasks(params);

      // received success
      if (result is TaskEntity) {
        return Right(result);
      }

      // failed to get all my_tasks
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// assignTask
  @override
  Future<Either<AppError, PayEntity>> assignTask(
      PayForTaskParams params) async {
    try {
      // send get my_tasks request
      final result = await remoteDataSource.payToAssignTask(params);

      // received success
      if (result is PayResponseModel) {
        return Right(result);
      }

      // failed to get all my_tasks
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// endTask
  @override
  Future<Either<AppError, SuccessModel>> endTask(EndTaskParams params) async {
    try {
      // send endTask
      final result = await remoteDataSource.endTask(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to endTask
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// getAppliedTasks
  @override
  Future<Either<AppError, List<TaskEntity>>> getAppliedTasks(
      GetAppliedTasksParams params) async {
    try {
      // send get applied tasks request
      final result = await remoteDataSource.getAppliedTasks(params);

      // received success
      if (result is List<TaskEntity>) {
        return Right(result);
      }

      // failed to get applied tasks
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// applyForTask
  @override
  Future<Either<AppError, SuccessModel>> applyForTask(
      ApplyForTaskParams params) async {
    try {
      // send get applied tasks request
      final result = await remoteDataSource.applyForTask(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to get applied tasks
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// uploadTaskFile
  @override
  Future<Either<AppError, SuccessModel>> uploadTaskFile(
      UploadTaskFileParams params) async {
    try {
      // send upload task file request
      final result = await remoteDataSource.uploadTaskFile(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to upload task file
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// getInvitedTasks
  @override
  Future<Either<AppError, List<TaskEntity>>> getInvitedTasks(
      GetInvitedTasksParams params) async {
    try {
      // send get invited tasks request
      final result = await remoteDataSource.getInvitedTasks(params);

      // received success
      if (result is List<TaskEntity>) {
        return Right(result);
      }

      // failed to get invited tasks
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// declineTask
  @override
  Future<Either<AppError, SuccessModel>> declineTask(
      DeclineTaskParams params) async {
    try {
      // send request
      final result = await remoteDataSource.declineInvitedTasks(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// searchForLawyers
  @override
  Future<Either<AppError, List<LawyerEntity>>> searchForLawyers(
      SearchForLawyerParams params) async {
    try {
      // send request
      final result = await remoteDataSource.searchForLawyer(params);

      // received success
      if (result is List<LawyerEntity>) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// inviteToTask
  @override
  Future<Either<AppError, SuccessModel>> inviteToTask(
      InviteToTaskParams params) async {
    try {
      // send request
      final result = await remoteDataSource.inviteToTask(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// filterTasks
  @override
  Future<Either<AppError, List<TaskEntity>>> filterTasks(
      FilterTasksParams params) async {
    try {
      // send request
      final result = await remoteDataSource.filterTasks(params);

      // received success
      if (result is List<TaskEntity>) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  ///===========================>  Payment <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\

  /// checkForPaymentStatus
  @override
  Future<Either<AppError, SuccessModel>> checkForPaymentStatus(
      CheckPaymentStatusParams params) async {
    try {
      // send request
      final result = await remoteDataSource.getPaymentStatus(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// refundPayment
  @override
  Future<Either<AppError, SuccessModel>> refundPayment(
      RefundParams params) async {
    try {
      // send request
      final result = await remoteDataSource.refundPayment(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// to send payout request
  @override
  Future<Either<AppError, SuccessModel>> payout(PayoutParams params) async {
    try {
      // send request
      final result = await remoteDataSource.payout(params);

      // received success
      if (result is SuccessModel) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      log("RepoImpl >> payout >> error: $e");
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// to get user balance
  @override
  Future<Either<AppError, BalanceEntity>> getBalance(
      GetBalanceParams params) async {
    try {
      // send request
      final result = await remoteDataSource.getBalance(params);

      // received success
      if (result is BalanceModel) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      log("RepoImpl >> getBalance >> error: $e");
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }

  /// return [AppAnnouncementsEntity]
  @override
  Future<Either<AppError, AppAnnouncementsEntity>> getAppAnnouncements(
      GetAnnouncementsParams params) async {
    try {
      // send request
      final result = await remoteDataSource.getAppAnnouncements(params);

      // received success
      if (result is AnnouncementsResponseModel) {
        return Right(result);
      }

      // failed to send request
      else {
        return Left(result);
      }
    } on Exception catch (e) {
      log("RepoImpl >> getAppAnnouncements >> error: $e");
      return Left(
          AppError(AppErrorType.unHandledError, message: "Message: $e"));
    }
  }
}
