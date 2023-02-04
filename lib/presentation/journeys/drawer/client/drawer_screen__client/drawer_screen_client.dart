import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/side_menu_page.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/presentation/journeys/drawer/drawer_item.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../common/enum/animation_type.dart';
import '../../../../../domain/entities/screen_arguments/side_menu_page_args.dart';
import '../../../../logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../widgets/image_name_rating_widget.dart';

class DrawerScreenClient extends StatefulWidget {
  const DrawerScreenClient({Key? key}) : super(key: key);

  @override
  State<DrawerScreenClient> createState() => _DrawerScreenClientState();
}

class _DrawerScreenClientState extends State<DrawerScreenClient> {
  /// current authorized user
  late final AuthorizedUserEntity _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = context.read<AuthorizedUserCubit>().state.userEntity;
  }

  @override
  Widget build(BuildContext context) {
    final items = drawerItems(context);
    return Container(
      color: AppColor.primaryDarkColor,
      //padding: EdgeInsets.only(top: Sizes.dimen_1.h),
      child: Column(
        children: [
          Container(
            color: AppColor.primaryDarkColor,
            height: ScreenUtil.screenHeight * 0.15,
            padding: EdgeInsets.only(
                top: Sizes.dimen_10.h,
                right: Sizes.dimen_8.w,
                left: Sizes.dimen_8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Avatar and rating
                ImageNameRatingWidget(
                  name: _currentUser.firstName,
                  imgUrl: _currentUser.userAvatar,
                  showRating: false,
                  rating: 3,
                  onPressed: () {
                    RouteHelper().editProfile(context);
                  },
                ),
              ],
            ),
          ),

          SizedBox(
            width: ScreenUtil.screenWidth * 0.8,
            child: const Divider(
              color: AppColor.white,
            ),
          ),

          /// menu items
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return items[index].animate(
                    slideDuration: Duration(milliseconds: 300 + (70 * index)),
                    fadeDuration: Duration(milliseconds: 300 + (50 * index)),
                    map: {
                      AnimationType.slide: {
                        SlideOffset.begin: const Offset(0.5, 0.0),
                        SlideOffset.end: const Offset(0.0, 0.0),
                      },
                      AnimationType.fade: {
                        FadeOpacity.begin: 0.5,
                        FadeOpacity.end: 1.0,
                      },
                    });
              },
            ),
          )
        ],
      ),
    );
  }

  void _navigateChatScreen(BuildContext context) =>
      RouteHelper().chatListScreen(context);

  /// to MyTaskScreen
  void _navigateMyTasksScreen(BuildContext context) =>
      RouteHelper().myTasks(context);

  /// to MyConsultationsScreen
  void _navigateMyConsultationsScreen(BuildContext context) =>
      RouteHelper().myConsultations(context);

  /// to SettingsScreen
  void _navigateToSettingsScreen(BuildContext context) =>
      RouteHelper().settingsScreen(context);

  /// to MyAdsScreen
  void _navigateMyAdsListScreen(BuildContext context) =>
      RouteHelper().myAdsScreen(context, isReplacement: false);

  /// to AboutScreen
  void _navigateToAboutScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "من نحن", sideMenuPage: SideMenuPage.about),
      );

  /// to TermsAndConditionsScreen
  void _navigateToTermsAndConditionsScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "شروط الاستخدام",
            sideMenuPage: SideMenuPage.termsAndConditions),
      );

  /// to PrivacyScreen
  void _navigateToPrivacyScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "سياسة الخصوصية", sideMenuPage: SideMenuPage.privacy),
      );

  /// DrawerItems
  List<Widget> drawerItems(BuildContext context) => [
        DrawerItem(
          iconData: Icons.shopping_bag_outlined,
          title: "طلبات المساعدة القانونية",
          onPressed: () => _navigateMyTasksScreen(context),
        ),
        DrawerItem(
          iconData: Icons.list_alt_outlined,
          title: "استشاراتى القانونية",
          onPressed: () => _navigateMyConsultationsScreen(context),
        ),
        DrawerItem(
          iconData: Icons.surround_sound_outlined,
          title: "إعلاناتى",
          onPressed: () => _navigateMyAdsListScreen(context),
        ),
        DrawerItem(
          iconData: Icons.chat_outlined,
          title: "المحادثات",
          onPressed: () => _navigateChatScreen(context),
        ),

        DrawerItem(
          iconData: Icons.settings_outlined,
          title: "الاعدادت",
          onPressed: () => _navigateToSettingsScreen(context),
        ),

        /// about
        DrawerItem(
          iconData: Icons.info_outline,
          title: "من نحن",
          onPressed: () {
            _navigateToAboutScreen(context);
          },
        ),
        DrawerItem(
          iconData: Icons.shield_outlined,
          title: "سياسة الخصوصية",
          onPressed: () => _navigateToPrivacyScreen(context),
        ),
        DrawerItem(
          iconData: Icons.shield_outlined,
          title: "شروط الاستخدام",
          onPressed: () => _navigateToTermsAndConditionsScreen(context),
        ),
        DrawerItem(
          iconData: Icons.question_mark_outlined,
          title: "اتصل بنا",
          onPressed: () {},
        ),
        DrawerItem(
          iconData: Icons.logout_outlined,
          title: "تسجيل الخروج",
          onPressed: () {
            context.read<UserTokenCubit>().delete();
            context.read<AuthorizedUserCubit>().delete();
            RouteHelper().loginScreen(context, isClearStack: true);
          },
        ),
      ];
}
