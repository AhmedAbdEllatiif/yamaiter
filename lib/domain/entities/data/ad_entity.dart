import 'package:equatable/equatable.dart';
import 'package:yamaiter/data/api/constants.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/enum/ad_status.dart';

class AdEntity extends Equatable {
  final int id;
  final String url;
  final int period;
  final double price;
  final AdStatus status;

  late final String pages;

  late final String image;
  late final String createdAt;
  late final String updatedAt;

  AdEntity({
    required DateTime? createdDateAt,
    required DateTime? updatedDateAt,
    required final String adImage,
    required final String adPages,
    required this.id,
    required this.url,
    required this.period,
    required this.price,
    required this.status,
  }) {
    /// init image
    image = adImage == AppUtils.undefined
        ? AppUtils.undefined
        : ApiConstants.mediaUrl + adImage;

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

    /// init Pages
    if (adPages == "all") {
      pages = "كل الصفحات";
    } else if (adPages == "home") {
      pages = "الرئيسية";
    } else if (adPages == "pages") {
      pages = "الصفحات الداخلية";
    }else{
      pages = adPages;
    }
  }

  @override
  List<Object?> get props => [id];
}
