part of 'update_article_cubit.dart';

abstract class UpdateArticleState extends Equatable {
  const UpdateArticleState();

  @override
  List<Object?> get props => [];
}

/// initial
class UpdateArticleInitial extends UpdateArticleState {}

/// loading
class LoadingUpdateArticle extends UpdateArticleState {}

/// not activated
class NotActivatedUserToUpdateArticle extends UpdateArticleState {}

/// unAuthorized
class UnAuthorizedUpdateArticle extends UpdateArticleState {}

/// success
class ArticleUpdatedSuccessfully extends UpdateArticleState {}

/// error
class ErrorWhileUpdatingArticle extends UpdateArticleState {
  final AppError appError;

  const ErrorWhileUpdatingArticle({required this.appError});

  @override
  List<Object> get props => [appError];
}
