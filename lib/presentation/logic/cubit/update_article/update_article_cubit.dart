import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../data/models/article/create_article_request_model.dart';
import '../../../../data/params/create_article_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/article/update_article.dart';

part 'update_article_state.dart';

class UpdateArticleCubit extends Cubit<UpdateArticleState> {
  UpdateArticleCubit() : super(UpdateArticleInitial());

  /// to update article
  void updateArticle(
      {required String title,
      required String description,
      required List<String> imagePaths,
      required int articleId,
      required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingUpdateArticle());

    //==> init case
    final updateArticleCase = getItInstance<UpdateArticleCase>();

    //==> init params
    final params = CreateOrUpdateArticleParams(
      requestModel: CreateOrUpdateArticleRequestModel(
        title: title,
        description: description,
        imageList: imagePaths,
      ),
      token: token,
      articleId: articleId.toString(),
    );

    //==> send request
    final either = await updateArticleCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              ArticleUpdatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedUpdateArticle());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToUpdateArticle());
    } else {
      _emitIfNotClosed(ErrorWhileUpdatingArticle(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(UpdateArticleState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
