import 'package:equatable/equatable.dart';

class SideMenuPageEntity extends Equatable {
  final String url;

  const SideMenuPageEntity({
    required this.url,
  });

  @override
  List<Object?> get props => [url];
}
