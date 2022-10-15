import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/data/models/article/article_model.dart';
import 'package:yamaiter/data/models/user_lawyer_model.dart';

import '../../../data/api/constants.dart';

class ArticleEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final List<ArticlesImage> articleImages;

  /// image string
  late final List<String> images;

  /// date
  late final String createdAt;
  late final String updatedAt;
  late final String imageFeature;

  /// user data
  final String authorName;
  late final int creatorRating;
  late final String creatorImage;

  ArticleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.authorName,
    required this.articleImages,
    required String baseImage,
    required DateTime? createdDateAt,
    required DateTime? updatedDateAt,
    required List<UserLawyerModel> lawyerModel,
  }) {
    if (lawyerModel.isEmpty) {
      creatorRating = 5;
      creatorImage = AppUtils.undefined;
    } else {
      creatorRating = lawyerModel[0].rating;
      creatorImage = ApiConstants.mediaUrl + lawyerModel[0].profileImage;
    }

    /// init imageFeature
    imageFeature = ApiConstants.mediaUrl + baseImage;

    /// init images
    images = [];
    for (var element in articleImages) {
      images.add(ApiConstants.mediaUrl + element.image);
    }

    /// init create at
    if (createdDateAt != null) {
      createdAt =
          "${createdDateAt.year.toString()}-${createdDateAt.month.toString().padLeft(2, '0')}-"
          "${createdDateAt.day.toString().padLeft(2, '0')} ";
    } else {
      createdAt = AppUtils.undefined;
    }

    /// init update at
    if (updatedDateAt != null) {
      updatedAt =
          "${updatedDateAt.year.toString()}-${updatedDateAt.month.toString().padLeft(2, '0')}-"
          "${updatedDateAt.day.toString().padLeft(2, '0')} ";
    } else {
      updatedAt = AppUtils.undefined;
    }
  }

  @override
  List<Object?> get props => [id];
}
