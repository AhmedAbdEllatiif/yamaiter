import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:yamaiter/presentation/logic/forget_password/forget_password_cubit.dart';
import 'package:yamaiter/presentation/logic/login/login_cubit.dart';
import 'package:yamaiter/presentation/logic/pick_images/pick_image_cubit.dart';
import 'package:yamaiter/presentation/logic/register_client/register_client_cubit.dart';
import 'package:yamaiter/presentation/logic/register_lawyer/register_lawyer_cubit.dart';

import '../data/api/init_rest_api_client.dart';
import '../data/api/rest_http_methods.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/repositories/remote_repository.dart';
import '../domain/repositories/remote_repository_impl.dart';

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

  ///*************************** init RemoteDataSource **********************\\\
  getItInstance.registerFactory<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      restApiMethods: getItInstance(),
    ),
  );

  ///********************** init RemoteRepository ***************************\\\
  getItInstance.registerFactory<RemoteRepository>(
        () => RemoteRepositoryImpl(
      remoteDataSource: getItInstance(),
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

}
