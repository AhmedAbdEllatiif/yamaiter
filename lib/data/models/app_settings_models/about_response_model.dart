import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/domain/entities/data/about/about_entity.dart';
import 'package:yamaiter/domain/entities/data/about/about_section_entity.dart';

///  return a list of about models
List<AboutResponseModel> listOfAboutModels(dynamic data) =>
    List<AboutResponseModel>.from(
      data.map(
        (x) => AboutResponseModel.fromJson(x),
      ),
    );

/// AboutResponseModel
class AboutResponseModel extends AboutEntity {
  const AboutResponseModel({
    required this.aboutId,
    required this.aboutTitle,
    required this.createdAt,
    required this.updatedAt,
    required this.aboutSections,
  }) : super(
          id: aboutId,
          title: aboutTitle,
          sections: aboutSections,
        );

  final int aboutId;
  final String aboutTitle;
  final dynamic createdAt;
  final dynamic updatedAt;
  final List<Section> aboutSections;

  factory AboutResponseModel.fromJson(Map<String, dynamic> json) =>
      AboutResponseModel(
        aboutId: json["id"] ?? -1,
        aboutTitle: json["title"] ?? AppUtils.undefined,
        createdAt: json["created_at"] ?? AppUtils.undefined,
        updatedAt: json["updated_at"] ?? AppUtils.undefined,
        aboutSections: json["sections"] != null
            ? List<Section>.from(
                json["sections"].map((x) => Section.fromJson(x)))
            : [],
      );
}

/// Section model
class Section extends AboutSectionEntity {
  const Section({
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

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        sectionId: json["id"] ?? -1,
        sectionDescription: json["description"] ?? AppUtils.undefined,
        pageId: json["page_id"] ?? -1,
        createdAt: json["created_at"] ?? AppUtils.undefined,
        updatedAt: json["updated_at"] ?? AppUtils.undefined,
      );
}
