part of 'get_in_progress_taxes_cubit.dart';

abstract class GetInProgressTaxesState extends Equatable {
  const GetInProgressTaxesState();

  @override
  List<Object> get props => [];
}

/// initial
class GetInProgressTaxesInitial extends GetInProgressTaxesState {}

/// loading
class LoadingGetInProgressTaxesList extends GetInProgressTaxesState {}

/// loading more
class LoadingMoreInProgressTaxesList extends GetInProgressTaxesState {}

/// empty
class EmptyInProgressTaxesList extends GetInProgressTaxesState {}

/// unAuthorized
class UnAuthorizedGetInProgressTaxesList extends GetInProgressTaxesState {}

/// not a lawyer to get my sos list
class NotActivatedUserToGetInProgressTaxesList extends GetInProgressTaxesState {
}

/// success
class InProgressTaxesListFetchedSuccessfully extends GetInProgressTaxesState {
  final List<TaxEntity> taxList;

  const InProgressTaxesListFetchedSuccessfully({required this.taxList});

  @override
  List<Object> get props => [taxList];
}

/// lastPage fetched
class LastPageInProgressTaxesListFetched extends GetInProgressTaxesState {
  final List<TaxEntity> taxList;

  const LastPageInProgressTaxesListFetched({required this.taxList});

  @override
  List<Object> get props => [taxList];
}

/// error
class ErrorWhileGettingInProgressTaxesList extends GetInProgressTaxesState {
  final AppError appError;

  const ErrorWhileGettingInProgressTaxesList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileGettingMoreInProgressTaxesList extends GetInProgressTaxesState {
  final AppError appError;

  const ErrorWhileGettingMoreInProgressTaxesList({required this.appError});

  @override
  List<Object> get props => [appError];
}
