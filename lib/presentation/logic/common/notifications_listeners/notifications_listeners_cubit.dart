import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/params/no_params.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/use_cases/notifications_listeners/get_notifications_listener.dart';

import '../../../../common/enum/notifications_listeners.dart';
import '../../../../domain/use_cases/notifications_listeners/update_notificaitons_listener.dart';

part 'notifications_listeners_state.dart';

class NotificationsListenersCubit extends Cubit<NotificationsListenersState> {
  NotificationsListenersCubit()
      : super(
          NotificationsListenersInitial(),
        );

  /// try to update a value
  void tryUpdateTasksListeners(Map<String, bool> valueToUpdate) async {
    // init get case
    final getListenersCase = getItInstance<GetNotificationsListenersCase>();

    final either = await getListenersCase(NoParams());
    either.fold((appError) {
      _emitIfNotClosed(state);
      log("NotificationsListenersCubit >> error: $appError");
    }, (mapValue) {
      final keyToUpdate = valueToUpdate.keys.toList().first;

      // update the current value in the map
      if (mapValue.containsKey(keyToUpdate)) {
        mapValue[keyToUpdate] = valueToUpdate.values.toList().first;
        _update(mapValue);
      }

      // not in the map
      else {
        final newMapValue = mapValue;
        newMapValue.addAll(valueToUpdate);
        _update(newMapValue);
      }
    });
  }

  /// update
  void _update(Map<String, bool> value) async {
    // init update case
    final updateListenersCase =
        getItInstance<UpdateNotificationsListenersCase>();

    // update request
    final either = await updateListenersCase(value);

    either.fold((appError) {
      _emitIfNotClosed(state);
      log("NotificationsListenersCubit >> _update >>error: $appError");
    }, (_) {
      loadListeners();
    });
  }

  /// load
  void loadListeners() async {
    // init get case
    final getListenersCase = getItInstance<GetNotificationsListenersCase>();

    final either = await getListenersCase(NoParams());
    either.fold(
      (appError) {
        _emitIfNotClosed(state);
        log("NotificationsListenersCubit >> loadListeners >> error: $appError");
      },
      (mapValue) {
        if (mapValue.isEmpty) {
          _emitIfNotClosed(NotificationsListenersInitial());
        } else {
          _emitIfNotClosed(
              NotificationsListenersUpdated(newListeners: mapValue));
        }
      },
    );
  }

  /// emit if not close
  void _emitIfNotClosed(NotificationsListenersState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
