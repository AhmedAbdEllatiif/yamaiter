import 'package:flutter/material.dart';
import '../presentation/journeys/main/main_screen.dart';
import 'route_list.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        RouteList.mainScreen: (context) => const MainScreen(),
        //RouteList.loginScreen: (context) => const LoginPage(),
      };
}
