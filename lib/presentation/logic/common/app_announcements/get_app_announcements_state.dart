part of 'get_app_announcements_cubit.dart';

abstract class GetAppAnnouncementsState extends Equatable {
  const GetAppAnnouncementsState();

  @override
  List<Object> get props => [];
}

/// initial
class GetAppAnnouncementsInitial extends GetAppAnnouncementsState {}

/// loading
class LoadingGetAppAnnouncements extends GetAppAnnouncementsState {}

/// unAuthorized
class UnAuthorizedGetAppAnnouncements extends GetAppAnnouncementsState {}

/// success
class AppAnnouncementsFetchedSuccessfully extends GetAppAnnouncementsState {
  final List<AdEntity> adsList;
  final String newsAsString;

  const AppAnnouncementsFetchedSuccessfully({
    required this.adsList,
    required this.newsAsString,
  });

  @override
  List<Object> get props => [adsList, newsAsString];
}

/// error
class ErrorWhileFetchingAppAnnouncements extends GetAppAnnouncementsState {
  final AppError appError;

  const ErrorWhileFetchingAppAnnouncements({required this.appError});

  @override
  List<Object> get props => [appError];
}
