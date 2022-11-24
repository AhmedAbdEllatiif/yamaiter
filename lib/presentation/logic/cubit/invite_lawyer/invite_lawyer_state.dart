part of 'invite_lawyer_cubit.dart';

abstract class InviteLawyerState extends Equatable {
  const InviteLawyerState();

  @override
  List<Object> get props => [];
}

/// initial
class InviteLawyerInitial extends InviteLawyerState {}

/// loading
class LoadingInviteLawyer extends InviteLawyerState {}

/// not a lawyer
class NotActivatedUserToInviteLawyer extends InviteLawyerState {}

/// unAuthorized
class UnAuthorizedInviteLawyer extends InviteLawyerState {}

/// task not found
class NoTaskFoundToInviteLawyer extends InviteLawyerState {}

/// success
class InviteLawyerSendSuccessfully extends InviteLawyerState {}

/// error
class ErrorWhileInvitingLawyer extends InviteLawyerState {
  final AppError appError;

  const ErrorWhileInvitingLawyer({required this.appError});

  @override
  List<Object> get props => [appError];
}
