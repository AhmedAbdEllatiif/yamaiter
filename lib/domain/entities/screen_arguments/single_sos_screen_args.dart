import 'package:yamaiter/domain/entities/data/sos_entity.dart';

class SingleScreenArguments {
  final SosEntity? sosEntity;
  final int? sosId;
  final bool withCallButton;

  SingleScreenArguments({
    this.sosEntity,
    this.sosId,
    required this.withCallButton,
  });
}
