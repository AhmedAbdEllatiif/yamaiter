import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit() : super(UpdateTaskInitial());
}
