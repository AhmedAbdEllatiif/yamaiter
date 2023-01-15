import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:yamaiter/data/params/chat_room_by_id_params.dart';
import 'package:yamaiter/domain/use_cases/chat/get_chat_room_by_id.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';

part 'chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(ChatRoomInitial());

  /// to fetchChatRoomMessages
  void fetchChatRoomMessages(
      {required int chatId, required String token}) async {
    //==> loading
    _emitIfNotClosed(LoadingChatRoomMessages());

    //==> init case
    final useCase = getItInstance<GetChatRoomByIdCase>();

    //==> init params
    final params = ChatRoomByIdParams(
      chatId: chatId,
      userToken: token,
    );

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold((appError) => _emitError(appError), (messages) {
      _emitIfNotClosed(
        ChatRoomMessageFetched(messages: messages),
      );
    });
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToFetchChatRoomMessages());
    } else {
      _emitIfNotClosed(ErrorWhileFetchingChatRoomMessages(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(ChatRoomState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
