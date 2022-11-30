part of 'get_my_consultations_cubit.dart';

abstract class GetMyConsultationsState extends Equatable {
  const GetMyConsultationsState();

  @override
  List<Object> get props => [];
}

/// initial
class GetMyConsultationsInitial extends GetMyConsultationsState {}

/// loading
class LoadingGetMyConsultationsList extends GetMyConsultationsState {}

/// loading more
class LoadingMoreMyConsultationsList extends GetMyConsultationsState {}

/// empty
class EmptyMyConsultationsList extends GetMyConsultationsState {}

/// unAuthorized
class UnAuthorizedGetMyConsultationsList extends GetMyConsultationsState {}

/// not a lawyer
class NotActivatedUserToGetMyConsultationsList extends GetMyConsultationsState {
}

/// lastPage fetched
class LastPageMyConsultationsListFetched extends GetMyConsultationsState {
  final List<ConsultationEntity> consultationsList;

  const LastPageMyConsultationsListFetched({required this.consultationsList});

  @override
  List<Object> get props => [consultationsList];
}

/// success
class MyConsultationsListFetchedSuccessfully extends GetMyConsultationsState {
  final List<ConsultationEntity> consultationsList;

  const MyConsultationsListFetchedSuccessfully(
      {required this.consultationsList});

  @override
  List<Object> get props => [consultationsList];
}

/// error
class ErrorWhileGettingMyConsultationsList extends GetMyConsultationsState {
  final AppError appError;

  const ErrorWhileGettingMyConsultationsList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileGettingMoreMyConsultationsList extends GetMyConsultationsState {
  final AppError appError;

  const ErrorWhileGettingMoreMyConsultationsList({required this.appError});

  @override
  List<Object> get props => [appError];
}
