import 'package:flutter/cupertino.dart';
import 'package:yamaiter/router/route_helper.dart';

void navigateToLogin(BuildContext context) {
  RouteHelper().loginScreen(context, isClearStack: true);
}
