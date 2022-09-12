import 'package:yamaiter/data/repositories/remote_repository.dart';

import '../../data/data_source/remote_data_source.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RemoteDataSource remoteDataSource;

  RemoteRepositoryImpl({
    required this.remoteDataSource,
  });
}
