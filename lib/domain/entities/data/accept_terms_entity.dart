import 'package:equatable/equatable.dart';

import 'accept_terms_page.dart';

class AcceptTermsEntity extends Equatable {
  final bool isUserAcceptedTerms;
  final List<AcceptTermsPageEntity> pages;

  const AcceptTermsEntity({
    required this.isUserAcceptedTerms,
    required this.pages,
  });

  @override
  List<Object?> get props => [isUserAcceptedTerms, pages];
}
