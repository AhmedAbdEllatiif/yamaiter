import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/user_type.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';

AuthorizedUserEntity getAuthorizedUserEntity(BuildContext context) {
  return context.read<AuthorizedUserCubit>().state.userEntity;
}

bool isCurrentUserLawyer(BuildContext context) {
  final userType = getAuthorizedUserEntity(context).userType;
  return userType == UserType.lawyer;
}
