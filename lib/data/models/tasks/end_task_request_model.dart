class EndTaskRequestModel {
  final double rating;

  EndTaskRequestModel({required this.rating});

  Map<String, dynamic> toJson() {
    return {
      "rating": rating.toString(),
    };
  }
}
