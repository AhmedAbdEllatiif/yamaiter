import 'package:yamaiter/presentation/logic/cubit/delete_sos/delete_sos_cubit.dart';

class DeleteSosArguments {
  final int sosId;
  final String userToken;
  final DeleteSosCubit deleteSosCubit;

  DeleteSosArguments({
    required this.sosId,
    required this.userToken,
    required this.deleteSosCubit,
  });
}
