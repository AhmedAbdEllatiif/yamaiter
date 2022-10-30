import '../../params/accept_terms_params.dart';

class AcceptTermsModel {
  final String acceptTerms;

  AcceptTermsModel({required this.acceptTerms});

  factory AcceptTermsModel.fromParams(AcceptTermsParams params) =>
      AcceptTermsModel(acceptTerms: params.isAccepted ? "yes" : "no");

  Map<String, dynamic> toJson() {
    return {
      "accept_terms": acceptTerms,
    };
  }
}
