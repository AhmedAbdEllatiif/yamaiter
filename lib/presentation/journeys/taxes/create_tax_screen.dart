import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/payment_mission_type.dart';
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
import '../../logic/common/check_payment_status/check_payment_status_cubit.dart';
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
  /// GetAcceptTermsCubit
  late final GetAcceptTermsCubit _getAcceptTermsCubit;

  /// AcceptTermsCubit
  late final AcceptTermsCubit _acceptTermsCubit;

  /// CheckPaymentStatusCubit
  late final CheckPaymentStatusCubit _checkPaymentStatusCubit;

  /// screen params
  late final bool _showAds;
  late final Color _bgColor;
  late final bool _showFormInCard;

  @override
  void initState() {
    super.initState();
    // init cubits
    _getAcceptTermsCubit = getItInstance<GetAcceptTermsCubit>();
    _acceptTermsCubit = getItInstance<AcceptTermsCubit>();
    _checkPaymentStatusCubit = getItInstance<CheckPaymentStatusCubit>();

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
  void dispose() {
    _getAcceptTermsCubit.close();
    _acceptTermsCubit.close();
    _checkPaymentStatusCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      /// providers
      providers: [
        BlocProvider(create: (context) => _getAcceptTermsCubit),
        BlocProvider(create: (context) => _acceptTermsCubit),
        BlocProvider(create: (context) => _checkPaymentStatusCubit),
      ],

      child: MultiBlocListener(
        listeners: [
          /// AcceptTerms listener
          BlocListener<AcceptTermsCubit, AcceptTermsState>(
            listener: (_, state) {
              //==> accepted successfully
              if (state is TermsAcceptedSuccessfully) {
                _fetchTermsToAccept();
              }
            },
          ),

          /// CheckPaymentStatus listener
          BlocListener<CheckPaymentStatusCubit, CheckPaymentStatusState>(
              listener: (_, state) {
            //==> loading
            if (state is LoadingCheckPaymentStatus) {
              showAppDialog(context, isLoadingDialog: true);
            }
            //==> accepted successfully
            if (state is PaymentSuccess) {
              Navigator.pop(context);
              _navigateToMyTaxes();
            }

            //==> NotAPaymentProcessYet
            if (state is NotAPaymentProcessYet) {
              Navigator.pop(context);
              showAppDialog(
                context,
                message: "حدث خطأ فى عملية الدفع",
                buttonText: "اعدالمحاولة",
                onPressed: () => Navigator.pop(context),
              );
            }

            //==> PaymentFailed
            if (state is PaymentFailed) {
              Navigator.pop(context);
              showAppDialog(
                context,
                message: "فشلت عملية الدفع",
                buttonText: "اعدالمحاولة",
                onPressed: () => Navigator.pop(context),
              );
            }
          }),
        ],

        /// Scaffold
        child: Scaffold(
          backgroundColor: _bgColor,
          //==> appbar
          appBar: AppBar(
            title: const Text("الاقرار الضريبى"),
          ),

          //==> body
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
                      /*
                      *
                      *
                      *  loading
                      *
                      * */
                      if (state is LoadingGetAcceptTerms) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      }

                      /*
                      *
                      *
                      * UnAuthorizedGetAcceptTerms
                      *
                      * */
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

                      /*
                      *
                      *
                      * NotActivatedUserToGetAcceptTerms
                      *
                      * */
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

                      /*
                      *
                      *
                      * ErrorWhileGettingAcceptTerms
                      *
                      * */
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

                      /*
                      *
                      *
                      * NotAcceptedYet
                      *
                      * */
                      if (state is TermsNotAcceptedYet) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: AcceptTermsWidget(
                            acceptTermsCubit: _acceptTermsCubit,
                            acceptTermsEntity: state.acceptTermsEntity,
                          ),
                        );
                      }

                      /*
                      *
                      *
                      * TermsAlreadyAccepted
                      *
                      * */
                      if (state is TermsAlreadyAccepted) {
                        return CreateTaxForm(
                          withWhiteCard: _showFormInCard,
                          taxValue: state.acceptTermsEntity.taxCost.value,
                          costCommission:
                              state.acceptTermsEntity.costCommission,
                          payForTaskCubit:
                              widget.createTaxArguments.payForTaxCubit,
                          onSuccess: (payEntity) => _navigateToPaymentScreen(
                            paymentLink: payEntity.link,
                            missionId: payEntity.missionId,
                            paymentMissionType: payEntity.paymentMissionType,
                          ),
                        );
                      }

                      /*
                      *
                      *
                      * else
                      *
                      * */
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

  /// to navigate to my taxes screen
  void _navigateToMyTaxes() {
    RouteHelper().myTaxesScreen(context, isReplacement: true);
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// navigate to payment screen
  void _navigateToPaymentScreen({
    required String paymentLink,
    required PaymentMissionType paymentMissionType,
    required int missionId,
  }) async {
    // await to check payment status onBack from payment screen
    await RouteHelper().paymentScreen(
      context,
      paymentArguments: PaymentArguments(link: paymentLink),
    );

    // if not mounted return
    if (!mounted) return;

    _checkForPaymentStatus(
        paymentMissionType: paymentMissionType, missionId: missionId);
  }

  /// to fetch accept terms
  void _fetchTermsToAccept() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAcceptTermsCubit.getAcceptTerms(token: userToken);
  }

  /// to check the payment status
  /// * [paymentMissionType] >> param is the mission type to pay
  /// * [missionId] >> param is the mission id to pay
  void _checkForPaymentStatus({
    required PaymentMissionType paymentMissionType,
    required int missionId,
  }) async {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _checkPaymentStatusCubit.checkForPaymentProcessStatus(
      missionType: paymentMissionType,
      missionId: missionId,
      token: userToken,
    );
  }
}
