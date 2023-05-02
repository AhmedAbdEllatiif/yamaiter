import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/accept_terms.dart';
import 'package:yamaiter/common/enum/user_type.dart';

import '../../../common/constants/app_utils.dart';
import '../../../data/api/api_constants.dart';

class AuthorizedUserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  final String governorates;
  final String courtName;
  final double rating;
  late final String userAvatar;
  final UserType userType;
  final AcceptTerms acceptTerms;

  AuthorizedUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.governorates,
    required this.courtName,
    required this.userType,
    required this.acceptTerms,
    required this.rating,
    required final String profileImage,
  }) {
    log("AuthorizedUserEntity >> profileImage >> $profileImage");
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
      governorates: AppUtils.undefined,
      courtName: AppUtils.undefined,
      phoneNum: "01*********",
      userType: UserType.unDefined,
      rating: 0,
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
        userAvatar,
        rating,
      ];
}
