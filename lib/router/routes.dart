import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/screen_arguments/side_menu_page_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_sos_screen_args.dart';
import 'package:yamaiter/presentation/journeys/choose_user_type/choose_user_type_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/edit_password_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/edit_profile/edit_profile.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/help/help_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_sos/my_sos_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/settings/settings_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/side_menu_page_screen.dart';
import 'package:yamaiter/presentation/journeys/forget_password/forget_password_screen.dart';
import 'package:yamaiter/presentation/journeys/login/login_screen.dart';
import 'package:yamaiter/presentation/journeys/register_client/register_client_screen.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/register_lawyer_screen.dart';
import 'package:yamaiter/presentation/journeys/sos/add_sos_screen.dart';
import 'package:yamaiter/presentation/journeys/sos/delete_sos.dart';
import 'package:yamaiter/presentation/journeys/sos/single_sos_screen.dart';
import '../domain/entities/screen_arguments/delete_sos_args.dart';
import '../presentation/journeys/main/main_screen.dart';
import '../presentation/journeys/sos/create_sos_screen.dart';
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

        /// editProfile
        RouteList.editProfile: (context) => const EditProfileScreen(),

        /// settings
        RouteList.settings: (context) => const SettingsScreen(),

        /// editPassword
        RouteList.editPassword: (context) => const EditPasswordScreen(),

        /// help
        RouteList.help: (context) => const HelpScreen(),

        /// mySos
        RouteList.mySos: (context) => const MySosScreen(),

        /// createSos
        RouteList.createSos: (context) => const CreateSosScreen(),

        /// add sos
        RouteList.addSos: (context) => const AddSosScreen(),

        /// deleteSos
        RouteList.deleteSos: (context) => DeleteSosScreen(
            deleteSosArguments: settings.arguments as DeleteSosArguments),

        /// single sos
        RouteList.singleSos: (context) => SingleSosScreen(
              singleScreenArguments:
                  settings.arguments as SingleScreenArguments,
            ),

        /// SideMenuPageScreen
        RouteList.sideMenuPage: (context) => SideMenuPageScreen(
              sideMenuPageArguments:
                  settings.arguments as SideMenuPageArguments,
            ),
      };
}
