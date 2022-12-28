import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/payment_mission_type.dart';

class PayEntity extends Equatable {
  final String link;
  final PaymentMissionType paymentMissionType;
  final int missionId;

  const PayEntity({
    required this.link,
    required this.paymentMissionType,
    required this.missionId,
  });

  @override
  List<Object?> get props => [link];
}
