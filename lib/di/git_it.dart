import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:yamaiter/domain/repositories/app_settings_repository.dart';
import 'package:yamaiter/domain/use_cases/app_settings/auto_login/get_auto_login.dart';
import 'package:yamaiter/presentation/logic/cubit/auto_login/auto_login_cubit.dart';

import '../data/api/init_rest_api_client.dart';
import '../data/api/rest_http_methods.dart';
import '../data/data_source/app_settings_local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/repositories/app_settings_repository_impl.dart';
import '../domain/repositories/remote_repository.dart';
import '../data/repositories/remote_repository_impl.dart';
import '../domain/use_cases/app_settings/auto_login/delete_auto_login.dart';
import '../domain/use_cases/app_settings/auto_login/save_auto_login.dart';
import '../presentation/logic/cubit/forget_password/forget_password_cubit.dart';
import '../presentation/logic/cubit/login/login_cubit.dart';
import '../presentation/logic/cubit/pick_images/pick_image_cubit.dart';
import '../presentation/logic/cubit/register_client/register_client_cubit.dart';
import '../presentation/logic/cubit/register_lawyer/register_lawyer_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  ///************************ init ApiClient ********************************\\\

  /// RestApi
  getItInstance.registerFactory<http.Client>(() => initHttpClient());

  /// Http methods
  getItInstance.registerFactory<RestApiMethods>(
    () => RestApiMethods(
      restApiClient: getItInstance(),
    ),
  );

  ///*************************** init DataSource **********************\\\
  getItInstance.registerFactory<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      restApiMethods: getItInstance(),
    ),
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

  //==> AutoLoginCubit
  getItInstance.registerFactory<AutoLoginCubit>(
    () => AutoLoginCubit(
      saveAutoLoginCase: getItInstance(),
      getAutoLoginCase: getItInstance(),
      deleteAutoLoginCase: getItInstance(),
    ),
  );

  ///************************ init usecases *********************************\\\
  //==> GetAutoLogin
  getItInstance.registerLazySingleton<GetAutoLoginCase>(() => GetAutoLoginCase(
        appSettingsRepository: getItInstance(),
      ));

  //==> SaveAutoLogin
  getItInstance
      .registerLazySingleton<SaveAutoLoginCase>(() => SaveAutoLoginCase(
            appSettingsRepository: getItInstance(),
          ));

  //==> DeleteAutoLogin
  getItInstance
      .registerLazySingleton<DeleteAutoLoginCase>(() => DeleteAutoLoginCase(
            appSettingsRepository: getItInstance(),
          ));
}
