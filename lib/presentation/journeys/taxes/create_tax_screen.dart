import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/domain/entities/screen_arguments/create_tax_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/payment_args.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../di/git_it.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/accept_terms/accept_terms_cubit.dart';
import '../../logic/cubit/get_accept_terms/get_accept_terms_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/accept_terms_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'create_tax_form.dart';

class CreateTaxScreen extends StatefulWidget {
  final CreateTaxArguments createTaxArguments;

  const CreateTaxScreen({Key? key, required this.createTaxArguments})
      : super(key: key);

  @override
  State<CreateTaxScreen> createState() => _CreateTaxScreenState();
}

class _CreateTaxScreenState extends State<CreateTaxScreen> {
  late final GetAcceptTermsCubit _getAcceptTermsCubit;
  late final AcceptTermsCubit _acceptTermsCubit;

  bool isBackAfterSuccess = false;

  /// screen params
  late final bool _showAds;
  late final Color _bgColor;
  late final bool _showFormInCard;

  @override
  void initState() {
    super.initState();
    // init GetAcceptTermsCubit
    _getAcceptTermsCubit = getItInstance<GetAcceptTermsCubit>();
    _acceptTermsCubit = getItInstance<AcceptTermsCubit>();

    // init screen params
    _showAds = widget.createTaxArguments.withAdsWidget;
    _bgColor = widget.createTaxArguments.withBackgroundWhite
        ? AppColor.white
        : AppColor.primaryDarkColor;
    _showFormInCard = widget.createTaxArguments.withBackgroundWhite;

    // fetch terms
    _fetchTermsToAccept();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      /// providers
      providers: [
        BlocProvider(create: (context) => _getAcceptTermsCubit),
        BlocProvider(create: (context) => _acceptTermsCubit),
      ],

      child: BlocListener<AcceptTermsCubit, AcceptTermsState>(
        listener: (_, state) {
          /// accepted successfully
          if (state is TermsAcceptedSuccessfully) {
            _fetchTermsToAccept();
          }
        },
        child: Scaffold(
          backgroundColor: _bgColor,
          appBar: AppBar(
            title: const Text("الاقرار الضريبى"),
          ),
          body: Column(
            children: [
              /// Ads
              if (_showAds) const AdsWidget(),

              /// Card
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.dimen_10.h,
                    right: AppUtils.mainPagesHorizontalPadding.w,
                    left: AppUtils.mainPagesHorizontalPadding.w,
                    bottom: Sizes.dimen_10.h,
                  ),
                  child: BlocBuilder<GetAcceptTermsCubit, GetAcceptTermsState>(
                    builder: (context, state) {
                      /// loading
                      if (state is LoadingGetAcceptTerms) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      }

                      /// UnAuthorizedGetAcceptTerms
                      if (state is UnAuthorizedGetAcceptTerms) {
                        return Center(
                          child: AppErrorWidget(
                            appTypeError: AppErrorType.unauthorizedUser,
                            buttonText: "تسجيل الدخول",
                            onPressedRetry: () {
                              _navigateToLogin();
                            },
                          ),
                        );
                      }

                      /// NotActivatedUserToGetAcceptTerms
                      if (state is NotActivatedUserToGetAcceptTerms) {
                        return Center(
                          child: AppErrorWidget(
                            appTypeError: AppErrorType.notActivatedUser,
                            buttonText: "تواصل معنا",
                            message:
                                "نأسف لذلك، لم يتم تفعيل حسابك سوف تصلك رسالة بريدية عند التفعيل",
                            onPressedRetry: () {
                              _navigateToContactUs();
                            },
                          ),
                        );
                      }

                      /// NotActivatedUserToGetAcceptTerms
                      if (state is ErrorWhileGettingAcceptTerms) {
                        return Center(
                          child: AppErrorWidget(
                            appTypeError: state.appError.appErrorType,
                            onPressedRetry: () {
                              _fetchTermsToAccept();
                            },
                          ),
                        );
                      }

                      /// NotAcceptedYet
                      if (state is TermsNotAcceptedYet) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: AcceptTermsWidget(
                            acceptTermsCubit: _acceptTermsCubit,
                            acceptTermsEntity: state.acceptTermsEntity,
                          ),
                        );
                      }

                      /// AlreadyAccepted
                      if (state is TermsAlreadyAccepted) {
                        return CreateTaxForm(
                          withWhiteCard: _showFormInCard,
                          taxValue: state.acceptTermsEntity.taxCost.value,
                          payForTaskCubit:
                              widget.createTaxArguments.payForTaxCubit,
                          onSuccess: (link) => _navigateToPaymentScreen(link),
                        );
                      }

                      /// else
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// navigate to payment screen
  void _navigateToPaymentScreen(String paymentLink) async {
    await RouteHelper().paymentScreen(
      context,
      paymentArguments: PaymentArguments(link: paymentLink),
    );

    if (!mounted) return;
  }

  void _fetchTermsToAccept() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAcceptTermsCubit.getAcceptTerms(token: userToken);
  }
}
