import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'end_task_client_state.dart';

class EndTaskClientCubit extends Cubit<EndTaskClientState> {
  EndTaskClientCubit() : super(EndTaskClientInitial());
}
