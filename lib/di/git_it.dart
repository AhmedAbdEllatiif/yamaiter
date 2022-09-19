import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:yamaiter/presentation/logic/pick_images/pick_image_cubit.dart';

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
  getItInstance.registerFactory<PickImageCubit>(
        () => PickImageCubit(),
  );

}
