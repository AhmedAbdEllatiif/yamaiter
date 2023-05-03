import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/side_menu_page.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widget_extension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/journeys/drawer/drawer_item.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/assets_constants.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/animation_type.dart';
import '../../../../domain/entities/screen_arguments/side_menu_page_args.dart';
import '../../../logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../widgets/balance_widget.dart';
import '../../../widgets/image_name_rating_widget.dart';

class DrawerScreenClient extends StatefulWidget {
  const DrawerScreenClient({Key? key}) : super(key: key);

  @override
  State<DrawerScreenClient> createState() => _DrawerScreenClientState();
}

class _DrawerScreenClientState extends State<DrawerScreenClient> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = drawerItems(context);
    return Container(
      color: AppColor.primaryDarkColor,
      padding: EdgeInsets.only(
        top: Sizes.dimen_20.h,
        right: Sizes.dimen_30.w,
        left: Sizes.dimen_30.w,
      ),
      child: Column(
        children: [
          Container(
            color: AppColor.primaryDarkColor,
            height: ScreenUtil.screenHeight * 0.10,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Avatar and rating
                BlocBuilder<AuthorizedUserCubit, AuthorizedUserState>(
                  builder: (context, state) {
                    return ImageNameRatingWidget(
                      name: state.userEntity.firstName,
                      imgUrl: state.userEntity.userAvatar,
                      rating: 3,
                      showRating: false,
                      onPressed: () {
                        RouteHelper().editProfile(context);
                      },
                    );
                  },
                ),

                /// BalanceWidget
                const BalanceWidget(),
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
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 50,
              ),
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

  /// to ContactUsScreen
  void _navigateToContactUsScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "تواصل معنا", sideMenuPage: SideMenuPage.contactUs),
      );

  /// to charge balance screen
  void _navigateToChargeBalance(BuildContext context) =>
      RouteHelper().chargeBalanceScreen(context);

  /// DrawerItems
  List<Widget> drawerItems(BuildContext context) => [
        DrawerItem(
          // iconData: Icons.shopping_bag_outlined,
          svgImage: AssetsImages.briefcaseSvg,
          imgColor: AppColor.white,
          imgSize: Sizes.dimen_20.w,
          title: "طلبات المساعدة القانونية",
          onPressed: () => _navigateMyTasksScreen(context),
        ),

        DrawerItem(
          //iconData: Icons.list_alt_outlined,
          svgImage: AssetsImages.documentsSvg,
          imgColor: AppColor.white,
          imgSize: Sizes.dimen_20.w,
          title: "استشاراتى القانونية",
          onPressed: () => _navigateMyConsultationsScreen(context),
        ),
        DrawerItem(
          // iconData: Icons.surround_sound_outlined,
          svgImage: AssetsImages.publishAdSvg,
          imgColor: AppColor.white,
          imgSize: Sizes.dimen_20.w,
          title: "إعلاناتى",
          onPressed: () => _navigateMyAdsListScreen(context),
        ),
        DrawerItem(
          // iconData: Icons.chat_outlined,
          svgImage: AssetsImages.chatSvg,
          imgColor: AppColor.white,
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
          //iconData: Icons.shield_outlined,
          svgImage: AssetsImages.privacySvg,
          imgColor: AppColor.white,
          imgSize: Sizes.dimen_20.w,
          title: "سياسة الخصوصية",
          onPressed: () => _navigateToPrivacyScreen(context),
        ),
        DrawerItem(
          //iconData: Icons.shield_outlined,
          svgImage: AssetsImages.privacySvg,
          imgColor: AppColor.white,
          imgSize: Sizes.dimen_20.w,
          title: "شروط الاستخدام",
          onPressed: () => _navigateToTermsAndConditionsScreen(context),
        ),
        DrawerItem(
          iconData: Icons.account_balance_wallet_outlined,
          title: "شحن المحفظة",
          onPressed: () => _navigateToChargeBalance(context),
        ),

        DrawerItem(
          iconData: Icons.question_mark_outlined,
          title: "اتصل بنا",
          onPressed: () => _navigateToContactUsScreen(context),
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
