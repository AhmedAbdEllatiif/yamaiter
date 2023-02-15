import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final int id;
  final String content;

  const NewsEntity({required this.id, required this.content});

  @override
  List<Object?> get props => [id, content];
}
