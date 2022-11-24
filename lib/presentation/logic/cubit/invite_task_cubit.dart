import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'invite_task_state.dart';

class InviteTaskCubit extends Cubit<InviteTaskState> {
  InviteTaskCubit() : super(InviteTaskInitial());
}
