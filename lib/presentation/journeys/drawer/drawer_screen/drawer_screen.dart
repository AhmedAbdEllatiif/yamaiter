import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/enum/side_menu_page.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/journeys/drawer/drawer_item.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/animation_type.dart';
import '../../../../domain/entities/screen_arguments/side_menu_page_args.dart';
import '../../../logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../widgets/image_name_rating_widget.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

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
                  name: context
                      .read<AuthorizedUserCubit>()
                      .state
                      .userEntity
                      .firstName,
                  imgUrl: AssetsImages.personAvatar,
                  rating: 3,
                  onPressed: () {
                    RouteHelper().editProfile(context);
                  },
                ),

                /// text balance
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "الرصيد الحالى: ",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColor.white)),
                    TextSpan(
                        text: "1500",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                )),
                    TextSpan(
                        text: " نقطة",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColor.white))
                  ]),
                )
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
      RouteHelper().chatScreen(context);
  
  void _navigateMyTaxesScreen(BuildContext context) =>
      RouteHelper().myTaxesScreen(context, isReplacement: false);

  void _navigateMyTasksScreen(BuildContext context) =>
      RouteHelper().chooseTasks(context);

  void _navigateMyArticlesScreen(BuildContext context) =>
      RouteHelper().myArticlesScreen(context, isReplacement: false);

  void _navigateToHelpScreen(BuildContext context) =>
      RouteHelper().helpScreen(context);

  void _navigateToSettingsScreen(BuildContext context) =>
      RouteHelper().settingsScreen(context);

  void _navigateMySosListScreen(BuildContext context) =>
      RouteHelper().mySosScreen(context);

  void _navigateMyAdsListScreen(BuildContext context) =>
      RouteHelper().myAdsScreen(context, isReplacement: false);

  void _navigateToAboutScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "من نحن", sideMenuPage: SideMenuPage.about),
      );

  void _navigateToTermsAndConditionsScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "شروط الاستخدام",
            sideMenuPage: SideMenuPage.termsAndConditions),
      );

  void _navigateToPrivacyScreen(BuildContext context) =>
      RouteHelper().sideMenuPage(
        context,
        arguments: SideMenuPageArguments(
            pageTitle: "سياسة الخصوصية", sideMenuPage: SideMenuPage.privacy),
      );

  List<Widget> drawerItems(BuildContext context) => [
        DrawerItem(
          iconData: Icons.shopping_bag_outlined,
          title: "مهامى",
          onPressed: () => _navigateMyTasksScreen(context),
        ),
        DrawerItem(
          iconData: Icons.list_alt_outlined,
          title: "منشوراتى",
          onPressed: () => _navigateMyArticlesScreen(context),
        ),
        DrawerItem(
          iconData: Icons.surround_sound_outlined,
          title: "إعلاناتى",
          onPressed: () => _navigateMyAdsListScreen(context),
        ),
        DrawerItem(
          iconData: Icons.shopping_bag_outlined,
          title: "اقراراتى الضريبية",
          onPressed: () => _navigateMyTaxesScreen(context),
        ),
        DrawerItem(
          iconData: Icons.sos_outlined,
          title: "نداءات الاستغاثة",
          onPressed: () => _navigateMySosListScreen(context),
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
          iconData: Icons.help_outline_outlined,
          title: "المساعدة",
          onPressed: () => _navigateToHelpScreen(context),
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
