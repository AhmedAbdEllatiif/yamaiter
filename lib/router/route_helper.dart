import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/screen_arguments/add_tax_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_article_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_sos_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_article_screen_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_article_screen_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_sos_screen_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/update_article_args.dart';
import 'package:yamaiter/router/route_list.dart';

import '../domain/entities/screen_arguments/add_article_args.dart';
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
  void editProfile(
    BuildContext context,
  ) {
    Navigator.of(context).pushNamed(RouteList.editProfile);
  }

  /// To settings screen \\\
  void settingsScreen(
    BuildContext context,
  ) {
    Navigator.of(context).pushNamed(RouteList.settings);
  }

  /// To add new ad screen \\\
  void addNewAdScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.addNewAd);
  }

  /// To my ads screen \\\
  void myAdsScreen(BuildContext context, {bool isReplacement = false}) {
    if (isReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.myAds);
    } else {
      Navigator.of(context).pushNamed(RouteList.myAds);
    }
  }

  /// To editPassword screen \\\
  void editPasswordScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.editPassword);
  }

  /// To help screen \\\
  void helpScreen(
    BuildContext context,
  ) {
    Navigator.of(context).pushNamed(RouteList.help);
  }

  /// To create tax screen \\\
  void createTaxScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.createTax);
  }

  /// To add new  screen \\\
  void addNewTaxScreen(BuildContext context,
      {required AddTaxArguments addTaxArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.addNewTax, arguments: addTaxArguments);
  }

  /// To my ads screen \\\
  void myTaxesScreen(BuildContext context, {bool isReplacement = false}) {
    if (isReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.myTaxes);
    } else {
      Navigator.of(context).pushNamed(RouteList.myTaxes);
    }
  }

  /// To create ad screen \\\
  void createAdScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.createAd);
  }

  /// To create sos screen \\\
  void createSos(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.createSos);
  }

  /// To create sos screen \\\
  void addSos(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.addSos);
  }

  /// To create sos screen \\\
  void deleteSos(BuildContext context,
      {required DeleteSosArguments deleteSosArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.deleteSos, arguments: deleteSosArguments);
  }

  /// To my sos screen \\\
  void mySosScreen(BuildContext context, {bool isReplacement = false}) {
    if (isReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.mySos);
    } else {
      Navigator.of(context).pushNamed(RouteList.mySos);
    }
  }

  /// To single sos screen \\\
  void singleSosScreen(BuildContext context,
      {required SingleScreenArguments arguments}) {
    Navigator.of(context).pushNamed(RouteList.singleSos, arguments: arguments);
  }

  /// To create article screen \\\
  void createArticleScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.createArticle);
  }

  /// To add article screen \\\
  void addArticle(BuildContext context,
      {required AddArticleArguments arguments}) {
    Navigator.of(context).pushNamed(RouteList.addArticle, arguments: arguments);
  }

  /// To create my articles screen \\\
  void myArticlesScreen(BuildContext context, {required bool isReplacement}) {
    if (isReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.myArticles);
    } else {
      Navigator.of(context).pushNamed(RouteList.myArticles);
    }
  }

  /// To update article screen \\\
  void updateArticle(BuildContext context,
      {required UpdateArticleArguments arguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.updateArticle, arguments: arguments);
  }

  /// To single article screen \\\
  void singleArticleScreen(BuildContext context,
      {required int articleId, bool isReplacement = false}) {
    if (isReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.singleArticle,
          arguments: SingleArticleArguments(articleId: articleId));
    } else {
      Navigator.of(context).pushNamed(RouteList.singleArticle,
          arguments: SingleArticleArguments(articleId: articleId));
    }
  }

  /// To delete article screen \\\
  void deleteArticleScreen(BuildContext context,
      {required DeleteArticleArguments arguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.deleteArticle, arguments: arguments);
  }

  /// To contact us screen \\\
  void contactUsScreen(
    BuildContext context,
  ) {
    throw (UnimplementedError("Create Contact us screen"));
  }
}
