import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/side_menu_page_entity.dart';

///  return a list of terms and conditions models
List<SideMenuPageResponseModel> listOfSideMenuResponseModels(dynamic data) =>
    List<SideMenuPageResponseModel>.from(
      data.map(
            (x) => SideMenuPageResponseModel.fromJson(x),
      ),
    );

/// TermsAndConditionResponseModel
class SideMenuPageResponseModel extends SideMenuPageEntity {
  const SideMenuPageResponseModel({
    required this.aboutId,
    required this.aboutTitle,
    required this.createdAt,
    required this.updatedAt,
    required this.termsSections,
  }) : super(
    id: aboutId,
    title: aboutTitle,
    sections: termsSections,
  );

  final int aboutId;
  final String aboutTitle;
  final dynamic createdAt;
  final dynamic updatedAt;
  final List<SideMenuSectionModel> termsSections;

  factory SideMenuPageResponseModel.fromJson(Map<String, dynamic> json) =>
      SideMenuPageResponseModel(
        aboutId: json["id"] ?? -1,
        aboutTitle: json["title"] ?? AppUtils.undefined,
        createdAt: json["created_at"] ?? AppUtils.undefined,
        updatedAt: json["updated_at"] ?? AppUtils.undefined,
        termsSections: json["sections"] != null
            ? List<SideMenuSectionModel>.from(
            json["sections"].map((x) => SideMenuSectionModel.fromJson(x)))
            : [],
      );
}

/// Section model
class SideMenuSectionModel extends SideMenuPageSectionEntity {
  const SideMenuSectionModel({
    required this.sectionId,
    required this.sectionDescription,
    required this.pageId,
    required this.createdAt,
    required this.updatedAt,
  }) : super(id: sectionId, description: sectionDescription);

  final int sectionId;
  final String sectionDescription;
  final int pageId;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory SideMenuSectionModel.fromJson(Map<String, dynamic> json) => SideMenuSectionModel(
    sectionId: json["id"] ?? -1,
    sectionDescription: json["description"] ?? AppUtils.undefined,
    pageId: json["page_id"] ?? -1,
    createdAt: json["created_at"] ?? AppUtils.undefined,
    updatedAt: json["updated_at"] ?? AppUtils.undefined,
  );
}
