part of 'get_all_articles_cubit.dart';

abstract class GetAllArticlesState extends Equatable {
  const GetAllArticlesState();

  @override
  List<Object> get props => [];
}

/// initial
class GetAllArticlesInitial extends GetAllArticlesState {}

/// loading
class LoadingGetAllArticlesList extends GetAllArticlesState {}

/// loading more
class LoadingMoreAllArticlesList extends GetAllArticlesState {}

/// empty
class EmptyAllArticlesList extends GetAllArticlesState {}

/// unAuthorized
class UnAuthorizedGetAllArticlesList extends GetAllArticlesState {}

/// not a lawyer to get my Articles list
class NotActivatedUserToGetAllArticlesList extends GetAllArticlesState {}

/// success
class AllArticlesListFetchedSuccessfully extends GetAllArticlesState {
  final List<ArticleEntity> articlesList;

  const AllArticlesListFetchedSuccessfully({required this.articlesList});

  @override
  List<Object> get props => [articlesList];
}

/// last page fetched loaded
class LastPageAllArticlesReached extends GetAllArticlesState {
  final List<ArticleEntity> articlesList;

  const LastPageAllArticlesReached({
    required this.articlesList,
  });

  @override
  List<Object> get props => [articlesList];
}

/// error
class ErrorWhileGettingAllArticlesList extends GetAllArticlesState {
  final AppError appError;

  const ErrorWhileGettingAllArticlesList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error  while loading more
class ErrorWhileLoadingMoreAllArticles extends GetAllArticlesState {
  final AppError appError;

  const ErrorWhileLoadingMoreAllArticles({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
