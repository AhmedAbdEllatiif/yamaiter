import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/get_single_article_params.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/domain/use_cases/get_single_article.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';

part 'get_single_article_state.dart';

class GetSingleArticleCubit extends Cubit<GetSingleArticleState> {
  GetSingleArticleCubit() : super(GetSingleArticleInitial());

  void fetchSingleArticle(
      {required String articleId, required String userToken}) async {
    //==> loading
    _emitIfNotClosed(LoadingSingleArticle());

    //==> init case
    final useCase = getItInstance<GetSingleArticleCase>();

    //==> init params
    final params =
        GetSingleArticleParams(articleId: articleId, userToken: userToken);

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (articleEntity) => _emitIfNotClosed(
              SingleArticleFetchedSuccessfully(articleEntity: articleEntity),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetSingleArticle());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetSingleArticle());
    } else {
      _emitIfNotClosed(ErrorWhileGettingSingleArticle(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetSingleArticleState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
