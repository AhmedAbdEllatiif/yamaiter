part of 'search_for_lawyers_cubit.dart';

abstract class SearchForLawyersState extends Equatable {
  const SearchForLawyersState();

  @override
  List<Object> get props => [];
}

/// initial
class SearchForLawyersInitial extends SearchForLawyersState {}

/// loading
class LoadingSearchForLawyersList extends SearchForLawyersState {}

/// loading more
class LoadingMoreAllTasksList extends SearchForLawyersState {}

/// empty
class NoLawyersFound extends SearchForLawyersState {}

/// unAuthorized
class UnAuthorizedSearchForLawyers extends SearchForLawyersState {}

/// not a lawyer to get All Tasks list
class NotActivatedUserToSearchForLawyers extends SearchForLawyersState {}

/// lastPage fetched
class LastPageSearchForLawyersFetched extends SearchForLawyersState {
  final List<LawyerEntity> lawyersResult;

  const LastPageSearchForLawyersFetched({required this.lawyersResult});

  @override
  List<Object> get props => [lawyersResult];
}

/// success
class SearchLawyersResult extends SearchForLawyersState {
  final List<LawyerEntity> lawyersResult;

  const SearchLawyersResult({required this.lawyersResult});

  @override
  List<Object> get props => [lawyersResult];
}

/// error
class ErrorWhileSearchingForLawyers extends SearchForLawyersState {
  final AppError appError;

  const ErrorWhileSearchingForLawyers({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileLoadingMoreLawyers extends SearchForLawyersState {
  final AppError appError;

  const ErrorWhileLoadingMoreLawyers({required this.appError});

  @override
  List<Object> get props => [appError];
}
