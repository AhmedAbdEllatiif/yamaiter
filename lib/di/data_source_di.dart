import 'git_it_instance.dart';

import '../data/data_source/app_settings_data_source.dart';
import '../data/data_source/remote_data_source.dart';

Future init() async {
  ///*************************** init DataSource **********************\\\
  getItInstance.registerFactory<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );

  //==> AppSettingsDataSource
  getItInstance.registerFactory<AppSettingsDataSource>(
    () => AppSettingsDataSourceImpl(),
  );
}
