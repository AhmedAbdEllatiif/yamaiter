import 'package:flutter/material.dart';
import 'package:yamaiter/router/route_list.dart';

class RouteHelper {
  RouteHelper();

  /// To offline screens page \\\
  void main(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.mainScreen);
  }

  /// To offline screens page \\\
  void registerLawyer(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.registerLawyer);
  }


  /// To offline screens page \\\
  void registerClient(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.registerClient);
  }
}
