part of 'delete_article_cubit.dart';

abstract class DeleteArticleState extends Equatable {
  final int articleId;

  const DeleteArticleState(this.articleId);

  @override
  List<Object> get props => [];
}

/// initial
class DeleteArticleInitial extends DeleteArticleState {
  const DeleteArticleInitial(super.articleId);
}

/// loading
class LoadingDeleteArticle extends DeleteArticleState {
  const LoadingDeleteArticle(super.articleId);
}

/// unAuthorized
class UnAuthorizedDeleteArticle extends DeleteArticleState {
  const UnAuthorizedDeleteArticle(super.articleId);
}

/// not activated
class NotActivatedUserToDeleteArticle extends DeleteArticleState {
  const NotActivatedUserToDeleteArticle(super.articleId);
}

/// notFound
class NotFoundDeleteArticle extends DeleteArticleState {
  const NotFoundDeleteArticle(super.articleId);
}

/// success
class ArticleDeletedSuccessfully extends DeleteArticleState {
  const ArticleDeletedSuccessfully(super.articleId);
}

/// error
class ErrorWhileDeletingArticle extends DeleteArticleState {
  final AppError appError;

  const ErrorWhileDeletingArticle(
      {required this.appError, required int articleId})
      : super(articleId);

  @override
  List<Object> get props => [appError];
}
