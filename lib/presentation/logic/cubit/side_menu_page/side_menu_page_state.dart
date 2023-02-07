part of 'side_menu_page_cubit.dart';

abstract class AboutUsPageState extends Equatable {
  const AboutUsPageState();

  @override
  List<Object?> get props => [];
}

/// initial
class SideMenuPageInitial extends AboutUsPageState {}

/// loading
class LoadingAboutUsPage extends AboutUsPageState {}

/// unAuthorized
class UnAuthorizedToFetchAboutUsPage extends AboutUsPageState {}

/// success
class AboutUsPageFetchedSuccess extends AboutUsPageState {
  final SideMenuPageEntity sideMenuPages;

  const AboutUsPageFetchedSuccess({required this.sideMenuPages});

  @override
  List<Object> get props => [sideMenuPages];
}

/// error
class ErrorWhileGettingAboutUsPage extends AboutUsPageState {
  final AppError appError;

  const ErrorWhileGettingAboutUsPage({required this.appError});

  @override
  List<Object> get props => [appError];
}
