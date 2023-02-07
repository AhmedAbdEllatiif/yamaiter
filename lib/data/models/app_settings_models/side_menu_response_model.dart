import 'dart:convert';
import 'package:yamaiter/domain/entities/data/side_menu_page_entity.dart';

SideMenuPageResponseModel sideMenuPageModelFromJson(String body) {
  final json = jsonDecode(body);

  if (json == null) {
    throw Exception("SideMenuPageResponseModel >>"
        " sideMenuPageModelFromJson >> json is null");
  }

  if (json["data"] == null) {
    throw Exception("SideMenuPageResponseModel >>"
        " sideMenuPageModelFromJson >> data is null");
  }

  return SideMenuPageResponseModel.fromJson(json);
}

/// TermsAndConditionResponseModel
class SideMenuPageResponseModel extends SideMenuPageEntity {
  const SideMenuPageResponseModel({
    required this.aboutUsUrl,
  }) : super(url: aboutUsUrl);

  final String aboutUsUrl;

  factory SideMenuPageResponseModel.fromJson(dynamic json) =>
      SideMenuPageResponseModel(
        aboutUsUrl: json["data"] ??
            (throw Exception("SideMenuPageResponseModel.fromJson"
                " >> json[\"data\"] is null ")),
      );
}
