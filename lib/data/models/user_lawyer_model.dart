import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';

class UserLawyerModel extends LawyerEntity {
  UserLawyerModel({
    required this.lawyerId,
    required this.lawyerRating,
    required this.lawyerTasksCount,
    required this.lawyerName,
    required this.lawyerEmail,
    required this.lawyerPhoneNum,
    required this.lawyerGovernorates,
    required this.lawyerCourtName,
    required this.lawyerIdPhoto,
    required this.lawyerDescription,
    required this.lawyerProfileImage,
    required this.lawyerStatus,
  }) : super(
          id: lawyerId,
          rating: lawyerRating,
          tasksCount: lawyerTasksCount,
          name: lawyerName,
          email: lawyerEmail,
          phoneNum: lawyerPhoneNum,
          governorates: lawyerGovernorates,
          courtName: lawyerCourtName,
          description: lawyerDescription,
          status: lawyerStatus,
          lawyerIdPhoto: lawyerIdPhoto,
          lawyerProfileImage: lawyerProfileImage,
        );

  final int lawyerId;
  final int lawyerTasksCount;
  final String lawyerName;
  final String lawyerEmail;
  final String lawyerPhoneNum;
  final int lawyerRating;
  final String lawyerGovernorates;
  final String lawyerCourtName;
  final String lawyerIdPhoto;
  final String lawyerDescription;
  final String lawyerProfileImage;
  final bool lawyerStatus;

  factory UserLawyerModel.empty() => UserLawyerModel(
        lawyerId: -1,
        lawyerRating: 0,
        lawyerTasksCount: 0,
        lawyerName: AppUtils.undefined,
        lawyerEmail: AppUtils.undefined,
        lawyerPhoneNum: AppUtils.undefined,
        lawyerGovernorates: AppUtils.undefined,
        lawyerCourtName: AppUtils.undefined,
        lawyerIdPhoto: AppUtils.undefined,
        lawyerDescription: AppUtils.undefined,
        lawyerProfileImage: AppUtils.undefined,
        lawyerStatus: false,
      );

  factory UserLawyerModel.fromJson(Map<String, dynamic> json) =>
      UserLawyerModel(
        lawyerId: json["id"] ?? -1,
        lawyerName: json["name"] ?? AppUtils.undefined,
        lawyerEmail: json["email"] ?? AppUtils.undefined,
        lawyerPhoneNum: json['phone'] ?? AppUtils.undefined,
        lawyerRating: json['rating'] ?? 0,
        lawyerTasksCount: json['tasks_count'] ?? 0,

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
            ? json["userable"]["description"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // profileImage
        lawyerProfileImage: json["userable"] != null
            ? json["userable"]["profile_image"] ?? AppUtils.undefined
            : AppUtils.undefined,

        // status
        lawyerStatus: json["userable"] != null
            ? json["userable"]["status"] ?? false
            : false,
      );
}
