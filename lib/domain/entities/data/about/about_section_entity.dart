import 'package:equatable/equatable.dart';

class AboutSectionEntity extends Equatable {
  final int id;
  final String description;

  const AboutSectionEntity({
    required this.id,
    required this.description,
  });

  @override
  List<Object?> get props => [id];
}
