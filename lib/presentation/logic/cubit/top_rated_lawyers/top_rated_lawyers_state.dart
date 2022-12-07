part of 'top_rated_lawyers_cubit.dart';

abstract class TopRatedLawyersState extends Equatable {
  const TopRatedLawyersState();

  @override
  List<Object> get props => [];
}

class TopRatedLawyersInitial extends TopRatedLawyersState {}

/// loading
class LoadingTopRatedLawyers extends TopRatedLawyersState {}

/// empty
class EmptyTopRatedLawyers extends TopRatedLawyersState {}

/// unAuthorized
class UnAuthorizedTopRatedLawyers extends TopRatedLawyersState {}

/// fetched
class TopRatedLawyersFetched extends TopRatedLawyersState {
  final List<LawyerEntity> lawyerList;

  const TopRatedLawyersFetched({required this.lawyerList});

  @override
  List<Object> get props => [lawyerList];
}

/// error
class ErrorWhileLoadingTopRatedLawyers extends TopRatedLawyersState {
  final AppError appError;

  const ErrorWhileLoadingTopRatedLawyers({required this.appError});

  @override
  List<Object> get props => [appError];
}
