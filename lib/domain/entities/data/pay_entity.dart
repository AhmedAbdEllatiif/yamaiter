import 'package:equatable/equatable.dart';

class PayEntity extends Equatable {
  final String link;

  const PayEntity({required this.link});

  @override
  List<Object?> get props => [link];
}
