import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/presentation/logic/cubit/user_token/user_token_cubit.dart';

String getUserToken(BuildContext context){
 return context.read<UserTokenCubit>().state.userToken;
}