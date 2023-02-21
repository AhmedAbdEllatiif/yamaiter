import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_listeners_state.dart';

class NotificationsListenersCubit extends Cubit<NotificationsListenersState> {
  NotificationsListenersCubit() : super(NotificationsListenersInitial());
}
