class CreateTaxRequestModel {
  final String taxName;
  final String taxPassword;
  final String description;
  final String taxFile;
  final double value;

  CreateTaxRequestModel({
    required this.taxName,
    required this.taxPassword,
    required this.description,
    required this.taxFile,
    required this.value
  });


}
