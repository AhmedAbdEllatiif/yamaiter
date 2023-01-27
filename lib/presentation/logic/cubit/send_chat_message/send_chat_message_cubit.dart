import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/chat/send_chat_message.dart';
import 'package:yamaiter/domain/use_cases/chat/send_chat_message_case.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'send_chat_message_state.dart';

class SendChatMessageCubit extends Cubit<SendChatMessageState> {
  SendChatMessageCubit() : super(SendChatMessageInitial());

  void sendTextMessage({
    required int chatId,
    required String userToken,
    required String chatMessage,
    required String filePath,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingSendChatMessage());

    //==> init case
    final useCase = getItInstance<SendChatMessageCase>();

    //==> init params
    final params = SendChatMessageParams(
      userToken: userToken,
      chatId: chatId,
      content: chatMessage,
      filePath: filePath,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
        (appError) => _emitError(appError),
        (_) => _emitIfNotClosed(
              MessageSentSuccessfully(),
            ));
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToSendChatMessage());
    } else {
      _emitIfNotClosed(ErrorWhileSendingChatMessage(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(SendChatMessageState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
