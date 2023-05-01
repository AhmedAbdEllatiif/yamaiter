import 'package:yamaiter/common/enum/payment_method.dart';

class CreateTaxRequestModel {
  final PaymentMethod paymentMethod;
  final String taxName;
  final String taxPassword;
  final String description;
  final String taxFile;
  final double value;

  CreateTaxRequestModel(
      {required this.paymentMethod,
      required this.taxName,
      required this.taxPassword,
      required this.description,
      required this.taxFile,
      required this.value});
}
