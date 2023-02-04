import 'package:yamaiter/common/enum/accept_terms.dart';
import 'package:yamaiter/common/enum/user_type.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';

import '../../common/constants/app_utils.dart';

class AuthorizedUserModel extends AuthorizedUserEntity {
  final int userId;
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final String userPhone;

  final UserType userableType;
  final int userableId;
  final String profileImage;
  final String createdAt;
  final String updatedAt;
  final int userAcceptTerms;

  AuthorizedUserModel({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPhone,
    required this.profileImage,
    required this.userableType,
    required this.userableId,
    required this.createdAt,
    required this.updatedAt,
    required this.userAcceptTerms,
  }) : super(
          id: userId,
          firstName: userFirstName,
          lastName: userLastName,
          email: userEmail,
          phoneNum: userPhone,
          userType: userableType,
          profileImage: profileImage,
          acceptTerms: userAcceptTerms == 1
              ? AcceptTerms.firstAccept
              : userAcceptTerms == 2
                  ? AcceptTerms.secondAccept
                  : AcceptTerms.unKnown,
        );

  factory AuthorizedUserModel.fromJson(Map<String, dynamic> json) =>
      AuthorizedUserModel(
        //==> userId
        userId: json["id"] ?? -1,

        //==> userFirstName
        userFirstName: json["first_name"] ?? AppUtils.undefined,

        //==> userLastName
        userLastName: json["last_name"] ?? AppUtils.undefined,

        //==> userEmail
        userEmail: json["email"] ?? AppUtils.undefined,

        //==> userPhone
        userPhone: json['phone'] ?? AppUtils.undefined,

        //==> profileImage
        profileImage: json['userable'] != null
            ? json['userable']["profile_image"] ?? AppUtils.undefined
            : AppUtils.undefined,

        //==> userableType
        userableType: json['userable_type'] != null
            ? json['userable_type'].contains("Client")
                ? UserType.client
                : json['userable_type'].contains("Lawyer")
                    ? UserType.lawyer
                    : UserType.unDefined
            : UserType.unDefined,

        //==> userableId
        userableId: json['userable_id'] ?? -1,

        //==> createdAt
        createdAt: json['created_at'] ?? AppUtils.undefined,

        //==> updatedAt
        updatedAt: json['updated_at'] ?? AppUtils.undefined,

        //==> userAcceptTerms
        userAcceptTerms: json['accept_terms'] ?? -1,
      );
}

/// json model
/*
*
{
    "user": {
        "id": 23,
        "name": "ahmed",
        "email": "lawyer11@email.com",
        "phone": "01127382677",
        "userable_id": 20,
        "userable_type": "App\\Models\\Lawyer",
        "updated_at": "2022-11-28T08:49:25.000000Z",
        "created_at": "2022-11-28T08:49:25.000000Z",
        "accept_terms": 1
    },
    "token": "57|aHlrvCNoIKDhgdCzBJCbCv2rIBzVKMxitx7OUEUe",
    "token_type": "Bearer"
}*/
