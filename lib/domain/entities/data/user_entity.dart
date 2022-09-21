import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/user_type.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phoneNum;
  final UserType userType;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.userType,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [id];
}
