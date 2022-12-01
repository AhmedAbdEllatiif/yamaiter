import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/request_a_consultation/consultation_form.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../di/git_it.dart';
import '../../../router/route_helper.dart';
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
  late final GetAcceptTermsCubit _getAcceptTermsCubit;
  late final AcceptTermsCubit _acceptTermsCubit;

  @override
  void initState() {
    super.initState();
    // init GetAcceptTermsCubit
    _getAcceptTermsCubit = getItInstance<GetAcceptTermsCubit>();

    // init AcceptTermsCubit
    _acceptTermsCubit = getItInstance<AcceptTermsCubit>();

    _fetchTermsToAccept();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getAcceptTermsCubit),
        BlocProvider(create: (context) => _acceptTermsCubit),
      ],
      child: BlocListener<AcceptTermsCubit, AcceptTermsState>(
        listener: (context, state) {
          /// accepted successfully
          if (state is TermsAcceptedSuccessfully) {
            _fetchTermsToAccept();
          }
        },
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
                        onSuccess: () => _navigateToMyConsultations(),
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

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// navigate to MyConsultations
  void _navigateToMyConsultations() =>
      RouteHelper().myConsultations(context, isReplacement: true);

  /// fetch terms to accept
  void _fetchTermsToAccept() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAcceptTermsCubit.getAcceptTerms(token: userToken);
  }
}
