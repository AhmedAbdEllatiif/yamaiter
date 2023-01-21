part of 'send_chat_message_cubit.dart';

abstract class SendChatMessageState extends Equatable {
  const SendChatMessageState();

  @override
  List<Object> get props => [];
}

/// initial
class SendChatMessageInitial extends SendChatMessageState {}

/// loading
class LoadingSendChatMessage extends SendChatMessageState {}

/// unAuthorized
class UnAuthorizedToSendChatMessage extends SendChatMessageState {}

/// success
class MessageSentSuccessfully extends SendChatMessageState {}

/// error
class ErrorWhileSendingChatMessage extends SendChatMessageState {
  final AppError appError;

  const ErrorWhileSendingChatMessage({required this.appError});

  @override
  List<Object> get props => [appError];
}
