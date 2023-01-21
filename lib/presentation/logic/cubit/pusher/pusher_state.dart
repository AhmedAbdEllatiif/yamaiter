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


/// message received
class PusherNewMessageReceived extends PusherState {
  final types.Message message;

  const PusherNewMessageReceived(this.message);

  @override
  List<Object> get props => [message.id];
}



class ErrorWhileReceivingNewMessageState extends PusherState {}
