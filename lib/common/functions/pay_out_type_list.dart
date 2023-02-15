import '../enum/pay_out_type.dart';

Map<PayoutType, String> getPayoutTypeList() {
  return {
    PayoutType.vodafone: "فودافون كاش",
    PayoutType.etisalat: "إتصالات كاش",
    PayoutType.orange: "أورانج كاش",
    PayoutType.bankWallet: "محفظة بنكية",
  };
}
