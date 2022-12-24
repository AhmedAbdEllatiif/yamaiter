import 'package:equatable/equatable.dart';
import 'package:yamaiter/common/enum/cost_type.dart';

/// CostEntity
class CostEntity extends Equatable {
  final int id;
  final CostType costType;
  final double value;

  const CostEntity({
    required this.id,
    required this.costType,
    required this.value,
  });

  factory CostEntity.empty() =>
      const CostEntity(id: -1, costType: CostType.undefined, value: -1);

  @override
  List<Object?> get props => [id, value];
}
