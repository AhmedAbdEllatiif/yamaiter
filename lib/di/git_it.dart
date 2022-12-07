import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:yamaiter/domain/repositories/app_settings_repository.dart';
import 'package:yamaiter/domain/use_cases/applied_tasks/apply_for_task.dart';
import 'package:yamaiter/domain/use_cases/applied_tasks/apply_for_task.dart';
import 'package:yamaiter/domain/use_cases/article/get_all_articles.dart';
import 'package:yamaiter/domain/use_cases/article/get_all_articles.dart';
import 'package:yamaiter/domain/use_cases/authorized_user/authorized_user_data/delete_user_data.dart';
import 'package:yamaiter/domain/use_cases/authorized_user/authorized_user_data/get_user_data.dart';
import 'package:yamaiter/domain/use_cases/authorized_user/authorized_user_data/save_user_data.dart';
import 'package:yamaiter/domain/use_cases/client/tasks/get_my_tasks_client.dart';
import 'package:yamaiter/domain/use_cases/client/tasks/get_my_tasks_client.dart';
import 'package:yamaiter/domain/use_cases/my_tasks/assign_task.dart';
import 'package:yamaiter/domain/use_cases/sos/get_all_sos.dart';
import 'package:yamaiter/domain/use_cases/sos/get_my_sos_list.dart';
import 'package:yamaiter/domain/use_cases/sos/get_my_sos_list.dart';
import 'package:yamaiter/domain/use_cases/help.dart';
import 'package:yamaiter/domain/use_cases/help.dart';
import 'package:yamaiter/domain/use_cases/login.dart';
import 'package:yamaiter/domain/use_cases/privacy.dart';
import 'package:yamaiter/domain/use_cases/register_lawyer.dart';
import 'package:yamaiter/domain/use_cases/taxes/get_in_progress_taxes.dart';
import 'package:yamaiter/domain/use_cases/terms_and_conditions.dart';
import 'package:yamaiter/domain/use_cases/top_rated_lawyers.dart';
import 'package:yamaiter/presentation/logic/client_cubit/assign_task/assign_task_client_cubit.dart';
import 'package:yamaiter/presentation/logic/client_cubit/assign_task/assign_task_client_cubit.dart';
import 'package:yamaiter/presentation/logic/client_cubit/create_consultation/create_consultation_cubit.dart';
import 'package:yamaiter/presentation/logic/client_cubit/end_task_client/end_task_client_cubit.dart';
import 'package:yamaiter/presentation/logic/client_cubit/get_my_tasks_client/get_my_tasks_client_cubit.dart';
import 'package:yamaiter/presentation/logic/client_cubit/get_my_tasks_client/get_my_tasks_client_cubit.dart';
import 'package:yamaiter/presentation/logic/client_cubit/get_single_task/get_single_task_client_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/apply_for_task/apply_for_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_article/create_article_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_sos/create_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_sos/create_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_task/create_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_sos/delete_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_task/delete_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/end_task/end_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/end_task/end_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/filter_tasks/filter_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/filter_tasks/filter_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_all_articles/get_all_articles_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_all_sos/get_all_soso_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_completed_taxes/get_completed_taxes_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_invited_tasks/get_invited_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_ads/get_my_ads_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_ads/get_my_ads_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_sos/get_my_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/invite_lawyer/invite_lawyer_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/my_articles/my_articles_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/my_articles/my_articles_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/side_menu_page/side_menu_page_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/update_article/update_article_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/update_sos_cubit/update_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/upload_task_file/upload_task_file_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/user_token/user_token_cubit.dart';

