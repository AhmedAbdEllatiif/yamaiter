import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/payment_mission_type.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/pay_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/payment_args.dart';
import 'package:yamaiter/presentation/journeys/request_a_consultation/consultation_form.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../common/functions/common_functions.dart';
import '../../../di/git_it.dart';
import '../../../router/route_helper.dart';
import '../../logic/common/check_payment_status/check_payment_status_cubit.dart';
import '../../logic/cubit/accept_terms/accept_terms_cubit.dart';
import '../../logic/cubit/get_accept_terms/get_accept_terms_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/accept_terms_widget.dart';
import '../../widgets/ads_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';

class RequestAConsultationScreen extends StatefulWidget {
  const RequestAConsultationScreen({Key? key}) : super(key: key);

  @override
  State<RequestAConsultationScreen> createState() =>
      _RequestAConsultationScreenState();
}

class _RequestAConsultationScreenState
    extends State<RequestAConsultationScreen> {
  /// GetAcceptTermsCubit
  late final GetAcceptTermsCubit _getAcceptTermsCubit;

  /// AcceptTermsCubit
  late final AcceptTermsCubit _acceptTermsCubit;

  /// CheckPaymentStatusCubit
  late final CheckPaymentStatusCubit _checkPaymentStatusCubit;

  @override
  void initState() {
    super.initState();
    // init GetAcceptTermsCubit
    _getAcceptTermsCubit = getItInstance<GetAcceptTermsCubit>();

    // init AcceptTermsCubit
    _acceptTermsCubit = getItInstance<AcceptTermsCubit>();

    // init CheckPaymentStatusCubit
    _checkPaymentStatusCubit = getItInstance<CheckPaymentStatusCubit>();

    // fetch accept terms
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
      providers: [
        BlocProvider(create: (context) => _getAcceptTermsCubit),
        BlocProvider(create: (context) => _acceptTermsCubit),
        BlocProvider(create: (context) => _checkPaymentStatusCubit),
      ],
      child: MultiBlocListener(
        listeners: [
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
              _navigateToMyConsultations();
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

          /// AcceptTerms listener
          BlocListener<AcceptTermsCubit, AcceptTermsState>(
              listener: (context, state) {
            /// accepted successfully
            if (state is TermsAcceptedSuccessfully) {
              _fetchTermsToAccept();
            }
          })
        ],
        child: Scaffold(
          /// appBar
          appBar: AppBar(
            title: const Text("طلب استشارة قانونية"),
          ),

          body: Column(
            children: [
              const AdsWidget(),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppUtils.mainPagesHorizontalPadding.w,
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

                    /// AlreadyAccepted >> show ConsultationForm
                    if (state is TermsAlreadyAccepted) {
                      return ConsultationForm(
                        consultFees:
                            state.acceptTermsEntity.consultationCost.value,
                        onSuccess: (payEntity) =>
                            _navigateToPaymentScreen(payEntity),
                      );
                    }

                    /// else
                    return const SizedBox.shrink();
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  /// fetch terms to accept
  void _fetchTermsToAccept() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAcceptTermsCubit.getAcceptTerms(token: userToken);
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// navigate to PaymentScreen
  void _navigateToPaymentScreen(PayEntity payEntity) async {
    // await to check payment status onBack from payment screen
    await RouteHelper().paymentScreen(
      context,
      paymentArguments: PaymentArguments(link: payEntity.link),
    );

    // if not mounted return
    if (!mounted) return;

    _checkForPaymentStatus(
      paymentMissionType: PaymentMissionType.consultation,
      missionId: payEntity.missionId,
    );
  }

  /// navigate to MyConsultations
  void _navigateToMyConsultations() => RouteHelper().myConsultations(
        context,
        isReplacement: true,
      );

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
