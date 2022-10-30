import 'package:yamaiter/common/constants/app_utils.dart';

import '../../../domain/entities/data/accept_terms_entity.dart';
import '../../../domain/entities/data/accept_terms_page.dart';

//  return AcceptTermsResponseModel
AcceptTermsResponseModel acceptTermsResponseModel(dynamic response) =>
    AcceptTermsResponseModel.fromJson(response);

class AcceptTermsResponseModel extends AcceptTermsEntity {
  final bool acceptTerms;
  final List<AcceptTermsPagesModel> acceptTermsPages;

  const AcceptTermsResponseModel({
    required this.acceptTerms,
    required this.acceptTermsPages,
  }) : super(
          isUserAcceptedTerms: acceptTerms,
          pages: acceptTermsPages,
        );

  factory AcceptTermsResponseModel.fromJson(Map<String, dynamic> json) =>
      AcceptTermsResponseModel(
        acceptTerms: json["accept-terms"] ?? false,
        acceptTermsPages: json["data"]["page"] != null
            ? listOfAcceptTermsResponseModels(json["data"]["page"])
            : [],
      );
}

///  return a list of accept terms models
List<AcceptTermsPagesModel> listOfAcceptTermsResponseModels(dynamic data) =>
    List<AcceptTermsPagesModel>.from(
      data.map(
        (x) => AcceptTermsPagesModel.fromJson(x),
      ),
    );

/// AcceptTermsPagesModel
class AcceptTermsPagesModel extends AcceptTermsPageEntity {
  const AcceptTermsPagesModel({
    required this.pagetId,
    required this.pageTitle,
    required this.createdAt,
    required this.updatedAt,
    required this.pageSections,
  }) : super(
          id: pagetId,
          title: pageTitle,
          sections: pageSections,
        );

  final int pagetId;
  final String pageTitle;
  final dynamic createdAt;
  final dynamic updatedAt;
  final List<AcceptTermsPageSection> pageSections;

  factory AcceptTermsPagesModel.fromJson(Map<String, dynamic> json) =>
      AcceptTermsPagesModel(
        pagetId: json["id"] ?? -1,
        pageTitle: json["title"] ?? AppUtils.undefined,
        createdAt: json["created_at"] ?? AppUtils.undefined,
        updatedAt: json["updated_at"] ?? AppUtils.undefined,
        pageSections: json["sections"] != null
            ? List<AcceptTermsPageSection>.from(
                json["sections"].map((x) => AcceptTermsPageSection.fromJson(x)))
            : [],
      );
}

/// Section model
class AcceptTermsPageSection extends AcceptTermsPageSectionEntity {
  const AcceptTermsPageSection({
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

  factory AcceptTermsPageSection.fromJson(Map<String, dynamic> json) =>
      AcceptTermsPageSection(
        sectionId: json["id"] ?? -1,
        sectionDescription: json["description"] ?? AppUtils.undefined,
        pageId: json["page_id"] ?? -1,
        createdAt: json["created_at"] ?? AppUtils.undefined,
        updatedAt: json["updated_at"] ?? AppUtils.undefined,
      );
}
