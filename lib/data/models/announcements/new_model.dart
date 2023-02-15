import 'package:yamaiter/common/constants/app_utils.dart';

import '../../../domain/entities/data/news_entity.dart';

class NewsModel extends NewsEntity {
  final int newsId;
  final String newsContent;
  final String userType;
  final String createdAt;
  final String updatedAt;

  const NewsModel({
    required this.newsId,
    required this.newsContent,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          id: newsId,
          content: newsContent,
        );

  factory NewsModel.fromJson(dynamic json) {
    return NewsModel(
      newsId: json["id"] ?? -1,
      newsContent: json["news"] ?? AppUtils.undefined,
      userType: json["usertype"] ?? AppUtils.undefined,
      createdAt: json["created_at"] ?? AppUtils.undefined,
      updatedAt: json["updated_at"] ?? AppUtils.undefined,
    );
  }
}
