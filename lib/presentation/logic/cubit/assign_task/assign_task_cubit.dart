import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assign_task_state.dart';

class AssignTaskCubit extends Cubit<AssignTaskState> {
  AssignTaskCubit() : super(AssignTaskInitial());
}
