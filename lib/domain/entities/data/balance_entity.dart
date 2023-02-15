import 'package:equatable/equatable.dart';

class BalanceEntity extends Equatable {
  final double currentBalance;

  const BalanceEntity({required this.currentBalance});

  @override
  List<Object?> get props => [currentBalance];
}
