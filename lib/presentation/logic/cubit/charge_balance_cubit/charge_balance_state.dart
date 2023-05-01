part of 'charge_balance_cubit.dart';

abstract class ChargeBalanceState extends Equatable {
  const ChargeBalanceState();

  @override
  List<Object> get props => [];
}

/// initial
class ChargeBalanceInitial extends ChargeBalanceState {}

/// loading
class LoadingToChargeBalance extends ChargeBalanceState {}

/// unAuthorized
class UnAuthorizedToChargeBalance extends ChargeBalanceState {}

/// success
class BalanceChargedSuccessfully extends ChargeBalanceState {
  final ChargeBalanceEntity chargeBalanceEntity;

  const BalanceChargedSuccessfully({
    required this.chargeBalanceEntity,
  });

  @override
  List<Object> get props => [chargeBalanceEntity];
}

/// error
class ErrorWhileChargingBalance extends ChargeBalanceState {
  final AppError appError;

  const ErrorWhileChargingBalance({required this.appError});

  @override
  List<Object> get props => [appError];
}
