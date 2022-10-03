import 'package:yamaiter/common/constants/app_utils.dart';

import 'package:yamaiter/common/constants/app_utils.dart';

import 'package:yamaiter/common/constants/app_utils.dart';

class UserLawyerModel {
  UserLawyerModel({
    required this.id,
    required this.rating,
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.governorates,
    required this.courtName,
    required this.idPhoto,
    required this.description,
    required this.profileImage,
    required this.status,
  });

  final int id;
  final String name;
  final String email;
  final String phoneNum;
  final int rating;
  final String governorates;
  final String courtName;
  final String idPhoto;
  final String description;
  final String profileImage;
  final bool status;

  factory UserLawyerModel.empty() =>
      UserLawyerModel(id: -1,
          rating: -1,
          name: AppUtils.undefined,
          email: AppUtils.undefined,
          phoneNum: AppUtils.undefined,
          governorates: AppUtils.undefined,
          courtName: AppUtils.undefined,
          idPhoto: AppUtils.undefined,
          description: AppUtils.undefined,
          profileImage: AppUtils.undefined,
          status: false);

  factory UserLawyerModel.fromJson(Map<String, dynamic> json) =>
      UserLawyerModel(
        id: json["id"] ?? -1,
        name: json["name"] ?? AppUtils.undefined,
        email: json["email"] ?? AppUtils.undefined,
        phoneNum: json['phone'] ?? AppUtils.undefined,
        rating: json['rating'] ?? -1,
        governorates: json["userable"]["governorates"] ?? AppUtils.undefined,
        courtName: json["userable"]["court_name"] ?? AppUtils.undefined,
        idPhoto: json["userable"]["id_photo"] ?? AppUtils.undefined,
        description: json["userable"]["description"] ?? AppUtils.undefined,
        profileImage: json["userable"]["profile_image"] ?? AppUtils.undefined,
        status: json["userable"]["status"] ?? AppUtils.undefined,
      );
}
