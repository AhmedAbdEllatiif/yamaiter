import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/cost_type.dart';
import 'package:yamaiter/domain/entities/data/accept_terms/cost_entity.dart';

import 'accept_terms_page.dart';

class AcceptTermsEntity extends Equatable {
  final bool isUserAcceptedTerms;
  final List<AcceptTermsPageEntity> pages;
  final String costCommission;
  final String refundCommission;
  late final CostEntity taxCost;
  late final CostEntity consultationCost;

  AcceptTermsEntity({
    required this.isUserAcceptedTerms,
    required this.pages,
    required this.costCommission,
    required this.refundCommission,
    required final List<CostEntity> costs,
  }) {
    CostEntity? tax;
    CostEntity? consultation;

    for (var element in costs) {
      if (element.costType == CostType.tax) {
        tax = element;
      }

      if (element.costType == CostType.consultation) {
        consultation = element;
      }
    }

    // init costs
    taxCost = tax ?? CostEntity.empty();
    consultationCost = consultation ?? CostEntity.empty();
  }

  @override
  List<Object?> get props =>
      [isUserAcceptedTerms, pages, taxCost, consultationCost];
}
