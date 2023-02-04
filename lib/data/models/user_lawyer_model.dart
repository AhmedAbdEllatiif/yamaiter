import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';

/// return a list of searched lawyers
List<UserLawyerModel> resultOfSearchForLawyer(String responseBody) {
  final List<UserLawyerModel> lawyers = [];

  if (json.decode(responseBody)["lawyers"] != null) {
    json.decode(responseBody)["lawyers"].forEach((v) {
      lawyers.add(UserLawyerModel.fromJson(v));
    });
  }
  return lawyers;
}

/// return a list of lawyers
List<UserLawyerModel> lawyersListFromJson(String responseBody) {
  final List<UserLawyerModel> lawyers = [];

  if (json.decode(responseBody)["lawyers"] != null) {
    json.decode(responseBody)["lawyers"].forEach((v) {
      lawyers.add(UserLawyerModel.fromJson(v));
    });
  }
  return lawyers;
}

class UserLawyerModel extends LawyerEntity {
  UserLawyerModel({
    required this.lawyerId,
    required this.lawyerRating,
    required this.lawyerTasksCount,
    required this.lawyerFirstName,
    required this.lawyerLastName,
    required this.lawyerEmail,
    required this.lawyerPhoneNum,
    required this.lawyerGovernorates,
    required this.lawyerCourtName,
    required this.lawyerIdPhoto,
    required this.lawyerDescription,
    required this.lawyerProfileImage,
    required this.lawyerStatus,
    required this.costByLawyer,
  }) : super(
          id: lawyerId,
          rating: lawyerRating,
          tasksCount: lawyerTasksCount,
          firstName: lawyerFirstName,
          lastName: lawyerLastName,
          email: lawyerEmail,
          phoneNum: lawyerPhoneNum,
          governorates: lawyerGovernorates,
          courtName: lawyerCourtName,
          description: lawyerDescription,
          status: lawyerStatus,
          lawyerIdPhoto: lawyerIdPhoto,
          lawyerProfileImage: lawyerProfileImage,
          costOfferedByLawyer: costByLawyer.toDouble(),
        );

  final int lawyerId;
  final int lawyerTasksCount;
  final String lawyerFirstName;
  final String lawyerLastName;
  final String lawyerEmail;
  final String lawyerPhoneNum;
  final num lawyerRating;
  final String lawyerGovernorates;
  final String lawyerCourtName;
  final String lawyerIdPhoto;
  final String lawyerDescription;
  final String lawyerProfileImage;
  final bool lawyerStatus;
  final num costByLawyer;

  factory UserLawyerModel.empty() => UserLawyerModel(
        lawyerId: -1,
        lawyerRating: 0,
        lawyerTasksCount: 0,
        lawyerFirstName: AppUtils.undefined,
        lawyerLastName: AppUtils.undefined,
        lawyerEmail: AppUtils.undefined,
        lawyerPhoneNum: AppUtils.undefined,
        lawyerGovernorates: AppUtils.undefined,
        lawyerCourtName: AppUtils.undefined,
        lawyerIdPhoto: AppUtils.undefined,
        lawyerDescription: AppUtils.undefined,
        lawyerProfileImage: AppUtils.undefined,
        costByLawyer: 0.0,
        lawyerStatus: false,
      );

  factory UserLawyerModel.fromJson(Map<String, dynamic> json) =>
      UserLawyerModel(
        lawyerId: json["id"] ?? -1,
        lawyerFirstName: json["first_name"] ?? AppUtils.undefined,
        lawyerLastName: json["last_name"] ?? AppUtils.undefined,
        lawyerEmail: json["email"] ?? AppUtils.undefined,
        lawyerPhoneNum: json['phone'] ?? AppUtils.undefined,
        //lawyerRating: json['rating'] ?? 0,
        lawyerTasksCount: json['tasks_count'] ?? 0,
        costByLawyer: json["pivot"] != null ? json["pivot"]["cost"] ?? 0 : 0,

        lawyerRating:
            json["userable"] != null ? json["userable"]["rate"] ?? 0 : 0,

        /// userable
        // governorates
        lawyerGovernorates: json["userable"] != null
            ? json["userable"]["governorates"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // courtName
        lawyerCourtName: json["userable"] != null
            ? json["userable"]["court_name"] ?? AppUtils.undefined
            : AppUtils.undefined,

        //idPhoto
        lawyerIdPhoto: json["userable"] != null
            ? json["userable"]["id_photo"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // description
        lawyerDescription: json["userable"] != null
            ? json["userable"]["description"] ?? "لا يوجد نبذة عن المحامى"
            : "لا يوجد نبذة عن المحامى",

        // profileImage
        lawyerProfileImage: json["userable"] != null
            ? json["userable"]["profile_image"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // status
        lawyerStatus: json["userable"] != null
            ? json["userable"]["status"] ?? false
            : false,
      );

/*"senderable": {
                    "id": 3,
                    "governorates": "cairo",
                    "court_name": "helwan court",
                    "id_photo": null,
                    "description": null,
                    "profile_image": null,
                    "rate": 0,
                    "tasks_count": 0,
                    "status": true,
                    "created_at": "2023-01-15T06:05:07.000000Z",
                    "updated_at": "2023-01-15T06:05:28.000000Z",
                    "user": {
                        "id": 3,
                        "first_name": "user2",
                        "last_name": "lastName",
                        "email": "user2@email.com",
                        "phone": "01227382688",
                        "accept_terms": 2,
                        "userable_type": "App\\Models\\Lawyer",
                        "userable_id": 3,
                        "device_token": null,
                        "created_at": "2023-01-15T06:05:08.000000Z",
                        "updated_at": "2023-01-15T18:46:09.000000Z",
                        "pusher_channel": "user2@email.com-3"
                    }
                }*/

  factory UserLawyerModel.fromJsonSenderable(Map<String, dynamic> json) =>
      UserLawyerModel(
        lawyerId: json["id"] ?? -1,

        // lawyerFirstName
        lawyerFirstName: json["user"] != null
            ? json["user"]["first_name"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // lawyerLastName
        lawyerLastName: json["user"] != null
            ? json["user"]["last_name"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // email
        lawyerEmail: json["user"] != null
            ? json["user"]["email"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // phone
        lawyerPhoneNum: json["user"] != null
            ? json["user"]['phone'] ?? AppUtils.undefined
            : AppUtils.undefined,

        // const of the task
        costByLawyer: 0,

        // tasks count
        lawyerTasksCount: json['tasks_count'] ?? 0,

        // rating
        lawyerRating: json["rate"] ?? 0,

        // governorates
        lawyerGovernorates: json["governorates"] ?? AppUtils.undefined,

        // courtName
        lawyerCourtName: json["court_name"] ?? AppUtils.undefined,

        //idPhoto
        lawyerIdPhoto: json["id_photo"] ?? AppUtils.undefined,

        // description
        lawyerDescription: json["description"] ?? "لا يوجد نبذة عن المحامى",

        // profileImage
        lawyerProfileImage: json["profile_image"] ?? AppUtils.undefined,

        // status
        lawyerStatus: json["status"] ?? false,
      );
}
