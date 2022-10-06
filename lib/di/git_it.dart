import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:yamaiter/domain/repositories/app_settings_repository.dart';
import 'package:yamaiter/domain/use_cases/get_all_sos.dart';
import 'package:yamaiter/domain/use_cases/get_my_sos_list.dart';
import 'package:yamaiter/domain/use_cases/get_my_sos_list.dart';
import 'package:yamaiter/domain/use_cases/help.dart';
import 'package:yamaiter/domain/use_cases/help.dart';
import 'package:yamaiter/domain/use_cases/login.dart';
import 'package:yamaiter/domain/use_cases/privacy.dart';
import 'package:yamaiter/domain/use_cases/register_lawyer.dart';
import 'package:yamaiter/domain/use_cases/terms_and_conditions.dart';
import 'package:yamaiter/presentation/logic/cubit/create_article/create_article_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_sos/create_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_sos/create_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_all_sos/get_all_soso_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_sos/get_my_sos_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/side_menu_page/side_menu_page_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/user_token/user_token_cubit.dart';

import '../data/api/init_rest_api_client.dart';
import '../data/data_source/app_settings_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/repositories/app_settings_repository_impl.dart';
import '../domain/repositories/remote_repository.dart';
import '../data/repositories/remote_repository_impl.dart';
import '../domain/use_cases/about.dart';
import '../domain/use_cases/app_settings/user_token/get_user_token.dart';
import '../domain/use_cases/app_settings/user_token/delete_user_token.dart';
import '../domain/use_cases/app_settings/user_token/save_user_token.dart';
import '../domain/use_cases/article/create_article.dart';
import '../domain/use_cases/create_sos.dart';
import '../presentation/logic/cubit/forget_password/forget_password_cubit.dart';
import '../presentation/logic/cubit/help/get_help_cubit.dart';
import '../presentation/logic/cubit/login/login_cubit.dart';
import '../presentation/logic/cubit/pick_images/pick_image_cubit.dart';
import '../presentation/logic/cubit/register_client/register_client_cubit.dart';
import '../presentation/logic/cubit/register_lawyer/register_lawyer_cubit.dart';

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

  //==> GetAllSosCubit
  getItInstance.registerFactory<GetAllSosCubit>(
    () => GetAllSosCubit(),
  );

  //==> CreateArticleCubit
  getItInstance.registerFactory<CreateArticleCubit>(
    () => CreateArticleCubit(),
  );
  //==> AutoLoginCubit
  getItInstance.registerFactory<UserTokenCubit>(
    () => UserTokenCubit(
      saveUserTokenCase: getItInstance(),
      getUserTokenCase: getItInstance(),
      deleteUserTokenCase: getItInstance(),
    ),
  );

  ///************************ init usecases *********************************\\\
  //==> LoginCase
  getItInstance.registerFactory<LoginCase>(
    () => LoginCase(remoteRepository: getItInstance()),
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

  //==> CreateArticleCase
  getItInstance.registerFactory<CreateArticleCase>(
    () => CreateArticleCase(remoteRepository: getItInstance()),
  );

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

  //==> GetAboutCase
  getItInstance.registerFactory<GetAboutCase>(
    () => GetAboutCase(remoteRepository: getItInstance()),
  );
}
