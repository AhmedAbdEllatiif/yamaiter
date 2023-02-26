import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/chat/fetch_chats_lists_params.dart';
import 'package:yamaiter/domain/entities/chat/received_chat_list_entity.dart';
import 'package:yamaiter/domain/use_cases/chat/fetch_chat_list.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/app_error.dart';

part 'fetch_chat_list_state.dart';

class FetchChatListCubit extends Cubit<FetchChatListState> {
  FetchChatListCubit() : super(FetchChatListInitial());

  void fetchChatList({
    required String userToken,
    // required int currentListLength,
    // int offset = 0,
  }) async {
    //==> loading
    _emitIfNotClosed(LoadingChatsList());

    //==> init params
    final params = FetchChatsListParams(
      userToken: userToken,
    );

    //==> init case
    final useCase = getItInstance<FetchChatListCase>();

    //==> send request
    final either = await useCase(params);

    //==> receive result
    either.fold(
      (appError) => _emitError(appError),
      (receivedChatListEntity) {
        receivedChatListEntity.isEmpty
            ? _emitIfNotClosed(EmptyChatsList())
            : _emitIfNotClosed(
                ChatsListFetched(
                  receivedChatListEntity: receivedChatListEntity,
                ),
              );
      },
    );
  }

  /// to emit the result of success fetching the required Articles
  /// * param [offset] is the current offset to fetch
  /// * if the offset > 0 and the length is zero,
  /// this means last page reached
  // FetchChatListState _statusToEmit(
  //     {required List<LawyerEntity> lawyersList, required int offset}) {
  //   //==> last page reached
  //   if (offset > 0 && lawyersList.isEmpty) {
  //     return LastPageLawyersFetched(lawyersList: lawyersList);
  //   }
  //   //==> empty list
  //   else if (lawyersList.isEmpty) {
  //     return EmptyLawyers();
  //   }
  //   //==>  less than the limit
  //   else if (lawyersList.length < 10) {
  //     return LastPageLawyersFetched(lawyersList: lawyersList);
  //   }
  //
  //   //==> fetched
  //   else {
  //     return LawyersFetched(lawyersList: lawyersList);
  //   }
  // }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unauthorizedUser) {
      _emitIfNotClosed(UnAuthorizedToFetchChatsList());
    } else {
      _emitIfNotClosed(ErrorWhileLoadingChatsList(appError: appError));
    }
  }

  /// emit if not close
  void _emitIfNotClosed(FetchChatListState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
