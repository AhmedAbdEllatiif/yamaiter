part of 'get_single_article_cubit.dart';

abstract class GetSingleArticleState extends Equatable {
  const GetSingleArticleState();

  @override
  List<Object?> get props => [];
}

/// initial
class GetSingleArticleInitial extends GetSingleArticleState {}

/// loading
class LoadingSingleArticle extends GetSingleArticleState {}

/// unAuthorized
class UnAuthorizedGetSingleArticle extends GetSingleArticleState {}

/// not a lawyer
class NotActivatedUserToGetSingleArticle extends GetSingleArticleState {}

/// success
class SingleArticleFetchedSuccessfully extends GetSingleArticleState {
  final ArticleEntity articleEntity;

  const SingleArticleFetchedSuccessfully({required this.articleEntity});

  @override
  List<Object> get props => [articleEntity];
}

/// error
class ErrorWhileGettingSingleArticle extends GetSingleArticleState {
  final AppError appError;

  const ErrorWhileGettingSingleArticle({required this.appError});

  @override
  List<Object> get props => [appError];
}
