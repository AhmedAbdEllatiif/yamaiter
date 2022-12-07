part of 'fetch_lawyers_cubit.dart';

abstract class FetchLawyersState extends Equatable {
  const FetchLawyersState();

  @override
  List<Object> get props => [];
}

class FetchLawyersInitial extends FetchLawyersState {}

/// loading
class LoadingLawyers extends FetchLawyersState {}

/// loading more
class LoadingMoreLawyers extends FetchLawyersState {}

/// empty
class EmptyLawyers extends FetchLawyersState {}

/// unAuthorized
class UnAuthorizedToFetchLawyers extends FetchLawyersState {}

/// fetched
class LawyersFetched extends FetchLawyersState {
  final List<LawyerEntity> lawyersList;

  const LawyersFetched({required this.lawyersList});

  @override
  List<Object> get props => [lawyersList];
}

/// lastPage
class LastPageLawyersFetched extends FetchLawyersState {
  final List<LawyerEntity> lawyersList;

  const LastPageLawyersFetched({required this.lawyersList});

  @override
  List<Object> get props => [lawyersList];
}

/// error
class ErrorWhileLoadingLawyers extends FetchLawyersState {
  final AppError appError;

  const ErrorWhileLoadingLawyers({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileLoadingMoreLawyers extends FetchLawyersState {
  final AppError appError;

  const ErrorWhileLoadingMoreLawyers({required this.appError});

  @override
  List<Object> get props => [appError];
}
