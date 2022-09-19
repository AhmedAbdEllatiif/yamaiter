import 'package:flutter/material.dart';
import 'package:yamaiter/router/route_list.dart';

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
}
