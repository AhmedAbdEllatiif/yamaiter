import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/accept_terms.dart';
import 'package:yamaiter/common/enum/user_type.dart';

import '../../../common/constants/app_utils.dart';

class AuthorizedUserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phoneNum;
  final UserType userType;
  final AcceptTerms acceptTerms;

  const AuthorizedUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.userType,
    required this.acceptTerms,
  });

  factory AuthorizedUserEntity.empty() =>  const AuthorizedUserEntity(
      id: -1,
      name: AppUtils.undefined,
      email: AppUtils.undefined,
      phoneNum: "01*********",
      userType: UserType.unDefined,
      acceptTerms: AcceptTerms.unKnown);

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNum,
        userType,
        acceptTerms,
      ];
}
