part of 'pusher_cubit.dart';

abstract class PusherState extends Equatable {
  const PusherState();

  @override
  List<Object> get props => [];
}

class PusherInitial extends PusherState {}

class LoadingPusherConnection extends PusherState {}

/// PusherSubscriptionErrorOccurred
class PusherSubscriptionErrorOccurred extends PusherState {}

/// InitializationError
class PusherInitializationErrorOccurred extends PusherState {}

/// text message received
class PusherNewMessageReceived extends PusherState {
  final types.Message message;

  const PusherNewMessageReceived(this.message);

  @override
  List<Object> get props => [message.id];
}

/// file message received
class PusherNewFileMessageReceived extends PusherState {
  final types.FileMessage message;

  const PusherNewFileMessageReceived(this.message);

  @override
  List<Object> get props => [message.id];
}

/// image message received
class PusherNewImageMessageReceived extends PusherState {
  final types.FileMessage message;

  const PusherNewImageMessageReceived(this.message);

  @override
  List<Object> get props => [message.id];
}

class ErrorWhileReceivingNewMessageState extends PusherState {}
