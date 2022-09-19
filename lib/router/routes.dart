import 'package:flutter/material.dart';
import 'package:yamaiter/presentation/journeys/choose_user_type/choose_user_type_screen.dart';
import 'package:yamaiter/presentation/journeys/forget_password/forget_password_screen.dart';
import 'package:yamaiter/presentation/journeys/login/login_screen.dart';
import 'package:yamaiter/presentation/journeys/register_client/register_client_screen.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/register_lawyer_screen.dart';
import '../presentation/journeys/main/main_screen.dart';
import 'route_list.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        RouteList.mainScreen: (context) => const MainScreen(),
        RouteList.registerLawyer: (context) => const RegisterLawyerScreen(),
        RouteList.registerClient: (context) => const RegisterClientScreen(),
        RouteList.loginScreen: (context) =>  LoginScreen(),
        RouteList.forgetPassword: (context) =>  const ForgetPasswordScreen(),
        RouteList.chooseUserType: (context) =>  const ChooseUserTypeScreen(),
      };
}
