class CreateAdRequestModel {
  final String place;

  CreateAdRequestModel({
    required this.place,
  });

  Map<String, dynamic> toJson() {
    return {
      "place": place,
    };
  }
}
