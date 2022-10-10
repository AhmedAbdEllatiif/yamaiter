part of 'get_my_ads_cubit.dart';

abstract class GetMyAdsState extends Equatable {
  const GetMyAdsState();

  @override
  List<Object?> get props => [];
}

/// initial
class GetMyAdsInitial extends GetMyAdsState {}

/// loading
class LoadingGetMyAdsList extends GetMyAdsState {}

/// empty
class EmptyMyAdsList extends GetMyAdsState {}

/// unAuthorized
class UnAuthorizedGetMyAdsList extends GetMyAdsState {}

/// not a lawyer to get my Ads list
class NotActivatedUserToGetMyAdsList extends GetMyAdsState {}

/// success
class MyAdsListFetchedSuccessfully extends GetMyAdsState {
  final List<AdEntity> adsList;

  const MyAdsListFetchedSuccessfully({required this.adsList});

  @override
  List<Object> get props => [adsList];
}

/// error
class ErrorWhileGettingMyAdsList extends GetMyAdsState {
  final AppError appError;

  const ErrorWhileGettingMyAdsList({required this.appError});

  @override
  List<Object> get props => [appError];
}
