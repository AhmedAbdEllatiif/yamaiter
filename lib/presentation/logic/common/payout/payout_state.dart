part of 'payout_cubit.dart';

abstract class PayoutState extends Equatable {
  const PayoutState();

  @override
  List<Object> get props => [];
}

/// initial
class PayoutInitial extends PayoutState {}

/// loading
class LoadingPayout extends PayoutState {}

/// unAuthorized
class UnAuthorizedToSendPayout extends PayoutState {}

/// no amount
class NoAmountToPayout extends PayoutState{}

///
class NoPayoutErrorFromPayMobServer extends PayoutState{}

/// success
class PayoutSentSuccessfully extends PayoutState {}

/// error
class ErrorWhileSendingPayout extends PayoutState {
  final AppError appError;

  const ErrorWhileSendingPayout({required this.appError});

  @override
  List<Object> get props => [appError];
}
