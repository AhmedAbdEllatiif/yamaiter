part of 'chat_room_cubit.dart';


abstract class ChatRoomState extends Equatable {
  const ChatRoomState();

  @override
  List<Object> get props => [];
}

/// initial
class ChatRoomInitial extends ChatRoomState {}

/// loading
class LoadingChatRoomMessages extends ChatRoomState {}

/// unAuthorized
class UnAuthorizedToFetchChatRoomMessages extends ChatRoomState {}

/// success
class ChatRoomMessageFetched extends ChatRoomState {
  final List<types.Message> messages;

  const ChatRoomMessageFetched({required this.messages});

  @override
  List<Object> get props => [messages];
}

/// error
class ErrorWhileFetchingChatRoomMessages extends ChatRoomState {
  final AppError appError;

  const ErrorWhileFetchingChatRoomMessages({required this.appError});

  @override
  List<Object> get props => [appError];
}
