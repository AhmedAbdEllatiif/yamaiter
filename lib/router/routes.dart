import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/screen_arguments/side_menu_page_args.dart';
import 'package:yamaiter/presentation/journeys/choose_user_type/choose_user_type_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/side_menu_page_screen.dart';
import 'package:yamaiter/presentation/journeys/forget_password/forget_password_screen.dart';
import 'package:yamaiter/presentation/journeys/login/login_screen.dart';
import 'package:yamaiter/presentation/journeys/register_client/register_client_screen.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/register_lawyer_screen.dart';
import '../presentation/journeys/main/main_screen.dart';
import 'route_list.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        /// mainScreen
        RouteList.mainScreen: (context) => const MainScreen(),

        /// registerLawyer
        RouteList.registerLawyer: (context) => const RegisterLawyerScreen(),

        /// registerClient
        RouteList.registerClient: (context) => const RegisterClientScreen(),

        /// loginScreen
        RouteList.loginScreen: (context) => const LoginScreen(),

        /// forgetPassword
        RouteList.forgetPassword: (context) => const ForgetPasswordScreen(),

        /// chooseUserType
        RouteList.chooseUserType: (context) => const ChooseUserTypeScreen(),

        /// SideMenuPageScreen
        RouteList.sideMenuPage: (context) => SideMenuPageScreen(
              sideMenuPageArguments:
                  settings.arguments as SideMenuPageArguments,
            ),
      };
}
