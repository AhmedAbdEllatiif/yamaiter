import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/app_error.dart';

part 'create_task_client_state.dart';

class CreateTaskClientCubit extends Cubit<CreateTaskClientState> {
  CreateTaskClientCubit() : super(CreateTaskClientInitial());
}
