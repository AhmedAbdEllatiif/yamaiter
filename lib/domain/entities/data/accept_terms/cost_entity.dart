import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/cost_type.dart';

/// CostEntity
class CostEntity extends Equatable {
  final int id;
  final CostType costType;
  final num value;

  const CostEntity({
    required this.id,
    required this.costType,
    required this.value,
  });

  @override
  List<Object?> get props => [id, value];
}
