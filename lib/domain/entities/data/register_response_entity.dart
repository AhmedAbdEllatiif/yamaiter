import 'package:yamaiter/domain/entities/data/user_entity.dart';

class RegisterResponseEntity{

  final UserEntity userEntity;
  final String token;

  RegisterResponseEntity({required this.userEntity, required this.token});
}