part of 'notifications_listeners_cubit.dart';

abstract class NotificationsListenersState extends Equatable {
  final Map<String, bool> listeners;

  const NotificationsListenersState({required this.listeners});

  @override
  List<Object?> get props => [listeners];
}

class NotificationsListenersInitial extends NotificationsListenersState {
  NotificationsListenersInitial()
      : super(listeners: {
          NotificationsListeners.tasks.name: true,
          NotificationsListeners.sos.name: true,
          NotificationsListeners.articles.name: true,
        });
}

class NotificationsListenersUpdated extends NotificationsListenersState {
  final Map<String, bool> newListeners;

  const NotificationsListenersUpdated({required this.newListeners})
      : super(listeners: newListeners);

  @override
  List<Object?> get props => [newListeners];
}
