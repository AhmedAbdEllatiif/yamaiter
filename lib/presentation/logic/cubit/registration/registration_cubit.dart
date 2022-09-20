import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());
}