import '../data/api/init_rest_api_client.dart';
import '../data/data_source/app_settings_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/repositories/app_settings_repository_impl.dart';
import '../domain/repositories/remote_repository.dart';
import '../data/repositories/remote_repository_impl.dart';
import '../domain/use_cases/about.dart';
import '../domain/use_cases/accept_terms/accept_terms.dart';
import '../domain/use_cases/accept_terms/get_accept_terms.dart';
import '../domain/use_cases/ads/get_my_ads.dart';
import '../domain/use_cases/authorized_user/user_token/get_user_token.dart';
import '../domain/use_cases/authorized_user/user_token/delete_user_token.dart';
import '../domain/use_cases/authorized_user/user_token/save_user_token.dart';
import '../domain/use_cases/applied_tasks/decline_invited_task.dart';
import '../domain/use_cases/applied_tasks/get_applied_tasks.dart';
import '../domain/use_cases/applied_tasks/upload_task_file.dart';
import '../domain/use_cases/article/create_article.dart';
import '../domain/use_cases/article/my_articles.dart';
import '../domain/use_cases/article/update_article.dart';
import '../domain/use_cases/ads/create_ad.dart';
import '../domain/use_cases/client/consultations/create_consultaion.dart';
import '../domain/use_cases/client/consultations/get_my_consultations.dart';
import '../domain/use_cases/client/tasks/assign_task_client_case.dart';
import '../domain/use_cases/client/tasks/create_task_client_case.dart';
import '../domain/use_cases/client/tasks/end_task_client_case.dart';
import '../domain/use_cases/client/tasks/single_task_case.dart';
import '../domain/use_cases/client_auth/register_client.dart';
import '../domain/use_cases/filter_tasks.dart';
import '../domain/use_cases/invited_tasks.dart';
import '../domain/use_cases/my_tasks/end_task.dart';
import '../domain/use_cases/my_tasks/get_my_single_task.dart';
import '../domain/use_cases/my_tasks/invite_to_task.dart';
import '../domain/use_cases/search_for_lawyers.dart';
import '../domain/use_cases/sos/create_sos.dart';
import '../domain/use_cases/article/delete_article.dart';
import '../domain/use_cases/sos/delete_sos.dart';
import '../domain/use_cases/sos/update_sos.dart';
import '../domain/use_cases/my_tasks/create_task.dart';
import '../domain/use_cases/my_tasks/delete_task.dart';
import '../domain/use_cases/my_tasks/get_all_tasks.dart';
import '../domain/use_cases/my_tasks/get_my_tasks.dart';
import '../domain/use_cases/my_tasks/update_task.dart';
import '../domain/use_cases/taxes/create_tax.dart';
import '../domain/use_cases/get_single_article.dart';
import '../domain/use_cases/taxes/get_completed_taxes.dart';
import '../presentation/logic/client_cubit/create_task/create_task_client_cubit.dart';
import '../presentation/logic/client_cubit/get_my_consultations/get_my_consultations_cubit.dart';
import '../presentation/logic/cubit/accept_terms/accept_terms_cubit.dart';
import '../presentation/logic/cubit/create_ad/create_ad_cubit.dart';
import '../presentation/logic/cubit/create_tax/create_tax_cubit.dart';
import '../presentation/logic/cubit/decline_invited_task/decline_task_cubit.dart';
import '../presentation/logic/cubit/delete_article/delete_article_cubit.dart';
import '../presentation/logic/cubit/forget_password/forget_password_cubit.dart';
import '../presentation/logic/cubit/get_accept_terms/get_accept_terms_cubit.dart';
import '../presentation/logic/cubit/get_all_tasks/get_all_task_cubit.dart';
import '../presentation/logic/cubit/get_applied_tasks/get_applied_tasks_cubit.dart';
import '../presentation/logic/cubit/get_in_progress_taxes/get_in_progress_taxes_cubit.dart';
import '../presentation/logic/cubit/get_my_single_task/get_my_single_task_cubit.dart';
import '../presentation/logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';
import '../presentation/logic/cubit/get_single_article/get_single_article_cubit.dart';
import '../presentation/logic/cubit/help/get_help_cubit.dart';
import '../presentation/logic/cubit/login/login_cubit.dart';
import '../presentation/logic/cubit/pick_images/pick_image_cubit.dart';
import '../presentation/logic/cubit/register_client/register_client_cubit.dart';
import '../presentation/logic/cubit/register_lawyer/register_lawyer_cubit.dart';
import '../presentation/logic/cubit/search_for_lawyers/search_for_lawyers_cubit.dart';
import '../presentation/logic/cubit/top_rated_lawyers/top_rated_lawyers_cubit.dart';
import '../presentation/logic/cubit/update_task/update_task_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  ///************************ init ApiClient ********************************\\\

  /// RestApi
  getItInstance.registerFactory<http.Client>(() => initHttpClient());

  ///*************************** init DataSource **********************\\\
  getItInstance.registerFactory<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );

  //==> AppSettingsDataSource
  getItInstance.registerLazySingleton<AppSettingsDataSource>(
    () => AppSettingsDataSourceImpl(),
  );

  ///********************** init Repositories ***************************\\\
  getItInstance.registerFactory<RemoteRepository>(
    () => RemoteRepositoryImpl(
      remoteDataSource: getItInstance(),
    ),
  );

  //==> AppSettingsRepository
  getItInstance.registerFactory<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(
      appSettingsDataSource: getItInstance(),
    ),
  );

  ///************************** init cubit *********************************\\\
  //==> PickImageCubit
  getItInstance.registerFactory<PickImageCubit>(
    () => PickImageCubit(),
  );

  //==> TopRatedLawyersCubit
  getItInstance.registerFactory<TopRatedLawyersCubit>(
    () => TopRatedLawyersCubit(),
  );

  //==> LoginCubit
  getItInstance.registerFactory<LoginCubit>(
    () => LoginCubit(),
  );

  //==> RegisterClientCubit
  getItInstance.registerFactory<RegisterClientCubit>(
    () => RegisterClientCubit(),
  );

  //==> RegisterLawyerCubit
  getItInstance.registerFactory<RegisterLawyerCubit>(
    () => RegisterLawyerCubit(),
  );

  //==> ForgetPasswordCubit
  getItInstance.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(),
  );

  //==> SideMenuPageCubit
  getItInstance.registerFactory<SideMenuPageCubit>(
    () => SideMenuPageCubit(),
  );

  //==> CreateSosCubit
  getItInstance.registerFactory<CreateSosCubit>(
    () => CreateSosCubit(),
  );

  //==> GetMySosCubit
  getItInstance.registerFactory<GetMySosCubit>(
    () => GetMySosCubit(),
  );

  //==> DeleteSosCubit
  getItInstance.registerFactory<DeleteSosCubit>(
    () => DeleteSosCubit(),
  );

  //==> UpdateSosCubit
  getItInstance.registerFactory<UpdateSosCubit>(
    () => UpdateSosCubit(),
  );

  //==> GetAllSosCubit
  getItInstance.registerFactory<GetAllSosCubit>(
    () => GetAllSosCubit(),
  );

  //==> CreateArticleCubit
  getItInstance.registerFactory<CreateArticleCubit>(
    () => CreateArticleCubit(),
  );

  //==> GetAllArticlesCubit
  getItInstance.registerFactory<GetAllArticlesCubit>(
    () => GetAllArticlesCubit(),
  );

  //==> MyArticlesCubit
  getItInstance.registerFactory<MyArticlesCubit>(
    () => MyArticlesCubit(),
  );

  //==> GetSingleArticleCubit
  getItInstance.registerFactory<GetSingleArticleCubit>(
    () => GetSingleArticleCubit(),
  );

  //==> DeleteArticleCubit
  getItInstance.registerFactory<DeleteArticleCubit>(
    () => DeleteArticleCubit(),
  );

  //==> UpdateArticleCubit
  getItInstance.registerFactory<UpdateArticleCubit>(
    () => UpdateArticleCubit(),
  );

  //==> CreateAdCubit
  getItInstance.registerFactory<CreateAdCubit>(
    () => CreateAdCubit(),
  );

  //==> CreateTaxCubit
  getItInstance.registerFactory<CreateTaxCubit>(
    () => CreateTaxCubit(),
  );

  //==> GetInProgressTaxesCubit
  getItInstance.registerFactory<GetInProgressTaxesCubit>(
    () => GetInProgressTaxesCubit(),
  );

  //==> GetCompletedTaxesCubit
  getItInstance.registerFactory<GetCompletedTaxesCubit>(
    () => GetCompletedTaxesCubit(),
  );

  //==> GetMyAdsCubit
  getItInstance.registerFactory<GetMyAdsCubit>(
    () => GetMyAdsCubit(),
  );

  //==> AcceptTermsCubit
  getItInstance.registerFactory<AcceptTermsCubit>(
    () => AcceptTermsCubit(),
  );

  //==> GetAcceptTermsCubit
  getItInstance.registerFactory<GetAcceptTermsCubit>(
    () => GetAcceptTermsCubit(),
  );

  //==> CreateTaskCubit
  getItInstance.registerFactory<CreateTaskCubit>(
    () => CreateTaskCubit(),
  );

  //==> CreateTaskClientCubit
  getItInstance.registerFactory<CreateTaskClientCubit>(
    () => CreateTaskClientCubit(),
  );

  //==> AssignTaskCubit
  getItInstance.registerFactory<AssignTaskCubit>(
    () => AssignTaskCubit(),
  );

  //==> AssignTaskClientCubit
  getItInstance.registerFactory<AssignTaskClientCubit>(
    () => AssignTaskClientCubit(),
  );

  //==> GetMyTasksCubit
  getItInstance.registerFactory<GetMyTasksCubit>(
    () => GetMyTasksCubit(),
  );

  //==> GetMySingleTaskCubit
  getItInstance.registerFactory<GetMySingleTaskCubit>(
    () => GetMySingleTaskCubit(),
  );

  //==> GetSingleTaskClientCubit
  getItInstance.registerFactory<GetSingleTaskClientCubit>(
    () => GetSingleTaskClientCubit(),
  );

  //==> UpdateTaskCubit
  getItInstance.registerFactory<UpdateTaskCubit>(
    () => UpdateTaskCubit(),
  );

  //==> DeleteTaskCubit
  getItInstance.registerFactory<DeleteTaskCubit>(
    () => DeleteTaskCubit(),
  );

  //==> EndTaskCubit
  getItInstance.registerFactory<EndTaskCubit>(
    () => EndTaskCubit(),
  );

  //==> EndTaskClientCubit
  getItInstance.registerFactory<EndTaskClientCubit>(
    () => EndTaskClientCubit(),
  );

  //==> GetAppliedTasksCubit
  getItInstance.registerFactory<GetAppliedTasksCubit>(
    () => GetAppliedTasksCubit(),
  );

  //==> GetAllTaskCubit
  getItInstance.registerFactory<GetAllTasksCubit>(
    () => GetAllTasksCubit(),
  );

  //==> ApplyForTaskCubit
  getItInstance.registerFactory<ApplyForTaskCubit>(
    () => ApplyForTaskCubit(),
  );

  //==> UploadTaskFileCubit
  getItInstance.registerFactory<UploadTaskFileCubit>(
    () => UploadTaskFileCubit(),
  );

  //==> GetInvitedTasksCubit
  getItInstance.registerFactory<GetInvitedTasksCubit>(
    () => GetInvitedTasksCubit(),
  );

  //==> DeclineTaskCubit
  getItInstance.registerFactory<DeclineTaskCubit>(
    () => DeclineTaskCubit(),
  );

  //==> SearchForLawyersCubit
  getItInstance.registerFactory<SearchForLawyersCubit>(
    () => SearchForLawyersCubit(),
  );

  //==> InviteLawyerCubit
  getItInstance.registerFactory<InviteLawyerCubit>(
    () => InviteLawyerCubit(),
  );

  //==> FilterTaskCubit
  getItInstance.registerFactory<FilterTasksCubit>(
    () => FilterTasksCubit(),
  );

  //==> GetMyConsultationsCubit
  getItInstance.registerFactory<GetMyConsultationsCubit>(
    () => GetMyConsultationsCubit(),
  );

  //==> CreateConsultationCubit
  getItInstance.registerFactory<CreateConsultationCubit>(
    () => CreateConsultationCubit(),
  );

  //==> GetMyTasksClientClientCubit
  getItInstance.registerFactory<GetMyTasksClientCubit>(
    () => GetMyTasksClientCubit(),
  );

  //==> AutoLoginCubit
  getItInstance.registerFactory<UserTokenCubit>(
    () => UserTokenCubit(
      saveUserTokenCase: getItInstance(),
      getUserTokenCase: getItInstance(),
      deleteUserTokenCase: getItInstance(),
    ),
  );

  //==> AuthorizedUserCubit
  getItInstance.registerFactory<AuthorizedUserCubit>(
    () => AuthorizedUserCubit(
      saveUserDataCase: getItInstance(),
      getUserDataCase: getItInstance(),
      deleteUserDataCase: getItInstance(),
    ),
  );

  ///************************ init usecases *********************************\\\

  //////////////////////////// Authorized user \\\\\\\\\\\\\\\\\\\\\\\\\\\\
  //==> GetAutoLogin
  getItInstance.registerLazySingleton<GetUserTokenCase>(() => GetUserTokenCase(
        appSettingsRepository: getItInstance(),
      ));

  //==> SaveAutoLogin
  getItInstance
      .registerLazySingleton<SaveUserTokenCase>(() => SaveUserTokenCase(
            appSettingsRepository: getItInstance(),
          ));

  //==> DeleteAutoLogin
  getItInstance
      .registerLazySingleton<DeleteUserTokenCase>(() => DeleteUserTokenCase(
            appSettingsRepository: getItInstance(),
          ));

  //==> SaveUserDataCase
  getItInstance.registerLazySingleton<SaveUserDataCase>(() => SaveUserDataCase(
        appSettingsRepository: getItInstance(),
      ));

  //==> GetUserDataCase
  getItInstance.registerLazySingleton<GetUserDataCase>(() => GetUserDataCase(
        appSettingsRepository: getItInstance(),
      ));

  //==> DeleteUserDataCase
  getItInstance
      .registerLazySingleton<DeleteUserDataCase>(() => DeleteUserDataCase(
            appSettingsRepository: getItInstance(),
          ));
  /////////////////////////////////////////////////////////////////////////

  //==> RegisterClientCase
  getItInstance.registerFactory<RegisterClientCase>(
    () => RegisterClientCase(remoteRepository: getItInstance()),
  );

  //==> LoginCase
  getItInstance.registerFactory<LoginCase>(
    () => LoginCase(remoteRepository: getItInstance()),
  );

  //==> TopRatedLawyersCase
  getItInstance.registerFactory<TopRatedLawyersCase>(
    () => TopRatedLawyersCase(remoteRepository: getItInstance()),
  );

  //==> GetTermsAndConditionCase
  getItInstance.registerFactory<GetTermsAndConditionsCase>(
    () => GetTermsAndConditionsCase(remoteRepository: getItInstance()),
  );

  //==> GetHelpCubit
  getItInstance.registerFactory<GetHelpCubit>(
    () => GetHelpCubit(),
  );

  //==> GetHelpCase
  getItInstance.registerFactory<GetHelpCase>(
    () => GetHelpCase(remoteRepository: getItInstance()),
  );

  //==> GetPrivacyCase
  getItInstance.registerFactory<GetPrivacyCase>(
    () => GetPrivacyCase(remoteRepository: getItInstance()),
  );

  //==> RegisterLawyerCase
  getItInstance.registerFactory<RegisterLawyerCase>(
    () => RegisterLawyerCase(remoteRepository: getItInstance()),
  );

  //==> CreateConsultationCase
  getItInstance.registerFactory<CreateConsultationCase>(
    () => CreateConsultationCase(remoteRepository: getItInstance()),
  );

  //==> GetMyTasksCaseClient
  getItInstance.registerFactory<GetMyTasksCaseClient>(
    () => GetMyTasksCaseClient(remoteRepository: getItInstance()),
  );

  //==> CreateSosCase
  getItInstance.registerFactory<CreateSosCase>(
    () => CreateSosCase(remoteRepository: getItInstance()),
  );

  //==> GetAllSosListCase
  getItInstance.registerFactory<GetAllSosListCase>(
    () => GetAllSosListCase(remoteRepository: getItInstance()),
  );

  //==> GetMySosListCase
  getItInstance.registerFactory<GetMySosListCase>(
    () => GetMySosListCase(remoteRepository: getItInstance()),
  );

  //==> DeleteSosCase
  getItInstance.registerFactory<DeleteSosCase>(
    () => DeleteSosCase(remoteRepository: getItInstance()),
  );

  //==> UpdateSosCase
  getItInstance.registerFactory<UpdateSosCase>(
    () => UpdateSosCase(remoteRepository: getItInstance()),
  );

  //==> CreateArticleCase
  getItInstance.registerFactory<CreateArticleCase>(
    () => CreateArticleCase(remoteRepository: getItInstance()),
  );

  //==> GetAllArticlesCase
  getItInstance.registerFactory<GetAllArticlesCase>(
    () => GetAllArticlesCase(remoteRepository: getItInstance()),
  );

  //==> UpdateArticleCase
  getItInstance.registerFactory<UpdateArticleCase>(
    () => UpdateArticleCase(remoteRepository: getItInstance()),
  );

  //==> GetSingleArticleCase
  getItInstance.registerFactory<GetSingleArticleCase>(
    () => GetSingleArticleCase(remoteRepository: getItInstance()),
  );

  //==> GetMyArticlesCase
  getItInstance.registerFactory<GetMyArticlesCase>(
    () => GetMyArticlesCase(remoteRepository: getItInstance()),
  );

  //==> DeleteArticleCase
  getItInstance.registerFactory<DeleteArticleCase>(
    () => DeleteArticleCase(remoteRepository: getItInstance()),
  );

  //==> CreateAdCase
  getItInstance.registerFactory<CreateAdCase>(
    () => CreateAdCase(remoteRepository: getItInstance()),
  );

  //==> CreateTaxCase
  getItInstance.registerFactory<CreateTaxCase>(
    () => CreateTaxCase(remoteRepository: getItInstance()),
  );

  //==> GetCompletedTaxesCase
  getItInstance.registerFactory<GetCompletedTaxesCase>(
    () => GetCompletedTaxesCase(remoteRepository: getItInstance()),
  );

  //==> GetMyAdsCase
  getItInstance.registerFactory<GetMyAdsCase>(
    () => GetMyAdsCase(remoteRepository: getItInstance()),
  );

  //==> GetInProgressTaxesCase
  getItInstance.registerFactory<GetInProgressTaxesCase>(
    () => GetInProgressTaxesCase(remoteRepository: getItInstance()),
  );

  //==> GetAboutCase
  getItInstance.registerFactory<GetAboutCase>(
    () => GetAboutCase(remoteRepository: getItInstance()),
  );

  //==> AcceptTermsCase
  getItInstance.registerFactory<AcceptTermsCase>(
    () => AcceptTermsCase(remoteRepository: getItInstance()),
  );

  //==> CreateTaskCase
  getItInstance.registerFactory<CreateTaskCase>(
    () => CreateTaskCase(remoteRepository: getItInstance()),
  );

  //==> GetMyConsultationsCase
  getItInstance.registerFactory<GetMyConsultationsCase>(
    () => GetMyConsultationsCase(remoteRepository: getItInstance()),
  );

  //==> CreateTaskClientCase
  getItInstance.registerFactory<CreateTaskClientCase>(
    () => CreateTaskClientCase(remoteRepository: getItInstance()),
  );

  //==> AssignTaskCase
  getItInstance.registerFactory<AssignTaskCase>(
    () => AssignTaskCase(remoteRepository: getItInstance()),
  );

  //==> AssignTaskClientCase
  getItInstance.registerFactory<AssignTaskClientCase>(
    () => AssignTaskClientCase(remoteRepository: getItInstance()),
  );

  //==> ApplyForTaskCase
  getItInstance.registerFactory<ApplyForTaskCase>(
    () => ApplyForTaskCase(remoteRepository: getItInstance()),
  );

  //==> GetMyTasksCase
  getItInstance.registerFactory<GetMyTasksCase>(
    () => GetMyTasksCase(remoteRepository: getItInstance()),
  );

  //==> GetMySingleTaskCase
  getItInstance.registerFactory<GetMySingleTaskCase>(
    () => GetMySingleTaskCase(remoteRepository: getItInstance()),
  );

  //==> GetSingleTaskClientCase
  getItInstance.registerFactory<GetSingleTaskClientCase>(
    () => GetSingleTaskClientCase(remoteRepository: getItInstance()),
  );

  //==> UpdateTaskCase
  getItInstance.registerFactory<UpdateTaskCase>(
    () => UpdateTaskCase(remoteRepository: getItInstance()),
  );

  //==> DeleteTaskCase
  getItInstance.registerFactory<DeleteTaskCase>(
    () => DeleteTaskCase(remoteRepository: getItInstance()),
  );

  //==> EndTaskCase
  getItInstance.registerFactory<EndTaskCase>(
    () => EndTaskCase(remoteRepository: getItInstance()),
  );

  //==> EndTaskClientCase
  getItInstance.registerFactory<EndTaskClientCase>(
    () => EndTaskClientCase(remoteRepository: getItInstance()),
  );

  //==> GetAppliedTasksCase
  getItInstance.registerFactory<GetAppliedTasksCase>(
    () => GetAppliedTasksCase(remoteRepository: getItInstance()),
  );

  //==> UploadTaskFileCase
  getItInstance.registerFactory<UploadTaskFileCase>(
    () => UploadTaskFileCase(remoteRepository: getItInstance()),
  );

  //==> GetAcceptTermsCase
  getItInstance.registerFactory<GetAcceptTermsCase>(
    () => GetAcceptTermsCase(remoteRepository: getItInstance()),
  );

  //==> GetAllTasksCase
  getItInstance.registerFactory<GetAllTasksCase>(
    () => GetAllTasksCase(remoteRepository: getItInstance()),
  );

  //==> GetInvitedTasksCase
  getItInstance.registerFactory<GetInvitedTasksCase>(
    () => GetInvitedTasksCase(remoteRepository: getItInstance()),
  );

  //==> DeclineInvitedTaskCase
  getItInstance.registerFactory<DeclineInvitedTaskCase>(
    () => DeclineInvitedTaskCase(remoteRepository: getItInstance()),
  );

  //==> SearchForLawyerCase
  getItInstance.registerFactory<SearchForLawyerCase>(
    () => SearchForLawyerCase(remoteRepository: getItInstance()),
  );

  //==> InviteToTaskCase
  getItInstance.registerFactory<InviteToTaskCase>(
    () => InviteToTaskCase(remoteRepository: getItInstance()),
  );

  //==> FilterTasksCase
  getItInstance.registerFactory<FilterTasksCase>(
    () => FilterTasksCase(remoteRepository: getItInstance()),
  );
}
