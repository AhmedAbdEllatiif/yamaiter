import 'package:yamaiter/data/params/create_task_params.dart';

class CreateTaskRequestModelClient {
  final String title;
  final String price;
  final String court;
  final String description;
  final String governorates;
  final String startingDate;

  CreateTaskRequestModelClient({
    required this.title,
    required this.price,
    required this.court,
    required this.description,
    required this.governorates,
    required this.startingDate,
  });

  factory CreateTaskRequestModelClient.fromParams(
      {required CreateTaskParams params}) {
    return CreateTaskRequestModelClient(
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
