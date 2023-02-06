
import 'package:yamaiter/domain/use_cases/applied_tasks/apply_for_task.dart';
import 'package:yamaiter/domain/use_cases/article/get_all_articles.dart';
import 'package:yamaiter/domain/use_cases/authorized_user/authorized_user_data/delete_user_data.dart';
import 'package:yamaiter/domain/use_cases/authorized_user/authorized_user_data/get_user_data.dart';
import 'package:yamaiter/domain/use_cases/authorized_user/authorized_user_data/save_user_data.dart';
import 'package:yamaiter/domain/use_cases/my_tasks/assign_task.dart';
import 'package:yamaiter/domain/use_cases/sos/get_all_sos.dart';
import 'package:yamaiter/domain/use_cases/sos/get_my_sos_list.dart';
import 'package:yamaiter/domain/use_cases/help.dart';
import 'package:yamaiter/domain/use_cases/login.dart';
import 'package:yamaiter/domain/use_cases/privacy.dart';
import 'package:yamaiter/domain/use_cases/register_lawyer.dart';
import 'package:yamaiter/domain/use_cases/taxes/get_in_progress_taxes.dart';
import 'package:yamaiter/domain/use_cases/terms_and_conditions.dart';
import 'package:yamaiter/domain/use_cases/fetch_lawyers.dart';

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
import '../domain/use_cases/chat/fetch_chat_list.dart';
import '../domain/use_cases/chat/get_chat_room_by_id.dart';
import '../domain/use_cases/chat/send_chat_message_case.dart';
import '../domain/use_cases/payment/check_paymet_status.dart';
import '../domain/use_cases/client/consultations/create_consultaion.dart';
import '../domain/use_cases/client/consultations/get_consultation_details_case.dart';
import '../domain/use_cases/client/consultations/get_my_consultations.dart';
import '../domain/use_cases/client_auth/register_client.dart';
import '../domain/use_cases/filter_tasks.dart';
import '../domain/use_cases/invited_tasks.dart';
import '../domain/use_cases/my_tasks/end_task.dart';
import '../domain/use_cases/my_tasks/get_my_single_task.dart';
import '../domain/use_cases/my_tasks/invite_to_task.dart';
import '../domain/use_cases/payment/refund_payment.dart';
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
import '../domain/use_cases/taxes/pay_for_tax.dart';
import '../domain/use_cases/get_single_article.dart';
import '../domain/use_cases/taxes/get_completed_taxes.dart';
import '../domain/use_cases/update_profile/update_client_profile_case.dart';
import '../presentation/logic/cubit/help/get_help_cubit.dart';
import 'git_it_instance.dart';


Future init() async {

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
  getItInstance.registerFactory<FetchLawyersCase>(
        () => FetchLawyersCase(remoteRepository: getItInstance()),
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

  //==> GetConsultationDetailsCase
  getItInstance.registerFactory<GetConsultationDetailsCase>(
        () => GetConsultationDetailsCase(remoteRepository: getItInstance()),
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
  getItInstance.registerFactory<PayForTaxCase>(
        () => PayForTaxCase(remoteRepository: getItInstance()),
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

  //==> AssignTaskCase
  getItInstance.registerFactory<AssignTaskCase>(
        () => AssignTaskCase(remoteRepository: getItInstance()),
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

  //==> CheckPaymentStatusCase
  getItInstance.registerFactory<CheckPaymentStatusCase>(
        () => CheckPaymentStatusCase(remoteRepository: getItInstance()),
  );

  //==> RefundPaymentCase
  getItInstance.registerFactory<RefundPaymentCase>(
        () => RefundPaymentCase(remoteRepository: getItInstance()),
  );

  //==> GetChatRoomByIdCase
  getItInstance.registerFactory<GetChatRoomByIdCase>(
        () => GetChatRoomByIdCase(remoteRepository: getItInstance()),
  );

  //==> SendChatMessageCase
  getItInstance.registerFactory<SendChatMessageCase>(
        () => SendChatMessageCase(remoteRepository: getItInstance()),
  );

  //==> FetchChatListCase
  getItInstance.registerFactory<FetchChatListCase>(
        () => FetchChatListCase(remoteRepository: getItInstance()),
  );



  ///========================>  Update profile <========================\\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///                                                                   \\\\
  ///===================================================================\\\\
  //==> UpdateClientProfileCase
  getItInstance.registerFactory<UpdateClientProfileCase>(
        () => UpdateClientProfileCase(remoteRepository: getItInstance()),
  );

}
