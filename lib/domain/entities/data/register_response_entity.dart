import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

class RegisterResponseEntity{

  final AuthorizedUserEntity userEntity;
  final String token;

  RegisterResponseEntity({required this.userEntity, required this.token});
}