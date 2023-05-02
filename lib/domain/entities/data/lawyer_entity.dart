import 'package:equatable/equatable.dart';

import '../../../data/api/api_constants.dart';

class LawyerEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  final num rating;
  final int tasksCount;
  final String governorates;
  final String courtName;
  final String description;
  final bool status;
  final double costOfferedByLawyer;
  late final String idPhoto;
  late final String profileImage;

  factory LawyerEntity.empty() {
    return LawyerEntity(
        id: -1,
        rating: 2,
        tasksCount: 5,
        firstName: "first name",
        lastName: "last name",
        email: "email",
        phoneNum: "phoneNum",
        governorates: "governorates",
        courtName: "courtName",
        description: "description",
        status: true,
        costOfferedByLawyer: 0.0,
        lawyerIdPhoto: "lawyerIdPhoto",
        lawyerProfileImage: "lawyerProfileImage");
  }

  LawyerEntity({
    required this.id,
    required this.rating,
    required this.tasksCount,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.governorates,
    required this.courtName,
    required this.description,
    required this.status,
    required this.costOfferedByLawyer,
    required String lawyerIdPhoto,
    required String lawyerProfileImage,
  }) {
    idPhoto = ApiConstants.mediaUrl + lawyerIdPhoto;
    profileImage = ApiConstants.mediaUrl + lawyerProfileImage;
  }

  @override
  List<Object?> get props => [id];
}
