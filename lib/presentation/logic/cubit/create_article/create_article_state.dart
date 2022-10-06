part of 'create_article_cubit.dart';

abstract class CreateArticleState extends Equatable {
  const CreateArticleState();
  @override
  List<Object> get props => [];
}

/// initial
class CreateArticleInitial extends CreateArticleState {}


/// loading
class LoadingCreateArticle extends CreateArticleState {}

/// not a lawyer to create article
class NotActivatedUserToCreateArticle extends CreateArticleState {}

/// unAuthorized
class UnAuthorizedCreateArticle extends CreateArticleState {}

/// success
class ArticleCreatedSuccessfully extends CreateArticleState {}

/// error
class ErrorWhileCreatingArticle extends CreateArticleState {
  final AppError appError;

  const ErrorWhileCreatingArticle({required this.appError});

  @override
  List<Object> get props => [appError];
}
