part of 'get_completed_taxes_cubit.dart';

abstract class GetCompletedTaxesState extends Equatable {
  const GetCompletedTaxesState();

  @override
  List<Object> get props => [];
}

/// initial
class GetCompletedTaxesInitial extends GetCompletedTaxesState {}

/// loading
class LoadingGetCompletedTaxesList extends GetCompletedTaxesState {}

/// loading more
class LoadingMoreCompletedTaxesList extends GetCompletedTaxesState {}

/// empty
class EmptyCompletedTaxesList extends GetCompletedTaxesState {}

/// unAuthorized
class UnAuthorizedGetCompletedTaxesList extends GetCompletedTaxesState {}

/// not a lawyer to get my sos list
class NotActivatedUserToGetCompletedTaxesList extends GetCompletedTaxesState {}

/// success
class CompletedTaxesListFetchedSuccessfully extends GetCompletedTaxesState {
  final List<TaxEntity> taxList;

  const CompletedTaxesListFetchedSuccessfully({required this.taxList});

  @override
  List<Object> get props => [taxList];
}

/// lastPage fetched
class LastPageCompletedTaxesListFetched extends GetCompletedTaxesState {
  final List<TaxEntity> taxList;

  const LastPageCompletedTaxesListFetched({required this.taxList});

  @override
  List<Object> get props => [taxList];
}

/// error
class ErrorWhileGettingCompletedTaxesList extends GetCompletedTaxesState {
  final AppError appError;

  const ErrorWhileGettingCompletedTaxesList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileGettingMoreCompletedTaxesList extends GetCompletedTaxesState {
  final AppError appError;

  const ErrorWhileGettingMoreCompletedTaxesList({required this.appError});

  @override
  List<Object> get props => [appError];
}
