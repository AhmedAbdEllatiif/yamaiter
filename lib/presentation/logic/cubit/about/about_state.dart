part of 'about_cubit.dart';

abstract class AboutState extends Equatable {
  const AboutState();
  @override
  List<Object?> get props => [];
}


/// initial
class AboutInitial extends AboutState {}

/// loading
class LoadingAbout extends AboutState {}

/// unAuthorized
class UnAuthorizedAbout extends AboutState {}

/// success
class AboutFetchedSuccess extends AboutState {
  final List<AboutEntity> aboutList;

  const AboutFetchedSuccess({required this.aboutList});

  @override
  List<Object> get props => [aboutList];
}

/// error
class ErrorWhileGettingAbout extends AboutState {
  final AppError appError;

  const ErrorWhileGettingAbout({required this.appError});

  @override
  List<Object> get props => [appError];
}
