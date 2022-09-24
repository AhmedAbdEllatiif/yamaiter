import 'package:equatable/equatable.dart';
import 'package:yamaiter/domain/entities/data/about/about_section_entity.dart';

class AboutEntity extends Equatable {
  final int id;
  final String title;
  final List<AboutSectionEntity> sections;

  const AboutEntity({
    required this.id,
    required this.title,
    required this.sections,
  });


  @override
   List<Object?> get props => [id];
}
