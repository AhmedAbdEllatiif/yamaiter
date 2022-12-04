import 'package:flutter/material.dart';
import 'package:yamaiter/common/enum/task_status.dart';
import 'package:yamaiter/domain/entities/screen_arguments/add_sos_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/add_tax_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/apply_for_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/create_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/create_task_args_client.dart';
import 'package:yamaiter/domain/entities/screen_arguments/decline_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_article_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_sos_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/edit_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/end_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/filterd_tasks_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/invite_lawyer_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/invite_task_details_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/my_tasks_client_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/my_tasks_client_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/my_tasks_client_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/search_result_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_article_screen_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_sos_screen_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_task_client_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_task_details_params.dart';
import 'package:yamaiter/domain/entities/screen_arguments/task_details_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/update_article_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/update_sos_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/upload_file_args.dart';
import 'package:yamaiter/router/route_list.dart';

import '../domain/entities/screen_arguments/add_article_args.dart';
import '../domain/entities/screen_arguments/add_new_ad_args.dart';
import '../domain/entities/screen_arguments/my_task_args.dart';
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

  /// To search for lawyer screen \\\
  void searchForLawyer(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.searchForLawyer);
  }

  /// To search result screen \\\
  void searchResult(BuildContext context,
      {required SearchResultArguments searchResultArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.searchResult, arguments: searchResultArguments);
  }

  /// To invite lawyer screen \\\
  void inviteLawyer(BuildContext context,
      {required InviteLawyerArguments inviteLawyerArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.inviteLawyer, arguments: inviteLawyerArguments);
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
  void addNewAdScreen(BuildContext context,
      {required AddNewAdArguments addNewAdArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.addNewAd, arguments: addNewAdArguments);
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

  /// To choose my_tasks screen \\\
  void chooseTasks(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.chooseTasks);
  }

  /// To filter tasks screen \\\
  void filterTasks(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.filterTasks);
  }

  /// To my consultations screen \\\
  void myConsultations(
    BuildContext context, {
    bool isReplacement = false,
  }) {
    if (isReplacement) {
      Navigator.of(context).pushReplacementNamed(
        RouteList.myConsultations,
      );
    } else {
      Navigator.of(context).pushNamed(RouteList.myConsultations);
    }
  }

  /// To request a consultation screen \\\
  void requestAConsultation(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.requestAConsultation);
  }

  /// To filtered tasks result screen \\\
  void filteredTasksResult(BuildContext context,
      {required FilteredTasksArguments filteredTasksArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.filteredTasks, arguments: filteredTasksArguments);
  }

  /// To create task screen \\\
  void createTask(BuildContext context,
      {required CreateTaskArguments? createTaskArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.createTask, arguments: createTaskArguments);
  }

  /// To create task client screen \\\
  void createTaskClient(BuildContext context,
      {required CreateTaskArgumentsClient? createTaskArgumentsClient}) {
    Navigator.of(context).pushNamed(RouteList.createTaskClient,
        arguments: createTaskArgumentsClient);
  }

  /// To  my_tasks_client screen \\\
  void myTasksClient(
    BuildContext context, {
    bool isReplacement = false,
    bool isPushNamedAndRemoveUntil = false,
    TaskType taskType = TaskType.todo,
  }) {
    if (isReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.myTasksClient,
          arguments: MyTasksClientArguments(taskType: taskType));
    } else if (isPushNamedAndRemoveUntil) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteList.myTasksClient, (Route<dynamic> route) => route.isFirst,
          arguments: MyTasksClientArguments(taskType: taskType));
    } else {
      Navigator.of(context).pushNamed(RouteList.myTasksClient,
          arguments: MyTasksClientArguments(taskType: taskType));
    }
  }

  /// To single task client screen \\\
  void singleTaskClient(BuildContext context,
      {required SingleTaskClientArguments singleTaskClientArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.singleTaskClient, arguments: singleTaskClientArguments);
  }

  /// To edit task screen \\\
  void editTask(BuildContext context,
      {required EditTaskArguments editTaskArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.editTask, arguments: editTaskArguments);
  }

  /// To single task screen \\\
  void singleTask(BuildContext context,
      {required SingleTaskArguments editTaskArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.singleTask, arguments: editTaskArguments);
  }

  /// To end task screen \\\
  void endTask(BuildContext context,
      {required EndTaskArguments endTaskArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.endTask, arguments: endTaskArguments);
  }

  /// To delete task screen \\\
  void deleteTask(BuildContext context,
      {required DeleteTaskArguments deleteTaskArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.deleteTask, arguments: deleteTaskArguments);
  }

  /// To my my_tasks screen \\\
  void myTasks(BuildContext context,
      {bool isReplacement = false,
      bool isPushNamedAndRemoveUntil = false,
      TaskType taskType = TaskType.todo}) {
    if (isReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.myTasks,
          arguments: MyTasksArguments(taskType: taskType));
    } else if (isPushNamedAndRemoveUntil) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteList.myTasks, (Route<dynamic> route) => route.isFirst,
          arguments: MyTasksArguments(taskType: taskType));
    } else {
      Navigator.of(context).pushNamed(RouteList.myTasks,
          arguments: MyTasksArguments(taskType: taskType));
    }
  }

  /// To choose tasks for other screen \\\
  void appliedTasksScreen(BuildContext context,
      {bool isPushReplacement = false}) {
    if (isPushReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.tasksForOther);
    } else {
      Navigator.of(context).pushNamed(RouteList.tasksForOther);
    }
  }

  /// To task details screen \\\
  void taskDetails(BuildContext context,
      {required TaskDetailsArguments taskDetailsArguments,
      bool isPushReplacement = false}) {
    if (isPushReplacement) {
      Navigator.of(context).pushReplacementNamed(RouteList.taskDetails,
          arguments: taskDetailsArguments);
    } else {
      Navigator.of(context)
          .pushNamed(RouteList.taskDetails, arguments: taskDetailsArguments);
    }
  }

  /// To apply for task screen \\\
  void applyForTask(BuildContext context,
      {required ApplyForTaskArguments applyForTaskArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.applyForTask, arguments: applyForTaskArguments);
  }

  /// To upload task file screen \\\
  void uploadTaskFile(BuildContext context,
      {required UploadTaskFileArguments uploadTaskFileArguments}) {
    Navigator.of(context).pushNamed(RouteList.uploadTaskFile,
        arguments: uploadTaskFileArguments);
  }

  /// To invited tasks screen \\\
  void invitedTasksScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RouteList.invitedTasks);
  }

  /// To invite task details screen \\\
  void inviteTaskDetails(BuildContext context,
      {required InvitedTaskDetailsArguments invitedTaskDetailsArguments}) {
    Navigator.of(context).pushNamed(RouteList.invitedTaskDetails,
        arguments: invitedTaskDetailsArguments);
  }

  /// To decline task  screen \\\
  void declineTask(BuildContext context,
      {required DeclineTaskArguments declineTaskArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.declineTask, arguments: declineTaskArguments);
  }

  /// To create sos screen \\\
  void addSos(BuildContext context,
      {required AddSosArguments addSosArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.addSos, arguments: addSosArguments);
  }

  /// To create sos screen \\\
  void deleteSos(BuildContext context,
      {required DeleteSosArguments deleteSosArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.deleteSos, arguments: deleteSosArguments);
  }

  /// To update sos screen \\\
  void updateSos(BuildContext context,
      {required UpdateSosArguments updateSosArguments}) {
    Navigator.of(context)
        .pushNamed(RouteList.updateSos, arguments: updateSosArguments);
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
