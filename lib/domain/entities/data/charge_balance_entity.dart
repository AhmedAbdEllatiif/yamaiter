import 'package:equatable/equatable.dart';

class ChargeBalanceEntity extends Equatable {
  final String billReference;

  const ChargeBalanceEntity({required this.billReference});

  @override
  List<Object?> get props => [billReference];
}
