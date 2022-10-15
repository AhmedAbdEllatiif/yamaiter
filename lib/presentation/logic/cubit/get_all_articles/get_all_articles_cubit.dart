import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/use_cases/article/get_all_articles.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/params/all_articles_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/data/article_entity.dart';

part 'get_all_articles_state.dart';

class GetAllArticlesCubit extends Cubit<GetAllArticlesState> {
  GetAllArticlesCubit() : super(GetAllArticlesInitial());

  /// to fetch all articles list
  void fetchAllArticlesList({
    required String userToken,
    required int currentListLength,
    int offset = 0,
  }) async {
    //==> loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingGetAllArticlesList());
    } else {
      _emitIfNotClosed(LoadingMoreAllArticlesList());
    }

    //==> init params
    final params = GetArticlesParams(userToken: userToken, offset: offset);

    //==> init case
    final useCase = getItInstance<GetAllArticlesCase>();

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (articlesList) => {
        _emitIfNotClosed(
          _statusToEmit(articlesList: articlesList, offset: offset),
        )
      },
    );
  }

  /// to emit the result of success fetching the required Articles
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  GetAllArticlesState _statusToEmit(
      {required List<ArticleEntity> articlesList, required int offset}) {
    //==> last page reached
    if (offset > 0 && articlesList.isEmpty) {
      return LastPageAllArticlesReached(articlesList: articlesList);
    }
    //==> empty list
    else if (articlesList.isEmpty) {
      return EmptyAllArticlesList();
    }
    //==>  less than the limit
    else if (articlesList.length < 10) {
      return LastPageAllArticlesReached(articlesList: articlesList);
    }

    //==> projects fetched
    else {
      return AllArticlesListFetchedSuccessfully(articlesList: articlesList);
    }
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetAllArticlesList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetAllArticlesList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingAllArticlesList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(GetAllArticlesState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
