import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import '../common/extensions/size_extensions.dart';
import '../presentation/journeys/choose_user_type/choose_user_type_screen.dart';
import '../presentation/journeys/main/main_screen.dart';
import '../presentation/themes/theme_color.dart';
import '../router/transition_page_route.dart';

import 'dart:math' as math;



import '../common/constants/sizes.dart';
import '../router/routes.dart';


class BaseMaterialApp extends StatelessWidget {
  const BaseMaterialApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YaMaiter',
      //navigatorKey: navigatorKey,

      /// builder ==> build with ResponsiveWrapper and break points
      builder: (context, widget) =>
          Directionality(
            textDirection: TextDirection.rtl,
            child: ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              defaultScale: true,
              breakpoints: [
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
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppColor.accentColor, // Your accent color
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
          cardTheme: CardTheme(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
            ),
          )),

      /// home
      home: const ChooseUserTypeScreen(),
      onGenerateRoute: (RouteSettings settings) {
        final routes = Routes.getRoutes(settings);
        final WidgetBuilder? builder = routes[settings.name];
        return TransitionPageRouteBuilder(
          builder: builder!,
          customSettings: settings,
        );
      },
    );
  }


}