import 'package:flutter/material.dart';
import 'package:yamaiter/router/route_list.dart';

import '../domain/entities/screen_arguments/side_menu_page_args.dart';

class RouteHelper {
  RouteHelper();

  /// To main screen \\\
  void main(BuildContext context, {required bool isClearStack}) {
    isClearStack
        ? Navigator.of(context)
            .pushNamedAndRemoveUntil(RouteList.mainScreen, (route) => false)
        : Navigator.of(context).pushNamed(RouteList.mainScreen);
  }

  /// To chooseUserType screen \\\
  void chooseUserType(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteList.chooseUserType, (route) => false);
  }

  /// To registerLawyer screen \\\
  void registerLawyer(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.registerLawyer);
  }

  /// To registerClient screen \\\
  void registerClient(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.registerClient);
  }

  /// To registerClient screen \\\
  void loginScreen(BuildContext context, {required bool isClearStack}) {
    isClearStack
        ? Navigator.of(context)
            .pushNamedAndRemoveUntil(RouteList.loginScreen, (route) => false)
        : Navigator.of(context).pushNamed(RouteList.loginScreen);
  }

  /// To forget password screen \\\
  void forgetPassword(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.forgetPassword);
  }

  /// To about screen \\\
  void aboutScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.about);
  }

  /// To terms and conditions screen \\\
  void sideMenuPage(BuildContext context,
      {required SideMenuPageArguments arguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.sideMenuPage, arguments: arguments);
  }

  /// To edit profile screen \\\
  void editProfile(BuildContext context,) {
    Navigator.of(context)
        .pushNamed(RouteList.editProfile);
  }

  /// To settings screen \\\
  void settingsScreen(BuildContext context,) {
    Navigator.of(context)
        .pushNamed(RouteList.settings);
  }

  /// To editPassword screen \\\
  void editPasswordScreen(BuildContext context,) {
    Navigator.of(context)
        .pushNamed(RouteList.editPassword);
  }

  /// To help screen \\\
  void helpScreen(BuildContext context,) {
    Navigator.of(context)
        .pushNamed(RouteList.help);
  }
}
