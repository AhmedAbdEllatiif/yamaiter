import 'package:equatable/equatable.dart';

import '../../../common/constants/app_utils.dart';

class AdEntity extends Equatable {
  final int id;
  final String image;
  final String pages;
  final int period;
  final double price;

  late final String createdAt;
  late final String updatedAt;

  AdEntity({
    required DateTime? createdDateAt,
    required DateTime? updatedDateAt,
    required this.id,
    required this.image,
    required this.pages,
    required this.period,
    required this.price,
  }) {
    /// init create at
    if (createdDateAt != null) {
      createdAt =
          "${createdDateAt.year.toString()}-${createdDateAt.month.toString().padLeft(2, '0')}-"
          "${createdDateAt.day.toString().padLeft(2, '0')} ";
    } else {
      createdAt = AppUtils.undefined;
    }

    /// init update at
    if (updatedDateAt != null) {
      updatedAt =
          "${updatedDateAt.year.toString()}-${updatedDateAt.month.toString().padLeft(2, '0')}-"
          "${updatedDateAt.day.toString().padLeft(2, '0')} ";
    } else {
      updatedAt = AppUtils.undefined;
    }
  }

  @override
  List<Object?> get props => [id];
}
