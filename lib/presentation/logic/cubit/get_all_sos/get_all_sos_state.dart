part of 'get_all_soso_cubit.dart';

abstract class GetAllSosState extends Equatable {
  const GetAllSosState();
  @override
  List<Object> get props => [];
}

/// initial
class GetAllSosInitial extends GetAllSosState {}

/// loading
class LoadingGetAllSosList extends GetAllSosState {}

/// loading more
class LoadingMoreAllSosList extends GetAllSosState {}

/// empty
class EmptyAllSosList extends GetAllSosState {}

/// unAuthorized
class UnAuthorizedGetAllSosList extends GetAllSosState {}

/// not a lawyer to get my sos list
class NotActivatedUserToGetAllSosList extends GetAllSosState {}

/// success
class AllSosListFetchedSuccessfully extends GetAllSosState {
  final List<SosEntity> sosEntityList;

  const AllSosListFetchedSuccessfully({required this.sosEntityList});

  @override
  List<Object> get props => [sosEntityList];
}


/// last page fetched loaded
class LastPageAllSosReached extends GetAllSosState {
  final List<SosEntity> sosEntityList;

  const LastPageAllSosReached({
    required this.sosEntityList,
  });

  @override
  List<Object> get props => [sosEntityList];
}

/// error
class ErrorWhileGettingAllSosList extends GetAllSosState {
  final AppError appError;

  const ErrorWhileGettingAllSosList({required this.appError});

  @override
  List<Object> get props => [appError];
}


/// error  while loading more
class ErrorWhileLoadingMoreAllSos extends GetAllSosState {
  final AppError appError;

  const ErrorWhileLoadingMoreAllSos({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
