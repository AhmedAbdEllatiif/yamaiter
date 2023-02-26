// To parse this JSON data, do
//
//     final taxModel = taxModelFromJson(jsonString);

import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/ad_status.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';

/// return a list of AdModel
List<AdModel> listOfAdsFromJson(String str) {
  final List<AdModel> adList = [];

  // decode str
  final myJson = json.decode(str);

  if (myJson == null) {
    throw Exception("AdModel >> listOfAdsFromJson >> json is null");
  }

  if (myJson["Announcement"] == null) {
    throw Exception("AdModel >> listOfAdsFromJson >> Announcement is null");
  }

  myJson["Announcement"].forEach((v) {
    adList.add(AdModel.fromJson(v));
  });

  return adList.reversed.toList();
}


/// return a list of from [announcements]
List<AdModel> listOfAdsFromAnnouncementsJson(String str) {
  final List<AdModel> adList = [];

  // decode str
  final myJson = json.decode(str);

  if (myJson == null) {
    throw Exception("AdModel >> listOfAdsFromJson >> json is null");
  }

  if (myJson["announcements"] == null) {
    throw Exception("AdModel >> listOfAdsFromJson >> announcements is null");
  }

  myJson["announcements"].forEach((v) {
    adList.add(AdModel.fromJson(v));
  });

  return adList.reversed.toList();
}



class AdModel extends AdEntity {
  AdModel({
    required this.adId,
    required this.adUrl,
    required this.adPlace,
    required this.adPeriod,
    required this.adPrice,
    required this.adImage,
    required this.adStatus,
    required this.createdDateAt,
    required this.updatedDateAt,
    required this.pivot,
  }) : super(
          id: adId,
          url: adUrl,
          adImage: adImage,
          price: adPrice.toDouble(),
          period: adPeriod,
          createdDateAt: createdDateAt,
          updatedDateAt: updatedDateAt,
          adPages: adPlace,
          status: adStatus == 0
              ? AdStatus.inprogress
              : adStatus == 1
                  ? AdStatus.published
                  : adStatus == 2
                      ? AdStatus.expired
                      : AdStatus.unKnown,
        );

  final int adId;
  final String adPlace;
  final String adUrl;
  final int adPeriod;
  final num adPrice;
  final String adImage;
  final int adStatus;
  final DateTime? createdDateAt;
  final DateTime? updatedDateAt;
  final Pivot pivot;

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
        adId: json["id"] ?? -1,
        adPlace: json["place"] ?? AppUtils.undefined,
        adUrl: json["url"] ?? AppUtils.undefined,
        adPeriod: json["period"] ?? 0,
        adPrice: json["price"] ?? 0.0,


        // adImage
        adImage: json["mob_image"] == null
            ? AppUtils.undefined
            : (json["mob_image"] as String).isEmpty
                ? AppUtils.undefined
                : json["mob_image"],


        adStatus: json["status"] ?? AppUtils.undefined,
        createdDateAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedDateAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        pivot: json["pivot"] != null
            ? Pivot.fromJson(json["pivot"])
            : Pivot.empty(),
      );
}

class Pivot {
  Pivot({
    required this.userId,
    required this.adId,
  });

  final int userId;
  final int adId;

  factory Pivot.empty() => Pivot(userId: -1, adId: -1);

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"] ?? -1,
        adId: json["announcement_id"] ?? -1,
      );
}
