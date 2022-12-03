import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assign_task_client_state.dart';

class AssignTaskClientCubit extends Cubit<AssignTaskClientState> {
  AssignTaskClientCubit() : super(AssignTaskClientInitial());
}
