import 'package:yamaiter/domain/entities/data/sos_entity.dart';

class SingleScreenArguments {
  final SosEntity sosEntity;
  final bool withCallButton;

  SingleScreenArguments(
      {required this.sosEntity, required this.withCallButton});
}
