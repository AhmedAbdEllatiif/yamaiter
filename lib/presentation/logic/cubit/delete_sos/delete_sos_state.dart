part of 'delete_sos_cubit.dart';

abstract class DeleteSosState extends Equatable {
  final int sosId;

  const DeleteSosState(this.sosId);
  @override
  List<Object> get props => [];
}

/// initial
class DeleteSosInitial extends DeleteSosState {
  const DeleteSosInitial(super.sosId);
}

/// loading
class LoadingDeleteSos extends DeleteSosState {
  const LoadingDeleteSos(super.sosId);
}

/// unAuthorized
class UnAuthorizedDeleteSos extends DeleteSosState {
  const UnAuthorizedDeleteSos(super.sosId);
}

/// not activated
class NotActivatedUserToDeleteSos extends DeleteSosState {
  const NotActivatedUserToDeleteSos(super.sosId);
}

/// notFound
class NotFoundDeleteSos extends DeleteSosState {
  const NotFoundDeleteSos(super.sosId);
}

/// success
class SosDeletedSuccessfully extends DeleteSosState {
  const SosDeletedSuccessfully(super.sosId);
}

/// error
class ErrorWhileDeletingSos extends DeleteSosState {
  final AppError appError;

  const ErrorWhileDeletingSos(
      {required this.appError, required int sosId})
      : super(sosId);

  @override
  List<Object> get props => [appError];
}