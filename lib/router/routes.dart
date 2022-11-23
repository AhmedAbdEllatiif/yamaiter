import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/screen_arguments/add_sos_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/add_tax_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/create_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/decline_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_article_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/edit_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/end_task_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/invite_lawyer_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/invite_task_details_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/side_menu_page_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_article_screen_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_sos_screen_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_task_details_params.dart';
import 'package:yamaiter/domain/entities/screen_arguments/task_details_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/update_sos_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/upload_file_args.dart';
import 'package:yamaiter/presentation/journeys/ads/create_ad_screen.dart';
import 'package:yamaiter/presentation/journeys/article/update_article/update_article_screen.dart';
import 'package:yamaiter/presentation/journeys/choose_user_type/choose_user_type_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/edit_password_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/edit_profile/edit_profile.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/help/help_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_sos/my_sos_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/applied_tasks/upload_file_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/choose_tasks/choose_my_tasks_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/invited_tasks/decline_task/decline_task_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/invited_tasks/invited_tasks_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/delete_task/delete_task_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/edit_task/edit_task_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/end_task/end_task_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/my_tasks_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/single_task/single_task_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_taxes/my_taxes_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/settings/settings_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/side_menu_page_screen.dart';
import 'package:yamaiter/presentation/journeys/forget_password/forget_password_screen.dart';
import 'package:yamaiter/presentation/journeys/login/login_screen.dart';
import 'package:yamaiter/presentation/journeys/register_client/register_client_screen.dart';
import 'package:yamaiter/presentation/journeys/reigster_lawyer/register_lawyer_screen.dart';
import 'package:yamaiter/presentation/journeys/search_for_lawyer/search_for_lawyer_screen.dart';
import 'package:yamaiter/presentation/journeys/sos/add_sos_screen.dart';
import 'package:yamaiter/presentation/journeys/sos/delete_sos.dart';
import 'package:yamaiter/presentation/journeys/sos/single_sos_screen.dart';
import 'package:yamaiter/presentation/journeys/sos/update_sos/update_sos_screen.dart';
import 'package:yamaiter/presentation/journeys/task/create_task_screen.dart';
import 'package:yamaiter/presentation/journeys/task_details/task_details_screen.dart';
import 'package:yamaiter/presentation/logic/cubit/create_tax/create_tax_cubit.dart';
import '../domain/entities/screen_arguments/add_article_args.dart';
import '../domain/entities/screen_arguments/add_new_ad_args.dart';
import '../domain/entities/screen_arguments/apply_for_task_args.dart';
import '../domain/entities/screen_arguments/delete_sos_args.dart';
import '../domain/entities/screen_arguments/search_result_args.dart';
import '../domain/entities/screen_arguments/update_article_args.dart';
import '../presentation/journeys/ads/add_new_ad.dart';
import '../presentation/journeys/article/create_article/add_article.dart';
import '../presentation/journeys/article/create_article/create_article_screen.dart';
import '../presentation/journeys/article/delete_article.dart';
import '../presentation/journeys/article/single_article_screen.dart';
import '../presentation/journeys/drawer/screens/my_ads/my_ads_screen.dart';
import '../presentation/journeys/drawer/screens/my_articles/my_articles_screen.dart';
import '../presentation/journeys/drawer/screens/my_tasks/applied_tasks/tasks_for_other_screen.dart';
import '../presentation/journeys/drawer/screens/my_tasks/invited_tasks/invited_task_details/invited_task_details_screen.dart';
import '../presentation/journeys/invite_lawyer/invite_lawyer_screen.dart';
import '../presentation/journeys/main/main_screen.dart';
import '../presentation/journeys/search_result_for_lawyers/search_result_for_lawyers.dart';
import '../presentation/journeys/sos/create_sos_screen.dart';
import '../presentation/journeys/apply_for_task/appy_for_task_screen.dart';
import '../presentation/journeys/taxes/add_new_tax_screen.dart';
import '../presentation/journeys/taxes/create_tax_screen.dart';
import 'route_list.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        /// mainScreen
        RouteList.mainScreen: (context) => const MainScreen(),

        /// searchForLawyerScreen
        RouteList.searchForLawyer: (context) => const SearchForLawyerScreen(),

        /// searchResult
        RouteList.searchResult: (context) => SearchResultForLawyers(
              arguments: settings.arguments as SearchResultArguments,
            ),

        /// inviteLawyer
        RouteList.inviteLawyer: (context) => InviteLawyerScreen(
              inviteLawyerArguments:
                  settings.arguments as InviteLawyerArguments,
            ),

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

        /// createTask
        RouteList.createTask: (context) => CreateTaskScreen(
              createTaskArguments: settings.arguments as CreateTaskArguments,
            ),

        /// MyTasksScreen
        RouteList.myTasks: (context) => const MyTasksScreen(),

        /// ChooseTasksScreen
        RouteList.chooseTasks: (context) => const ChooseTasksScreen(),

        /// edit task
        RouteList.editTask: (context) => EditTaskScreen(
              editTaskArguments: settings.arguments as EditTaskArguments,
            ),

        /// delete task
        RouteList.deleteTask: (context) => DeleteTaskScreen(
              deleteTaskArguments: settings.arguments as DeleteTaskArguments,
            ),

        /// single task
        RouteList.singleTask: (context) => SingleTaskScreen(
              singleTaskParams: settings.arguments as SingleTaskArguments,
            ),

        /// end task
        RouteList.endTask: (context) => EndTaskScreen(
              endTaskArguments: settings.arguments as EndTaskArguments,
            ),

        /// tasks for other
        RouteList.tasksForOther: (context) => const TasksForOtherScreen(),

        /// task details
        RouteList.taskDetails: (context) => TaskDetailsScreen(
              taskDetailsArguments: settings.arguments as TaskDetailsArguments,
            ),

        /// apply for task
        RouteList.applyForTask: (context) => ApplyForTaskScreen(
              applyForTaskArgument: settings.arguments as ApplyForTaskArguments,
            ),

        /// upload task file
        RouteList.uploadTaskFile: (context) => UploadFileScreen(
              uploadTaskFileArguments:
                  settings.arguments as UploadTaskFileArguments,
            ),

        /// invitedTasks
        RouteList.invitedTasks: (context) => const InvitedTasksScreen(),

        /// InvitedTaskDetailsScreen
        RouteList.invitedTaskDetails: (context) => InvitedTaskDetailsScreen(
              arguments: settings.arguments as InvitedTaskDetailsArguments,
            ),

        /// DeclineTaskScreen
        RouteList.declineTask: (context) => DeclineTaskScreen(
              arguments: settings.arguments as DeclineTaskArguments,
            ),

        /// add sos
        RouteList.addSos: (context) => AddSosScreen(
              addSosArguments: settings.arguments as AddSosArguments,
            ),

        /// deleteSos
        RouteList.deleteSos: (context) => DeleteSosScreen(
            deleteSosArguments: settings.arguments as DeleteSosArguments),

        /// updateSos
        RouteList.updateSos: (context) => UpdateSosScreen(
              arguments: settings.arguments as UpdateSosArguments,
            ),

        /// CreateArticleScreen
        RouteList.createArticle: (context) => const CreateArticleScreen(),

        /// MyArticlesScreen
        RouteList.myArticles: (context) => const MyArticlesScreen(),

        /// MyArticlesScreen
        RouteList.singleArticle: (context) => SingleArticleScreen(
            singleArticleArguments:
                settings.arguments as SingleArticleArguments),

        /// AddArticleScreen
        RouteList.addArticle: (context) => AddArticleScreen(
              addArticleArguments: settings.arguments as AddArticleArguments,
            ),

        /// UpdateArticleScreen
        RouteList.updateArticle: (context) => UpdateArticleScreen(
              updateArticleArguments:
                  settings.arguments as UpdateArticleArguments,
            ),

        /// deleteSos
        RouteList.deleteArticle: (context) => DeleteArticleScreen(
            deleteArticleArguments:
                settings.arguments as DeleteArticleArguments),

        /// createAd
        RouteList.createAd: (context) => const CreateAdScreen(),

        /// myAds
        RouteList.myAds: (context) => const MyAdsScreen(),

        /// AddNewAdScreen
        RouteList.addNewAd: (context) => AddNewAdScreen(
              addNewAdArguments: settings.arguments as AddNewAdArguments,
            ),

        /// CreateTaxScreen
        RouteList.createTax: (context) => const CreateTaxScreen(),

        /// MyTaxesScreen
        RouteList.myTaxes: (context) => const MyTaxesScreen(),

        /// AddNewTaxScreen
        RouteList.addNewTax: (context) => AddNewTaxScreen(
              addTaxArguments: settings.arguments as AddTaxArguments,
            ),

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
