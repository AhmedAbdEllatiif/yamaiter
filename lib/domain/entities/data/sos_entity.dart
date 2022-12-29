import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/data/api/constants.dart';
import 'package:yamaiter/data/models/user_lawyer_model.dart';

class SosEntity extends Equatable {
  final int id;
  final String title;
  final String governorate;
  final String description;
  late final String creatorName;
  late final String creatorPhoneNum;
  late final num creatorRating;
  late final String creatorImage;
  final DateTime? createdAt;
  late final String createdAtString;

  SosEntity({
    required this.id,
    required this.title,
    required this.governorate,
    required this.description,
    required this.createdAt,
    required UserLawyerModel lawyerModel,
  }) {
    creatorName = lawyerModel.lawyerFirstName;
    creatorPhoneNum = lawyerModel.lawyerPhoneNum;
    creatorRating = lawyerModel.lawyerRating;
    creatorImage = ApiConstants.mediaUrl + lawyerModel.lawyerProfileImage;

    if (createdAt != null) {
      createdAtString =
          "${createdAt!.year.toString()}-${createdAt!.month.toString().padLeft(2, '0')}-"
              "${createdAt!.day.toString().padLeft(2, '0')} "
              " ${createdAt!.hour.toString().padLeft(2, '0')}:"
              "${createdAt!.minute.toString().padLeft(2, '0')}";
    } else {
      createdAtString = AppUtils.undefined;
    }
  }

  @override
  List<Object?> get props => [id];
}
