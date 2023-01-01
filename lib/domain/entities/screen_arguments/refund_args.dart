import 'package:yamaiter/common/enum/payment_mission_type.dart';
import 'package:yamaiter/presentation/logic/common/refund_payment/refund_payment_cubit.dart';

class RefundArguments {
  final RefundPaymentCubit refundPaymentCubit;
  final PaymentMissionType paymentMissionType;
  final int missionId;
  final String refundFees;
  final Function()? onRefundSuccess;

  RefundArguments({
    required this.refundPaymentCubit,
    required this.paymentMissionType,
    required this.missionId,
    required this.refundFees,
    this.onRefundSuccess,
  });
}
