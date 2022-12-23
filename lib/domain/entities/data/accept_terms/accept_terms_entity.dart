import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/accept_terms/cost_entity.dart';

import 'accept_terms_page.dart';



class AcceptTermsEntity extends Equatable {
  final bool isUserAcceptedTerms;
  final List<AcceptTermsPageEntity> pages;
  final List<CostEntity> costs;

  const AcceptTermsEntity({
    required this.isUserAcceptedTerms,
    required this.pages,
    required this.costs,
  });

  @override
  List<Object?> get props => [isUserAcceptedTerms, pages,costs];
}
