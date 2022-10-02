import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/enum/side_menu_page.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/extensions/widgetExtension.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/journeys/drawer/drawer_screen/drawer_item.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/animation_type.dart';
import '../../../../domain/entities/screen_arguments/side_menu_page_args.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        RouteHelper().editProfile(context);
                      },
                      child: CircleAvatar(
                        minRadius: Sizes.dimen_30.w,
                        backgroundImage: AssetImage(
                          AssetsImages.personAvatar,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "John Micheal",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColor.white),
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            itemSize: Sizes.dimen_16.w,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            unratedColor: AppColor.accentColor.withOpacity(0.5),
                            ignoreGestures: true,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColor.accentColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
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
            child: Divider(
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

  void _navigateToHelpScreen(BuildContext context) =>
      RouteHelper().helpScreen(context);

  void _navigateToSettingsScreen(BuildContext context) =>
      RouteHelper().settingsScreen(context);

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
          onPressed: () {},
        ),
        DrawerItem(
          iconData: Icons.list_alt_outlined,
          title: "منشوراتى",
          onPressed: () {},
        ),
        DrawerItem(
          iconData: Icons.surround_sound_outlined,
          title: "إعلاناتى",
          onPressed: () {},
        ),
        DrawerItem(
          iconData: Icons.shopping_bag_outlined,
          title: "اقراراتى الضريبية",
          onPressed: () {},
        ),
        DrawerItem(
          iconData: Icons.sos_outlined,
          title: "نداءات الاستغاثة",
          onPressed: () {},
        ),
        DrawerItem(
          iconData: Icons.chat_outlined,
          title: "المحادثات",
          onPressed: () {},
        ),
        DrawerItem(
          iconData: Icons.settings_outlined,
          title: "الاعدادت",
          onPressed: () {
            _navigateToSettingsScreen(context);
          },
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
          onPressed: () {
            _navigateToPrivacyScreen(context);
          },
        ),
        DrawerItem(
          iconData: Icons.shield_outlined,
          title: "شروط الاستخدام",
          onPressed: () {
            _navigateToTermsAndConditionsScreen(context);
          },
        ),
        DrawerItem(
          iconData: Icons.help_outline_outlined,
          title: "المساعدة",
          onPressed: () {
            _navigateToHelpScreen(context);
          },
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
            RouteHelper().loginScreen(context, isClearStack: true);
          },
        ),
      ];
}
