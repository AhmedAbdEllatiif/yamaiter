// To parse this JSON data, do
//
//     final taxModel = taxModelFromJson(jsonString);

import 'dart:convert';

import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/ad_entity.dart';

/// return a list of AdModel
List<AdModel> listOfAdsFromJson(String str) {
  final List<AdModel> adList = [];

  if (json.decode(str)["Announcement"] != null) {
    json.decode(str)["Announcement"].forEach((v) {
      adList.add(AdModel.fromJson(v));
    });
  } else {
    throw Exception("Announcement does not exists while extracting json");
  }

  return adList.reversed.toList();
}

/// return an AdModel
AdModel adModelFromJson(String str) => AdModel.fromJson(json.decode(str));

class AdModel extends AdEntity {
  AdModel({
    required this.adId,
    required this.adPlace,
    required this.adPeriod,
    required this.adPrice,
    required this.adImage,
    required this.createdDateAt,
    required this.updatedDateAt,
    required this.pivot,
  }) : super(
          id: adId,
          image: adImage,
          price: adPrice.toDouble(),
          period: adPeriod,
          createdDateAt: createdDateAt,
          updatedDateAt: updatedDateAt,
          pages: adPlace,
        );

  final int adId;
  final String adPlace;
  final int adPeriod;
  final num adPrice;
  final String adImage;
  final DateTime? createdDateAt;
  final DateTime? updatedDateAt;
  final Pivot pivot;

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
        adId: json["id"] ?? -1,
        adPlace: json["place"] ?? AppUtils.undefined,
        adPeriod: json["period"] ?? 0,
        adPrice: json["price"] ?? 0.0,
        adImage: json["image"] ?? AppUtils.undefined,
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
