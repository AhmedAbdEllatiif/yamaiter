import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/data/accept_terms/accept_terms_entity.dart';
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
  final AcceptTermsEntity acceptTermsEntity;
  final AcceptTermsCubit? acceptTermsCubit;

  const AcceptTermsWidget(
      {Key? key, required this.acceptTermsEntity, this.acceptTermsCubit})
      : super(key: key);

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

  @override
  void initState() {
    super.initState();
    _acceptTermsCubit =
        widget.acceptTermsCubit ?? getItInstance<AcceptTermsCubit>();
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
    return BlocProvider(
      create: (context) => _acceptTermsCubit,
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
              text: "إذهب لاضافة بيانات المهمة المطلوبة",
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

            return Column(
              children: [
                HtmlWidget(
                  // the first parameter (`html`) is required
                  '''
${widget.acceptTermsEntity.pages[0].sections[0].description}
  
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
                  text:
                      "اوافق على شروط الاتفاقية و اتحمل كامل المسؤولية القانونية",
                ),
              ],
            );

            // return ListView.separated(
            //   shrinkWrap: true,
            //   physics: const BouncingScrollPhysics(),
            //   separatorBuilder: (_, index) =>
            //       SizedBox(height: Sizes.dimen_10.h),
            //   itemCount: widget.acceptTermsEntity.pages[0].sections.length,
            //   itemBuilder: (_, index) {
            //     return Column(
            //       children: [
            //         Text(
            //           widget.acceptTermsEntity.pages[0].sections[index]
            //               .description,
            //           overflow: TextOverflow.clip,
            //           //maxLines: 500,
            //           textAlign: TextAlign.start,
            //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //                 color: AppColor.primaryDarkColor,
            //               ),
            //         ),
            //
            //         //==> space
            //         SizedBox(height: Sizes.dimen_8.h),
            //
            //         // checkBox
            //         AppCheckBoxTile(
            //           onChanged: (isChecked) {
            //             final currentValue = isChecked ?? false;
            //             if (currentValue) {
            //               setState(() {
            //                 _showCheckBoxError = false;
            //               });
            //             }
            //             _isTermsAccepted = currentValue;
            //           },
            //           hasError: _showCheckBoxError,
            //           text:
            //               "اوافق على شروط الاتفاقية و اتحمل كامل المسؤولية القانونية",
            //         ),
            //       ],
            //     );
            //   },
            // );
          },
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
}
