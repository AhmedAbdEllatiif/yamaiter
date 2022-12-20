import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/accept_terms.dart';
import 'package:yamaiter/common/enum/user_type.dart';

import '../../../common/constants/app_utils.dart';

class AuthorizedUserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  final UserType userType;
  final AcceptTerms acceptTerms;

  const AuthorizedUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.userType,
    required this.acceptTerms,
  });

  factory AuthorizedUserEntity.empty() => const AuthorizedUserEntity(
      id: -1,
      firstName: AppUtils.undefined,
      lastName: AppUtils.undefined,
      email: AppUtils.undefined,
      phoneNum: "01*********",
      userType: UserType.unDefined,
      acceptTerms: AcceptTerms.unKnown);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNum,
        userType,
        acceptTerms,
      ];
}
