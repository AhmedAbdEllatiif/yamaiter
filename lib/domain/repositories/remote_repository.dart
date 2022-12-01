import 'package:dartz/dartz.dart';
import 'package:yamaiter/data/models/app_settings_models/help_response_model.dart';
import 'package:yamaiter/data/models/app_settings_models/side_menu_response_model.dart';
import 'package:yamaiter/data/models/auth/register_client/register_client_response_model.dart';
import 'package:yamaiter/data/models/auth/register_client/register_client_response_model.dart';
import 'package:yamaiter/data/params/all_articles_params.dart';
import 'package:yamaiter/data/params/apply_for_task.dart';
import 'package:yamaiter/data/params/assign_task_params.dart';
import 'package:yamaiter/data/params/client/create_consultation_params.dart';
import 'package:yamaiter/data/params/client/create_task_params.dart';
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
import 'package:yamaiter/data/params/search_for_lawyer_params.dart';
import 'package:yamaiter/domain/entities/data/accept_terms_entity.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/entities/data/login_response_entity.dart';
import 'package:yamaiter/domain/entities/data/register_response_entity.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';

import '../../data/models/success_model.dart';
import '../../data/models/tasks/upload_task_params.dart';
import '../../data/params/accept_terms_params.dart';
import '../../data/params/all_sos_params.dart';
import '../../data/params/create_article_params.dart';
import '../../data/params/get_invited_task_params.dart';
import '../../data/params/get_taxes_params.dart';
import '../../data/params/register_client_params.dart';
import '../../data/params/register_lawyer_request_params.dart';
import '../../data/params/update_sos_params.dart';
import '../../data/params/update_task_params.dart';
import '../entities/app_error.dart';
import '../entities/data/article_entity.dart';

abstract class RemoteRepository {
  ///============================>  Client <============================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  /// registerClient
  Future<Either<AppError, RegisterResponseEntity>> registerClient(
      RegisterClientParams params);

  /// create task client
  Future<Either<AppError, SuccessModel>> createTaskClient(
      CreateTaskParamsClient params);

  /// getMyConsultations
  Future<Either<AppError, List<ConsultationEntity>>> getMyConsultations(
      GetMyConsultationParams params);

  /// create consultation
  Future<Either<AppError, SuccessModel>> createConsultation(
      CreateConsultationParams params);

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
  Future<Either<AppError, List<SideMenuPageResponseModel>>> getAboutApp(
      String userToken);

  /// terms and conditions
  Future<Either<AppError, List<SideMenuPageResponseModel>>>
      getTermsAndConditions(String userToken);

  /// privacy
  Future<Either<AppError, List<SideMenuPageResponseModel>>> getPrivacy(
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
  Future<Either<AppError, SuccessModel>> createTax(CreateTaxParams params);

  /// get my in progress taxes
  Future<Either<AppError, List<TaxEntity>>> getInProgressTaxes(
      GetTaxesParams params);

  /// get my completed taxes
  Future<Either<AppError, List<TaxEntity>>> getCompletedTaxes(
      GetTaxesParams params);

  /// return a list my  ads
  Future<Either<AppError, List<AdEntity>>> getMyAdsList(String userToken);

  /// create task
  Future<Either<AppError, SuccessModel>> createTask(CreateTaskParams params);

  /// assign task
  Future<Either<AppError, SuccessModel>> assignTask(AssignTaskParams params);

  /// get my my_tasks
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

  /// get my my_tasks
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
}
