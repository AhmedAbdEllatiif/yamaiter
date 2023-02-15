part of 'get_balance_cubit.dart';

abstract class GetBalanceState extends Equatable {
  const GetBalanceState();

  @override
  List<Object> get props => [];
}

/// initial
class GetBalanceInitial extends GetBalanceState {}

/// loading
class LoadingBalance extends GetBalanceState {}

/// unAuthorized
class UnAuthorizedGetBalance extends GetBalanceState {}

/// no balance
class UserHaveNoBalance extends GetBalanceState {}

/// success
class BalanceFetchedSuccessfully extends GetBalanceState {
  final BalanceEntity balanceEntity;

  const BalanceFetchedSuccessfully({
    required this.balanceEntity,
  });

  @override
  List<Object> get props => [balanceEntity];
}

/// error
class ErrorWhileFetchingBalance extends GetBalanceState {
  final AppError appError;

  const ErrorWhileFetchingBalance({required this.appError});

  @override
  List<Object> get props => [appError];
}
