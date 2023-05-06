import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/data/accept_terms/accept_terms_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/get_accept_terms/get_accept_terms_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../common/enum/app_error_type.dart';
import '../../router/route_helper.dart';
import '../logic/cubit/accept_terms/accept_terms_cubit.dart';
import '../logic/cubit/user_token/user_token_cubit.dart';
import '../themes/theme_color.dart';
import 'app_check_box.dart';
import 'app_content_title_widget.dart';
import 'app_error_widget.dart';
import 'loading_widget.dart';

class AcceptTermsWidget extends StatefulWidget {
  final AcceptTermsEntity? acceptTermsEntity;
  final AcceptTermsCubit? acceptTermsCubit;
  final Function()? onTermsSuccessfullyAccepted;
  final String? buttonText;

  const AcceptTermsWidget({
    Key? key,
    this.acceptTermsEntity,
    this.acceptTermsCubit,
    this.onTermsSuccessfullyAccepted,
    this.buttonText,
  }) : super(key: key);

  @override
  State<AcceptTermsWidget> createState() => _AcceptTermsWidgetState();
}

class _AcceptTermsWidgetState extends State<AcceptTermsWidget> {
  bool _isTermsAccepted = false;
  bool _showCheckBoxError = false;

  /// ScrollController
  late final ScrollController _scrollController;

  /// AcceptTermsCubit
  late final AcceptTermsCubit _acceptTermsCubit;

  late final GetAcceptTermsCubit _getAcceptTermsCubit;

  @override
  void initState() {
    super.initState();

    _acceptTermsCubit =
        widget.acceptTermsCubit ?? getItInstance<AcceptTermsCubit>();
    _getAcceptTermsCubit = getItInstance<GetAcceptTermsCubit>();

    if (widget.acceptTermsEntity == null) {
      _fetchAcceptTerms();
    }

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    if (widget.acceptTermsCubit == null) {
      _acceptTermsCubit.close();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _acceptTermsCubit),
        BlocProvider(create: (context) => _getAcceptTermsCubit),
      ],
      child: BlocListener<AcceptTermsCubit, AcceptTermsState>(
        listener: (context, state) {
          if (state is TermsAcceptedSuccessfully) {
            if (widget.onTermsSuccessfullyAccepted != null) {
              widget.onTermsSuccessfullyAccepted!();
            }
          }
        },
        child: ScrollableAppCard(
          scrollController: _scrollController,

          /// title
          title: const AppContentTitleWidget(
            title: "اتفاقية المعاملة القانونية",
            textColor: AppColor.primaryDarkColor,
          ),

          /// bottom
          bottomChild: BlocBuilder<AcceptTermsCubit, AcceptTermsState>(
            builder: (context, state) {
              /// loading
              if (state is LoadingAcceptTerms) {
                return const Center(
                  child: LoadingWidget(),
                );
              }
              return AppButton(
                text: widget.buttonText ??
                    "إذهب لاضافة بيانات المهمة المطلوبة",
                width: double.infinity,
                color: AppColor.accentColor,
                textColor: AppColor.primaryDarkColor,
                onPressed: () {
                  if (_validateCheckBox(context)) {
                    _sendAcceptTerms();
                  }
                },
              );
            },
          ),

          /// child
          child: BlocBuilder<AcceptTermsCubit, AcceptTermsState>(
            bloc: _acceptTermsCubit,
            builder: (context, state) {
              /// UnAuthorizedGetAcceptTerms
              if (state is UnAuthorizedAcceptTerms) {
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
              if (state is NotActivatedUserToAcceptTerms) {
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
              if (state is ErrorWhileAcceptingTerms) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () {
                      _sendAcceptTerms();
                    },
                  ),
                );
              }

              return widget.acceptTermsEntity != null
                  ? _html(widget.acceptTermsEntity!)
                  : BlocBuilder<GetAcceptTermsCubit, GetAcceptTermsState>(
                      builder: (context, state) {
                        /*
                *
                * loading
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
                                _sendAcceptTerms();
                              },
                            ),
                          );
                        }

                        /*
                      *
                      *
                      * success
                      *
                      * */
                        if (state is TermsNotAcceptedYet) {
                          return _html(state.acceptTermsEntity);
                        }

                        /// else
                        return const SizedBox.shrink();
                      },
                    );
            },
          ),
        ),
      ),
    );
  }

  /// validate checkbox selection
  bool _validateCheckBox(BuildContext context) {
    if (!_isTermsAccepted) {
      setState(() {
        _showCheckBoxError = true;
        _scrollToBottom();
      });
      return false;
    }

    setState(() {
      _showCheckBoxError = false;
    });
    return true;
  }

  /// to scroll to the bottom
  void _scrollToBottom() => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// send accept terms
  void _sendAcceptTerms() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _acceptTermsCubit.sendAcceptTerms(token: userToken);
  }

  /// to fetch acceptTerms
  void _fetchAcceptTerms() {
    _getAcceptTermsCubit.getAcceptTerms(token: getUserToken(context));
  }

  Widget _html(AcceptTermsEntity acceptTermsEntity) {
    return Column(
      children: [
        HtmlWidget(
          // the first parameter (`html`) is required
          '''
${acceptTermsEntity.pages[0].sections[0].description}
  
  ''',

          // all other parameters are optional, a few notable params:

          // specify custom styling for an element
          // see supported inline styling below
          customStylesBuilder: (element) {
            if (element.classes.contains('foo')) {
              return {'color': 'red'};
            }

            return null;
          },

          // render a custom widget
          // customWidgetBuilder: (element) {
          //   if (element.attributes['foo'] == 'bar') {
          //     return FooBarWidget();
          //   }
          //
          //   return null;
          // },

          // these callbacks are called when a complicated element is loading
          // or failed to render allowing the app to render progress indicator
          // and fallback widget
          onErrorBuilder: (context, element, error) =>
              Text('$element error: $error'),
          onLoadingBuilder: (context, element, loadingProgress) =>
              const CircularProgressIndicator(),

          // this callback will be triggered when user taps a link
          //onTapUrl: (url) => print('tapped $url'),

          // select the render mode for HTML body
          // by default, a simple `Column` is rendered
          // consider using `ListView` or `SliverList` for better performance
          renderMode: RenderMode.column,

          // set the default styling for text
          textStyle: const TextStyle(fontSize: 14),
        ),
        AppCheckBoxTile(
          onChanged: (isChecked) {
            final currentValue = isChecked ?? false;
            if (currentValue) {
              setState(() {
                _showCheckBoxError = false;
              });
            }
            _isTermsAccepted = currentValue;
          },
          hasError: _showCheckBoxError,
          text: "اوافق على شروط الاتفاقية و اتحمل كامل المسؤولية القانونية",
        ),
      ],
    );
  }
}
