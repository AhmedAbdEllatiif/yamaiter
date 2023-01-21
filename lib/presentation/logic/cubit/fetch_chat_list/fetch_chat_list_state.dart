part of 'fetch_chat_list_cubit.dart';

abstract class FetchChatListState extends Equatable {
  const FetchChatListState();
  @override
  List<Object> get props => [];
}

/// initial
class FetchChatListInitial extends FetchChatListState {}

/// loading
class LoadingChatsList extends FetchChatListState {}

/// loading more
class LoadingMoreChatsList extends FetchChatListState {}

/// empty
class EmptyChatsList extends FetchChatListState {}

/// unAuthorized
class UnAuthorizedToFetchChatsList extends FetchChatListState {}

/// fetched
class ChatsListFetched extends FetchChatListState {
  final List<ReceivedChatListEntity> receivedChatListEntity;

  const ChatsListFetched({required this.receivedChatListEntity});

  @override
  List<Object> get props => [ChatsListFetched];
}

/// lastPage
class LastPageChatsListFetched extends FetchChatListState {
  final List<ReceivedChatListEntity> receivedChatListEntity;

  const LastPageChatsListFetched({required this.receivedChatListEntity});

  @override
  List<Object> get props => [receivedChatListEntity];
}

/// error
class ErrorWhileLoadingChatsList extends FetchChatListState {
  final AppError appError;

  const ErrorWhileLoadingChatsList({required this.appError});

  @override
  List<Object> get props => [appError];
}

/// error loading more
class ErrorWhileLoadingMoreChatsList extends FetchChatListState {
  final AppError appError;

  const ErrorWhileLoadingMoreChatsList({required this.appError});

  @override
  List<Object> get props => [appError];
}
