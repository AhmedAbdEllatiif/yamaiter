import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_firebase_token_state.dart';

class StoreFirebaseTokenCubit extends Cubit<StoreFirebaseTokenState> {
  StoreFirebaseTokenCubit() : super(StoreFirebaseTokenInitial());
}
