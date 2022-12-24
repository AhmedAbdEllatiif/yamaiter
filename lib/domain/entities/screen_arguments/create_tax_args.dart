import 'package:yamaiter/presentation/logic/cubit/pay_for_tax/pay_for_tax_cubit.dart';

class CreateTaxArguments {
  final bool withBackgroundWhite;
  final bool withAdsWidget;
  final PayForTaxCubit? payForTaxCubit;

  CreateTaxArguments({
    required this.withBackgroundWhite,
    required this.withAdsWidget,
    this.payForTaxCubit,
  });
}
