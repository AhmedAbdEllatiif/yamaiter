part of 'get_single_sos_cubit.dart';

abstract class GetSingleSosState extends Equatable {
  const GetSingleSosState();

  @override
  List<Object> get props => [];
}

/// initial
class GetSingleSosInitial extends GetSingleSosState {}

/// loading
class LoadingSingleSos extends GetSingleSosState {}

/// unAuthenticated
class UnAuthenticatedToFetchSingleSos extends GetSingleSosState {}

/// success
class SosFetchedSuccessfully extends GetSingleSosState {
  final SosEntity sosEntity;

  const SosFetchedSuccessfully({required this.sosEntity});

  @override
  List<Object> get props => [sosEntity];
}

/// error
class ErrorWhileFetchingSingleSos extends GetSingleSosState {
  final AppError appError;

  const ErrorWhileFetchingSingleSos({required this.appError});

  @override
  List<Object> get props => [appError];
}
