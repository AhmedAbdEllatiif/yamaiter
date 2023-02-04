import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/accept_terms.dart';
import 'package:yamaiter/common/enum/user_type.dart';

import '../../../common/constants/app_utils.dart';
import '../../../data/api/constants.dart';

class AuthorizedUserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  late final String userAvatar;
  final UserType userType;
  final AcceptTerms acceptTerms;

  AuthorizedUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.userType,
    required this.acceptTerms,
    required final String profileImage,
  }) {
    userAvatar = profileImage.startsWith("http")
        ? profileImage
        : ApiConstants.mediaUrl + profileImage;
  }

  factory AuthorizedUserEntity.empty() => AuthorizedUserEntity(
      id: -1,
      firstName: AppUtils.undefined,
      lastName: AppUtils.undefined,
      email: AppUtils.undefined,
      profileImage: AppUtils.undefined,
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
