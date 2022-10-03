class SosRequestModel {
  final String type;
  final String governorate;
  final String description;

  SosRequestModel(
      {required this.type,
      required this.governorate,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "governorate": governorate,
      "description": description,
    };
  }
}
