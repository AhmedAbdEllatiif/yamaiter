import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/main/main_screen.dart';
import 'package:yamaiter/presentation/journeys/payment/payment_screen.dart';
import 'package:yamaiter/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/user_token/user_token_cubit.dart';
import '../common/extensions/size_extensions.dart';
import '../presentation/journeys/on_boarding/on_boarding_screen.dart';
import '../presentation/journeys/sos/delete_sos.dart';
import '../presentation/themes/theme_color.dart';
import '../router/transition_page_route.dart';

import '../router/routes.dart';

class BaseMaterialApp extends StatefulWidget {
  const BaseMaterialApp({Key? key}) : super(key: key);

  @override
  State<BaseMaterialApp> createState() => _BaseMaterialAppState();
}

class _BaseMaterialAppState extends State<BaseMaterialApp> {
  late final UserTokenCubit userToken;
  late final AuthorizedUserCubit authorizedUserCubit;

  @override
  void initState() {
    //==> current user token
    userToken = getItInstance<UserTokenCubit>();
    userToken.loadCurrentAutoLoginStatus();
    //==> current authorized token
    authorizedUserCubit = getItInstance<AuthorizedUserCubit>();
    authorizedUserCubit.loadCurrentAuthorizedUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => userToken),
        BlocProvider(create: (context) => authorizedUserCubit),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YaMaiter',
        //navigatorKey: navigatorKey,

        /// builder ==> build with ResponsiveWrapper and break points
        builder: (context, widget) => Directionality(
          textDirection: TextDirection.rtl,
          child: ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            maxWidth: 1200,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.autoScale(220, name: "S"),
              const ResponsiveBreakpoint.resize(350, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(600, name: TABLET),
              const ResponsiveBreakpoint.resize(800, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
            ],
          ),
        ),

        /// main theme
        theme: ThemeData(
            textTheme: GoogleFonts.cairoTextTheme(
              Theme.of(context).textTheme,
            ),
            primaryColor: AppColor.primaryDarkColor,
            primaryColorDark: AppColor.primaryDarkColor,
            splashColor: AppColor.accentColor.withOpacity(0.3),
            shadowColor: AppColor.accentColor,
            unselectedWidgetColor: AppColor.white,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: AppColor.accentColor, // Your accent color
            ),

            /// navigationBarTheme
            navigationBarTheme: NavigationBarThemeData(
              height: 65,
              indicatorColor: AppColor.accentColor,
              //indicatorColor: Colors.transparent,
              backgroundColor: AppColor.primaryDarkColor,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              indicatorShape: const CircleBorder(),
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(
                  //fontSize: 13.0,
                  //fontWeight: FontWeight.w700,
                  color: AppColor.white,
                  //letterSpacing: 1.0,
                ),
              ),
            ),

            /// appBar theme
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColor.primaryDarkColor,
              elevation: 0.0,
              centerTitle: true,
            ),

            /// scaffoldBackgroundColor
            scaffoldBackgroundColor: Colors.white,

            /// default card theme
            cardTheme: const CardTheme(
              elevation: 10.0,
              shadowColor: AppColor.black,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppUtils.cornerRadius)),
              ),
            )),

        /// home
        home: MainScreen(),
        // home: BlocBuilder<UserTokenCubit, UserTokenState>(
        //   builder: (context, state) {
        //     if (state.userToken.isNotEmpty) {
        //       return const MainScreen();
        //     }
        //     return const OnBoardingScreen();
        //   },
        // ),
        onGenerateRoute: (RouteSettings settings) {
          final routes = Routes.getRoutes(settings);
          final WidgetBuilder? builder = routes[settings.name];
          return TransitionPageRouteBuilder(
            builder: builder!,
            customSettings: settings,
          );
        },
      ),
    );
  }

  /// dispose
  @override
  void dispose() {
    userToken.close();
    super.dispose();
  }
}
