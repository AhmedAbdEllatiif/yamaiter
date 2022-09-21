import 'package:yamaiter/domain/entities/data/user_entity.dart';

class LoginResponseEntity{

  final UserEntity userEntity;
  final String token;

  LoginResponseEntity({required this.userEntity, required this.token});
}