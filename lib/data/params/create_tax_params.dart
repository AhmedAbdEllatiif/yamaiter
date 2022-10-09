import '../models/tax/tax_request_model.dart';

class CreateTaxParams {
  final CreateTaxRequestModel createTaxRequestModel;
  final String userToken;

  CreateTaxParams({required this.createTaxRequestModel, required this.userToken});
}
