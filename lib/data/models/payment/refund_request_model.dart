class RefundRequestModel {
  final String missionType;
  final int missionId;

  RefundRequestModel({
    required this.missionType,
    required this.missionId,
  });

  Map<String, String> toJson() {
    return {
      "mission_type": missionType,
      "mission_id": missionId.toString()
    };
  }
}
