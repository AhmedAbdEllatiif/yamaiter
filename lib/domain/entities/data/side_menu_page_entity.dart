import 'package:equatable/equatable.dart';

class SideMenuPageEntity
    extends Equatable {
  final int id;
  final String title;
  final List<SideMenuPageSectionEntity> sections;

  const SideMenuPageEntity
      ({
    required this.id,
    required this.title,
    required this.sections,
  });


  @override
  List<Object?> get props => [id];
}



class SideMenuPageSectionEntity extends Equatable {
  final int id;
  final String description;

  const SideMenuPageSectionEntity({
    required this.id,
    required this.description,
  });

  @override
  List<Object?> get props => [id];
}
