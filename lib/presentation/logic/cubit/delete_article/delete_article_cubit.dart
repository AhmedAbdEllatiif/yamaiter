import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/delete_article_params.dart';
import 'package:yamaiter/domain/use_cases/article/delete_article.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'delete_article_state.dart';

class DeleteArticleCubit extends Cubit<DeleteArticleState> {
  DeleteArticleCubit() : super(const DeleteArticleInitial(-1));

  void cancelDelete() {
    _emitIfNotClosed(DeleteArticleInitial(state.articleId));
  }

  /// to delete article
  void deleteArticle({required int articleId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingDeleteArticle(articleId));

    //==> init case
    final deleteArticleCase = getItInstance<DeleteArticleCase>();

    //==> init params
    final params = DeleteArticleParams(id: articleId, userToken: token);

    //==> send request
    final either = await deleteArticleCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError, articleId: articleId),
        (success) => _emitIfNotClosed(
              ArticleDeletedSuccessfully(articleId),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError, {required int articleId}) {
    //==> unauthorizedUser
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedDeleteArticle(articleId));
    }
    //==> notActivatedUser
    else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToDeleteArticle(articleId));
    }
    //==> notFound
    else if (appError.appErrorType == AppErrorType.notFound) {
      _emitIfNotClosed(NotFoundDeleteArticle(articleId));
    }
    //==> other
    else {
      _emitIfNotClosed(ErrorWhileDeletingArticle(
        appError: appError,
        articleId: articleId,
      ));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(DeleteArticleState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
