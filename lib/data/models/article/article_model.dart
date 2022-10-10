import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/data/models/user_lawyer_model.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';

List<ArticleModel> myArticlesFromJson(String str) {
  final List<ArticleModel> articleModels = [];

  if (json.decode(str)["Articles"] != null) {
    json.decode(str)["Articles"].forEach((v) {
      articleModels.add(ArticleModel.fromJson(v));
    });
  }

  return articleModels.reversed.toList();
}

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str)["article"]);

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required this.articleId,
    required this.articleTitle,
    required this.articleAuthorName,
    required this.articleImageFeature,
    required this.articleDescription,
    required this.articleCreatedAt,
    required this.articleUpdatedAt,
    required this.articleArticlesImages,
    required this.articleUsers,
  }) : super(
            id: articleId,
            title: articleTitle,
            authorName: articleAuthorName,
            baseImage: articleImageFeature,
            description: articleDescription,
            articleImages: articleArticlesImages,
            createdDateAt: articleCreatedAt,
            updatedDateAt: articleUpdatedAt,
            lawyerModel: articleUsers);

  final int articleId;
  final String articleTitle;
  final String articleAuthorName;
  final String articleImageFeature;
  final String articleDescription;
  final DateTime? articleCreatedAt;
  final DateTime? articleUpdatedAt;
  final List<ArticlesImage> articleArticlesImages;
  final List<UserLawyerModel> articleUsers;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        articleId: json["id"] ?? -1,
        articleTitle: json["title"] ?? AppUtils.undefined,
        articleAuthorName: json["author_name"] ?? AppUtils.undefined,
        articleImageFeature: json["image_feature"] ?? AppUtils.undefined,
        articleDescription: json["description"] ?? AppUtils.undefined,

        // createdAt
        articleCreatedAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,

        // updatedAt
        articleUpdatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,

        // images
        articleArticlesImages: json["articles_images"] != null
            ? List<ArticlesImage>.from(
                json["articles_images"].map((x) => ArticlesImage.fromJson(x)))
            : [],

        // user
        articleUsers: json["users"] != null
            ? List<UserLawyerModel>.from(
                json["users"].map((x) => UserLawyerModel.fromJson(x)))
            : [],
      );
}

class ArticlesImage {
  ArticlesImage({
    required this.image,
  });

  final String image;

  factory ArticlesImage.fromJson(Map<String, dynamic> json) => ArticlesImage(
        image: json["image"] ?? AppUtils.undefined,
      );
}
