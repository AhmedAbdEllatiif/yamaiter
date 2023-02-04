import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/models/article/create_article_request_model.dart';
import 'package:yamaiter/data/params/create_article_params.dart';
import 'package:yamaiter/domain/use_cases/article/create_article.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';

part 'create_article_state.dart';

class CreateArticleCubit extends Cubit<CreateArticleState> {
  CreateArticleCubit() : super(CreateArticleInitial());

  /// to article sos
  void sendArticle(
      {required String title,
      required String description,
      required List<String> imagePaths,
      required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingCreateArticle());

    //==> init case
    final createArticleCase = getItInstance<CreateArticleCase>();

    //==> init params
    final params = CreateOrUpdateArticleParams(
      requestModel: CreateOrUpdateArticleRequestModel(
        title: title,
        description: description,
        imageList: imagePaths,
      ),
      token: token,
    );

    //==> send request
    final either = await createArticleCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (success) => _emitIfNotClosed(
              ArticleCreatedSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedCreateArticle());
    } else if (appError.appErrorType == AppErrorType.notActivatedUser) {
      _emitIfNotClosed(NotActivatedUserToCreateArticle());
    } else {
      _emitIfNotClosed(ErrorWhileCreatingArticle(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(CreateArticleState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
