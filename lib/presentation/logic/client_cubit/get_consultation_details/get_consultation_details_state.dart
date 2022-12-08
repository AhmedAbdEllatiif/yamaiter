part of 'get_consultation_details_cubit.dart';

abstract class GetConsultationDetailsState extends Equatable {
  const GetConsultationDetailsState();

  @override
  List<Object?> get props => [];
}

/// initial
class GetConsultationDetailsInitial extends GetConsultationDetailsState {}

/// loading
class LoadingConsultationDetails extends GetConsultationDetailsState {}

/// unAuthorized
class UnAuthorizedGetConsultationDetails extends GetConsultationDetailsState {}

/// not a lawyer
class NotActivatedUserToGetConsultationDetails
    extends GetConsultationDetailsState {}

/// success
class ConsultationDetailsFetchedSuccessfully
    extends GetConsultationDetailsState {
  final ConsultationEntity consultationEntity;

  const ConsultationDetailsFetchedSuccessfully(
      {required this.consultationEntity});

  @override
  List<Object> get props => [consultationEntity];
}

/// error
class ErrorWhileGettingConsultationDetails extends GetConsultationDetailsState {
  final AppError appError;

  const ErrorWhileGettingConsultationDetails({required this.appError});

  @override
  List<Object> get props => [appError];
}
