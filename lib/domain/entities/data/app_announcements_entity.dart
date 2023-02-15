import 'package:equatable/equatable.dart';

import '../../../data/models/announcements/ad_model.dart';
import '../../../data/models/announcements/new_model.dart';

class AppAnnouncementsEntity extends Equatable {
  final List<AdModel> ads;
  final List<NewsModel> news;

  const AppAnnouncementsEntity({required this.ads, required this.news});

  @override
  List<Object?> get props => [ads, news];
}
