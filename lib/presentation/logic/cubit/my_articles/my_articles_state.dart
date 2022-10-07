part of 'my_articles_cubit.dart';

abstract class MyArticlesState extends Equatable {
  const MyArticlesState();

  @override
  List<Object> get props => [];
}

class MyArticlesInitial extends MyArticlesState {}

/// loading
class LoadingMyArticlesList extends MyArticlesState {}

/// empty
class EmptyMyArticlesList extends MyArticlesState {}

/// unAuthorized
class UnAuthorizedGetMyArticlesList extends MyArticlesState {}

/// not activated
class NotActivatedUserToGetMyArticlesList extends MyArticlesState {}

/// success
class MyArticlesListFetchedSuccessfully extends MyArticlesState {
  final List<ArticleEntity> articleEntityList;

  const MyArticlesListFetchedSuccessfully({required this.articleEntityList});

  @override
  List<Object> get props => [articleEntityList];
}

/// error
class ErrorWhileGettingMyArticlesList extends MyArticlesState {
  final AppError appError;

  const ErrorWhileGettingMyArticlesList({required this.appError});

  @override
  List<Object> get props => [appError];
}
