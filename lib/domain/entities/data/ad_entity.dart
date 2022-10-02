import 'package:equatable/equatable.dart';

class AdEntity extends Equatable{
  final int id;
  final String url;


  const AdEntity({required this.id, required this.url});

  @override
  List<Object?> get props => [id];


}