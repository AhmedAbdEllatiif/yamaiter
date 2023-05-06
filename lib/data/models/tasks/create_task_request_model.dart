import 'package:yamaiter/data/params/create_task_params.dart';

class CreateTaskRequestModel {
  final String title;
  final String price;
  final String court;
  final String description;
  final String governorates;
  final String startingDate;

  CreateTaskRequestModel({
    required this.title,
    required this.price,
    required this.court,
    required this.description,
    required this.governorates,
    required this.startingDate,
  });

  factory CreateTaskRequestModel.fromParams(
      {required CreateTaskParams params}) {
    return CreateTaskRequestModel(
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
      "price": "10000000",//price,
      "court": court,
      "description": description,
      "governorates": governorates,
      "starting_date": startingDate
    };
  }
}
