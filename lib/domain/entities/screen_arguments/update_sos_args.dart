import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/update_sos_cubit/update_sos_cubit.dart';

class UpdateSosArguments {
  final UpdateSosCubit updateSosCubit;
  final String userToken;
  final SosEntity sosEntity;

  UpdateSosArguments({
    required this.sosEntity,
    required this.userToken,
    required this.updateSosCubit,
  });
}
