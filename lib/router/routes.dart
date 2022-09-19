import 'package:flutter/material.dart';
import 'package:yamaiter/presentation/journeys/register_client/register_client_screen.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/register_lawyer_screen.dart';
import '../presentation/journeys/main/main_screen.dart';
import 'route_list.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        RouteList.mainScreen: (context) => const MainScreen(),
        RouteList.registerLawyer: (context) => const RegisterLawyerScreen(),
        RouteList.registerClient: (context) => const RegisterClientScreen(),
        //RouteList.loginScreen: (context) => const LoginPage(),
      };
}
