part of 'get_help_cubit.dart';

abstract class GetHelpState extends Equatable {
  const GetHelpState();

  @override
  List<Object?> get props => [];
}

/// initial
class GetHelpInitial extends GetHelpState {}

/// loading
class LoadingGetHelp extends GetHelpState {}

/// empty
class EmptyHelp extends GetHelpState {}

/// unAuthorized
class UnAuthorizedGetHelp extends GetHelpState {}

/// success
class HelpFetchedSuccess extends GetHelpState {
  final List<HelpQuestionEntity> questionsEntities;

  const HelpFetchedSuccess({required this.questionsEntities});

  @override
  List<Object> get props => [questionsEntities];
}

/// error
class ErrorWhileGettingHelp extends GetHelpState {
  final AppError appError;

  const ErrorWhileGettingHelp({required this.appError});

  @override
  List<Object> get props => [appError];
}
