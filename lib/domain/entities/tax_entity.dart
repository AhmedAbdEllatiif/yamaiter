import 'package:equatable/equatable.dart';

import '../../common/constants/app_utils.dart';

class TaxEntity extends Equatable {
  final int id;
  final String name;
  final String password;
  final String status ;
  final double cost;
  late final String createdAt;

  TaxEntity(
      {required this.id,
      required this.name,
      required this.password,
      required this.status,
      required this.cost,
      required DateTime? createdDate}) {
    /// init create at
    if (createdDate != null) {
      createdAt = "${createdDate.year.toString()}-"
          "${createdDate.month.toString().padLeft(2, '0')}-"
          "${createdDate.day.toString().padLeft(2, '0')} ";
    } else {
      createdAt = AppUtils.undefined;
    }
  }

  @override
  List<Object?> get props => [id];
}
