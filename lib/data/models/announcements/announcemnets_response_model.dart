import 'dart:convert';

import 'package:yamaiter/domain/entities/data/app_announcements_entity.dart';

import 'ad_model.dart';
import 'new_model.dart';

AnnouncementsResponseModel announcementsResponseModelFromJson(String str) {
  final List<AdModel> adList = [];
  final List<NewsModel> newsList = [];

  // decode str
  final myJson = json.decode(str);

  if (myJson == null) {
    throw Exception(
        "AnnouncementsResponseModel >> listOfAdsFromJson >> json is null");
  }

  if (myJson["announcements"] == null) {
    throw Exception(
        "AnnouncementsResponseModel >> listOfAdsFromJson >> announcements is null");
  }

  if (myJson["news"] == null) {
    throw Exception(
        "AnnouncementsResponseModel >> listOfAdsFromJson >> news is null");
  }

  //==>  build announcements
  myJson["announcements"].forEach((v) {
    adList.add(AdModel.fromJson(v));
  });

  //==> build news
  myJson["news"].forEach((v) {
    newsList.add(NewsModel.fromJson(v));
  });

  return AnnouncementsResponseModel(
    adsModel: adList,
    newsModel: newsList,
  );
}

class AnnouncementsResponseModel extends AppAnnouncementsEntity {
  final List<AdModel> adsModel;
  final List<NewsModel> newsModel;

  const AnnouncementsResponseModel({
    required this.adsModel,
    required this.newsModel,
  }) : super(
          ads: adsModel,
          news: newsModel,
        );
}
