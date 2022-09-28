part of 'side_menu_page_cubit.dart';

abstract class SideMenuPageState extends Equatable {
  const SideMenuPageState();

  @override
  List<Object?> get props => [];
}

/// initial
class SideMenuPageInitial extends SideMenuPageState {}

/// loading
class LoadingSideMenuPage extends SideMenuPageState {}

/// unAuthorized
class UnAuthorizedSideMenuPage extends SideMenuPageState {}

/// success
class SideMenuPageFetchedSuccess extends SideMenuPageState {
  final List<SideMenuPageEntity> sideMenuPages;

  const SideMenuPageFetchedSuccess({required this.sideMenuPages});

  @override
  List<Object> get props => [sideMenuPages];
}

/// error
class ErrorWhileGettingSideMenuPage extends SideMenuPageState {
  final AppError appError;

  const ErrorWhileGettingSideMenuPage({required this.appError});

  @override
  List<Object> get props => [appError];
}
