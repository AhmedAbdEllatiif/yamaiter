import 'package:yamaiter/presentation/logic/client_cubit/create_consultation/create_consultation_cubit.dart';
import 'package:yamaiter/presentation/logic/common/chat_room/chat_room_cubit.dart';
import 'package:yamaiter/presentation/logic/common/get_balance/get_balance_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/apply_for_task/apply_for_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/assign_task/assign_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_article/create_article_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_sos/create_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_task/create_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_sos/delete_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_task/delete_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/end_task/end_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/fetch_chat_list/fetch_chat_list_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/filter_tasks/filter_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_all_articles/get_all_articles_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_all_sos/get_all_soso_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_completed_taxes/get_completed_taxes_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_invited_tasks/get_invited_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_ads/get_my_ads_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_sos/get_my_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_single_task_details_cubit/get_single_task_details_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_single_task_details_cubit/get_single_task_details_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/invite_lawyer/invite_lawyer_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/my_articles/my_articles_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/side_menu_page/side_menu_page_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/update_article/update_article_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/update_sos_cubit/update_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/upload_task_file/upload_task_file_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/user_token/user_token_cubit.dart';

import '../presentation/logic/client_cubit/get_consultation_details/get_consultation_details_cubit.dart';
import '../presentation/logic/client_cubit/get_my_consultations/get_my_consultations_cubit.dart';
import '../presentation/logic/common/app_announcements/get_app_announcements_cubit.dart';
import '../presentation/logic/common/change_password/change_password_cubit.dart';
import '../presentation/logic/common/check_payment_status/check_payment_status_cubit.dart';
import '../presentation/logic/common/notifications_listeners/notifications_listeners_cubit.dart';
import '../presentation/logic/common/payout/payout_cubit.dart';
import '../presentation/logic/common/refund_payment/refund_payment_cubit.dart';
import '../presentation/logic/common/store_fb_token/store_firebase_token_cubit.dart';
import '../presentation/logic/cubit/accept_terms/accept_terms_cubit.dart';
import '../presentation/logic/cubit/charge_balance_cubit/charge_balance_cubit.dart';
import '../presentation/logic/cubit/create_ad/create_ad_cubit.dart';
import '../presentation/logic/cubit/first_launch/first_launch_cubit.dart';
import '../presentation/logic/cubit/pay_for_tax/pay_for_tax_cubit.dart';
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
import '../presentation/logic/cubit/login/login_cubit.dart';
import '../presentation/logic/cubit/pick_images/pick_image_cubit.dart';
import '../presentation/logic/cubit/register_client/register_client_cubit.dart';
import '../presentation/logic/cubit/register_lawyer/register_lawyer_cubit.dart';
import '../presentation/logic/cubit/search_for_lawyers/search_for_lawyers_cubit.dart';
import '../presentation/logic/cubit/fetch_lawyers/fetch_lawyers_cubit.dart';
import '../presentation/logic/cubit/send_chat_message/send_chat_message_cubit.dart';
import '../presentation/logic/cubit/update_client_profile/update_client_profile_cubit.dart';
import '../presentation/logic/cubit/update_lawyer_profile/update_lawyer_profile_cubit.dart';
import '../presentation/logic/cubit/update_task/update_task_cubit.dart';
import 'git_it_instance.dart';

Future init() async {
  //==> PickImageCubit
  getItInstance.registerFactory<PickImageCubit>(
    () => PickImageCubit(),
  );

  //==> FetchLawyersCubit
  getItInstance.registerFactory<FetchLawyersCubit>(
    () => FetchLawyersCubit(),
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
  getItInstance.registerFactory<AboutUsPageCubit>(
    () => AboutUsPageCubit(),
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
  getItInstance.registerFactory<PayForTaxCubit>(
    () => PayForTaxCubit(),
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

  // GetSingleTaskDetailsCubit
  getItInstance.registerFactory<GetSingleTaskDetailsCubit>(
    () => GetSingleTaskDetailsCubit(),
  );

  //==> CreateTaskCubit
  getItInstance.registerFactory<CreateTaskCubit>(
    () => CreateTaskCubit(),
  );

  //==> AssignTaskCubit
  getItInstance.registerFactory<PaymentAssignTaskCubit>(
    () => PaymentAssignTaskCubit(),
  );

  //==> GetMyTasksCubit
  getItInstance.registerFactory<GetMyTasksCubit>(
    () => GetMyTasksCubit(),
  );

  //==> GetMySingleTaskCubit
  getItInstance.registerFactory<GetMySingleTaskCubit>(
    () => GetMySingleTaskCubit(),
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

  //==> GetConsultationDetailsCubit
  getItInstance.registerFactory<GetConsultationDetailsCubit>(
    () => GetConsultationDetailsCubit(),
  );

  //==> CheckPaymentStatusCubit
  getItInstance.registerFactory<CheckPaymentStatusCubit>(
    () => CheckPaymentStatusCubit(),
  );

  //==> RefundPaymentCubit
  getItInstance.registerFactory<RefundPaymentCubit>(
    () => RefundPaymentCubit(),
  );

  //==> PayoutCubit
  getItInstance.registerFactory<PayoutCubit>(
    () => PayoutCubit(),
  );

  //==> GetBalanceCubit
  getItInstance.registerFactory<GetBalanceCubit>(
    () => GetBalanceCubit(),
  );

  //==> ChargeBalanceCubit
  getItInstance.registerFactory<ChargeBalanceCubit>(
    () => ChargeBalanceCubit(),
  );

  //==> ChatRoomCubit
  getItInstance.registerFactory<ChatRoomCubit>(
    () => ChatRoomCubit(),
  );

  //==> SendChatMessageCubit
  getItInstance.registerFactory<SendChatMessageCubit>(
    () => SendChatMessageCubit(),
  );

  //==> FetchChatListCubit
  getItInstance.registerFactory<FetchChatListCubit>(
    () => FetchChatListCubit(),
  );

  //==> UpdateClientProfileCubit
  getItInstance.registerFactory<UpdateClientProfileCubit>(
    () => UpdateClientProfileCubit(authorizedUserCubit: getItInstance()),
  );

  //==> UpdateLawyerProfileCubit
  getItInstance.registerFactory<UpdateLawyerProfileCubit>(
    () => UpdateLawyerProfileCubit(authorizedUserCubit: getItInstance()),
  );

  //==> GetAppAnnouncementsCubit
  getItInstance.registerFactory<GetAppAnnouncementsCubit>(
    () => GetAppAnnouncementsCubit(),
  );

  //==> StoreFirebaseTokenCubit
  getItInstance.registerFactory<StoreFirebaseTokenCubit>(
    () => StoreFirebaseTokenCubit(),
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
    () => AuthorizedUserCubit(),
  );

  //==> ChangePasswordCubit
  getItInstance.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(),
  );

  //==> NotificationsListenersCubit
  getItInstance.registerSingleton<NotificationsListenersCubit>(
    NotificationsListenersCubit(),
  );

  getItInstance.registerFactory<FirstLaunchStatusCubit>(
    () => FirstLaunchStatusCubit(),
  );
}
