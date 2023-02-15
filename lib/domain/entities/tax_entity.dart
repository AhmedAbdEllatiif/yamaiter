import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/api/constants.dart';

import '../../common/constants/app_utils.dart';

class TaxEntity extends Equatable {
  final int id;
  final String name;
  final String password;
  final String status;

  final double cost;
  final String adminFileName;
  late final String fileToDownload;
  late final String createdAt;

  TaxEntity(
      {required this.id,
      required this.name,
      required this.password,
      required this.status,
      required this.cost,
      required  this.adminFileName,
      required DateTime? createdDate}) {
    /// init create at
    if (createdDate != null) {
      createdAt = "${createdDate.year.toString()}-"
          "${createdDate.month.toString().padLeft(2, '0')}-"
          "${createdDate.day.toString().padLeft(2, '0')} ";
    } else {
      createdAt = AppUtils.undefined;
    }

    fileToDownload = adminFileName == AppUtils.undefined
        ? AppUtils.undefined
        : ApiConstants.mediaUrl + adminFileName;
  }

  @override
  List<Object?> get props => [id];
}
