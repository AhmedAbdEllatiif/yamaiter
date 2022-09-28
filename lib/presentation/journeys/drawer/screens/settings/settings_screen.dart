import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/item_with_arrow_next.dart';
import 'package:yamaiter/presentation/widgets/title_with_divider.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../common/screen_utils/screen_util.dart';
import '../../../../../router/route_helper.dart';
import '../../../../widgets/static_pages_title_widget.dart';
import 'notifiaction_item_switcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الاعدادات")),

      /// body
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_12.h, horizontal: Sizes.dimen_12.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==> title
              const StaticPageTitleWidget(title: "الاعدادات"),

              Container(
                padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                child: Column(
                  children: [
                    //==> person icon with text
                    const TitleWithDivider(
                      titleIcon: Icon(
                        Icons.person,
                        color: AppColor.primaryDarkColor,
                      ),
                      title: "ملفى الشخصى",
                    ),

                    //==> edit my profile
                    ItemWithArrowNext(
                      title: "تعديل الملف الشخصى",
                      onPressed: () => _navigateToEditProfile(),
                    ),
                    ItemWithArrowNext(
                      title: "تعديل كلمة المرور",
                      onPressed: () => _navigateToEditPassword(),
                    ),

                    /// notification center card
                    Card(
                      margin: EdgeInsets.only(top: Sizes.dimen_10.h),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Sizes.dimen_10.h,
                            horizontal: Sizes.dimen_10.w),
                        child: Column(
                          children: [
                            const TitleWithDivider(
                              titleIcon: Icon(
                                Icons.notifications_active_outlined,
                                color: AppColor.primaryDarkColor,
                              ),
                              title: "الاشعارات",
                            ),
                            const NotificationItemSwitcher(
                              title: "مهام جديدة",
                            ),
                            const NotificationItemSwitcher(
                              title: "منشورات جديدة",
                            ),
                            const NotificationItemSwitcher(
                              title: "نداءات الاستغاثة",
                            ),
                            const NotificationItemSwitcher(
                              title: "المحادثات",
                            ),
                            SizedBox(
                              height: Sizes.dimen_50.h,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEditProfile() => RouteHelper().editProfile(context);

  void _navigateToEditPassword() => RouteHelper().editPasswordScreen(context);
}
