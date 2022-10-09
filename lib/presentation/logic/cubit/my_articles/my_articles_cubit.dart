import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/article/my_articles.dart';

part 'my_articles_state.dart';

class MyArticlesCubit extends Cubit<MyArticlesState> {
  MyArticlesCubit() : super(MyArticlesInitial());

  void fetchMyArticlesList({required String userToken}) async {
    //==> loading
    _emitIfNotClosed(LoadingMyArticlesList());

    //==> init case
    final useCase = getItInstance<GetMyArticlesCase>();

    //==> send request
    final either = await useCase(userToken);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (articleEntityList) {
        if (articleEntityList.isNotEmpty) {
          _emitIfNotClosed(
            MyArticlesListFetchedSuccessfully(
                articleEntityList: articleEntityList),
          );
        }
        // empty
        else{
          _emitIfNotClosed(EmptyMyArticlesList());
        }
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedGetMyArticlesList());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToGetMyArticlesList());
    } else {
      _emitIfNotClosed(ErrorWhileGettingMyArticlesList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(MyArticlesState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
