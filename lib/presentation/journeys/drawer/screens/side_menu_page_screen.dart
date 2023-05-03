import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/presentation/logic/cubit/side_menu_page/side_menu_page_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/web_view_widget.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../common/functions/navigate_to_login.dart';
import '../../../../common/functions/open_url.dart';
import '../../../../di/git_it_instance.dart';
import '../../../../domain/entities/screen_arguments/side_menu_page_args.dart';
import '../../../widgets/loading_widget.dart';

class AboutUsScreen extends StatefulWidget {
  final SideMenuPageArguments sideMenuPageArguments;

  const AboutUsScreen({Key? key, required this.sideMenuPageArguments})
      : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  /// SideMenuPageCubit
  late final AboutUsPageCubit _aboutUsPageCubit;

  /// page title
  late final String _pageTitle;

  @override
  void initState() {
    super.initState();
    _aboutUsPageCubit = getItInstance<AboutUsPageCubit>();
    _fetchAbout();

    _pageTitle = widget.sideMenuPageArguments.pageTitle;
  }

  @override
  void dispose() {
    _aboutUsPageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _aboutUsPageCubit,
      child: Scaffold(
        /// appBar
        appBar: AppBar(title: Text(_pageTitle)),

        /// body
        body: BlocBuilder<AboutUsPageCubit, AboutUsPageState>(
          builder: (context, state) {
            /*
            *
            *
            * loading
            *
            *
            * */
            if (state is LoadingAboutUsPage) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            /*
            *
            *
            * unAuthorized
            *
            *
            * */
            if (state is UnAuthorizedToFetchAboutUsPage) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.unauthorizedUser,
                  onPressedRetry: () => navigateToLogin(context),
                ),
              );
            }

            /*
            *
            *
            * error
            *
            *
            * */
            if (state is ErrorWhileGettingAboutUsPage) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchAbout(),
                ),
              );
            }

            /*
            *
            *
            * url fetched successfully
            *
            *
            * */
            if (state is AboutUsPageFetchedSuccess) {
              return CustomWebViewWidget(url: state.sideMenuPages.url);
            }

            /*
            *
            *
            * else
            *
            *
            * */
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void launcjjj(String url)async {
    openUrl(url: url);

  }

  void _fetchAbout() {
    log("sideMenuPage >> ${widget.sideMenuPageArguments.sideMenuPage}");
    // init userToken
    final userToken = getUserToken(context);

    // request about
    _aboutUsPageCubit.getAppSideMenuData(
        userToken: userToken,
        sideMenuPage: widget.sideMenuPageArguments.sideMenuPage);
  }
}
