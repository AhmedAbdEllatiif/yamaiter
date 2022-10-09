class CreateTaxRequestModel {
  final String taxName;
  final String taxPassword;
  final String note;
  final String taxFile;

  CreateTaxRequestModel({
    required this.taxName,
    required this.taxPassword,
    required this.note,
    required this.taxFile,
  });

  Map<String, dynamic> toJson() {
    return {
      "tax_name": taxName,
      "tax_password": taxPassword,
      "notes": note,
      "tax_file": taxFile,
    };
  }
}
