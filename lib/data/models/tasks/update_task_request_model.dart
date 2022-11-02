import '../../params/update_task_params.dart';

class UpdateTaskRequestModel {
  final int id;
  final String title;
  final String price;
  final String court;
  final String description;
  final String governorates;
  final String startingDate;

  UpdateTaskRequestModel({
    required this.id,
    required this.title,
    required this.price,
    required this.court,
    required this.description,
    required this.governorates,
    required this.startingDate,
  });

  factory UpdateTaskRequestModel.fromParams(
      {required UpdateTaskParams params}) {
    return UpdateTaskRequestModel(
      id: params.id,
      title: params.title,
      price: params.price,
      court: params.court,
      description: params.description,
      governorates: params.governorates,
      startingDate: params.startingDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "price": price,
      "court": court,
      "description": description,
      "governorates": governorates,
      "starting_date": startingDate
    };
  }
}
