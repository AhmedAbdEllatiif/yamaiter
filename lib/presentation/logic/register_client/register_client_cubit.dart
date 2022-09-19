import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_client_state.dart';

class RegisterClientCubit extends Cubit<RegisterClientState> {
  RegisterClientCubit() : super(RegisterClientInitial());
}
