import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

class LoginResponseEntity{

  final AuthorizedUserEntity userEntity;
  final String token;

  LoginResponseEntity({required this.userEntity, required this.token});
}