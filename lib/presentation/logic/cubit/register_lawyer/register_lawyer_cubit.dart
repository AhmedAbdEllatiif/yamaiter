import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_lawyer_state.dart';

class RegisterLawyerCubit extends Cubit<RegisterLawyerState> {
  RegisterLawyerCubit() : super(RegisterLawyerInitial());
}
