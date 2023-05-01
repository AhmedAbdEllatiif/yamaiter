import '../../../params/payment/charge_balance_params.dart';

class ChargeBalanceRequestModel {
  final num amount;

  ChargeBalanceRequestModel({required this.amount});

  factory ChargeBalanceRequestModel.fromParams(ChargeBalanceParams params) =>
      ChargeBalanceRequestModel(amount: params.amountToCharge);

  Map<String, String> toJson() {
    return {
      "name": "charge",
      "amount_cents": amount.toString(),
      "description": "charge my balance"
    };
  }
}
