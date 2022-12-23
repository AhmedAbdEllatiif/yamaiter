import 'package:equatable/equatable.dart';


/// page
class AcceptTermsPageEntity extends Equatable {
  final int id;
  final String title;
  final List<AcceptTermsPageSectionEntity> sections;

  const AcceptTermsPageEntity({
    required this.id,
    required this.title,
    required this.sections,
  });

  @override
  List<Object?> get props => [id];
}


/// page section
class AcceptTermsPageSectionEntity extends Equatable {
  final int id;
  final String description;

  const AcceptTermsPageSectionEntity({
    required this.id,
    required this.description,
  });

  @override
  List<Object?> get props => [id];
}



