import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/cost_type.dart';
import 'package:yamaiter/domain/entities/data/accept_terms/cost_entity.dart';

import '../../../domain/entities/data/accept_terms/accept_terms_entity.dart';
import '../../../domain/entities/data/accept_terms/accept_terms_page.dart';

//  return AcceptTermsResponseModel
AcceptTermsResponseModel acceptTermsResponseModel(dynamic response) =>
    AcceptTermsResponseModel.fromJson(response);

class AcceptTermsResponseModel extends AcceptTermsEntity {
  final bool acceptTerms;
  final List<AcceptTermsPagesModel> acceptTermsPages;
  final List<CostModel> costsList;

  const AcceptTermsResponseModel(
      {required this.acceptTerms,
      required this.acceptTermsPages,
      required this.costsList})
      : super(
            isUserAcceptedTerms: acceptTerms,
            pages: acceptTermsPages,
            costs: costsList);

  factory AcceptTermsResponseModel.fromJson(Map<String, dynamic> json) =>
      AcceptTermsResponseModel(
        //==> bool accept terms
        acceptTerms: json["accept-terms"] ?? false,

        //==> pages
        acceptTermsPages: json["data"]["page"] != null
            ? listOfPages(json["data"]["page"])
            : [],

        //==> costs
        costsList: json["data"]["costs"] != null
            ? listOfCostModel(json["data"]["costs"])
            : [],
      );
}

///  return a list of accept terms models
List<AcceptTermsPagesModel> listOfPages(dynamic data) =>
    List<AcceptTermsPagesModel>.from(
      data.map(
        (x) => AcceptTermsPagesModel.fromJson(x),
      ),
    );

///  return a list of cost  models
List<CostModel> listOfCostModel(dynamic data) => List<CostModel>.from(
      data.map(
        (x) => CostModel.fromJson(x),
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

/// cost model
class CostModel extends CostEntity {
  CostModel({
    required this.costId,
    required this.infoName,
    required this.infoValue,
  }) : super(
          // id
          id: costId,

          // costType
          costType: infoName.contains("tax")
              ? CostType.tax
              : infoName.contains("consultation")
                  ? CostType.consultation
                  : CostType.undefined,

          // value
          value: infoValue,
        );

  final int costId;
  final String infoName;
  final num infoValue;

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
        //id
        costId: json["id"] ?? -1,

        // name
        infoName: json["info_name"] ?? AppUtils.undefined,

        // value
        infoValue: json["info_value"] != null
            ? double.tryParse(json["info_value"]) ?? -1
            : -1,
      );
}
