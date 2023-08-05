import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/logic/common/notifications_listeners/notifications_listeners_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/item_with_arrow_next.dart';
import 'package:yamaiter/presentation/widgets/title_with_divider.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../common/enum/notifications_listeners.dart';
import '../../../../../common/functions/get_authoried_user.dart';
import '../../../../../router/route_helper.dart';
import '../../../../widgets/app_content_title_widget.dart';
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
              const AppContentTitleWidget(title: "الاعدادات"),

              Container(
                padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                child: Column(
                  children: [
                    /// person icon with text
                    const TitleWithDivider(
                      titleIcon: Icon(
                        Icons.person,
                        color: AppColor.primaryDarkColor,
                      ),
                      title: "ملفى الشخصى",
                    ),

                    /// edit my profile
                    ItemWithArrowNext(
                      title: "تعديل الملف الشخصى",
                      onPressed: () => _navigateToEditProfile(),
                    ),

                    /// edit password
                    ItemWithArrowNext(
                      title: "تعديل كلمة المرور",
                      onPressed: () => _navigateToEditPassword(),
                    ),

                    /// notification center card
                    BlocBuilder<NotificationsListenersCubit,
                        NotificationsListenersState>(
                      builder: (context, state) {
                        return Card(
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

                                ///==> new articles
                                NotificationItemSwitcher(
                                  currentValue: state.listeners[
                                          NotificationsListeners
                                              .articles.name] ??
                                      true,
                                  title: "منشورات جديدة",
                                  onChanged: (value) {
                                    _updateNotificationsListeners({
                                      NotificationsListeners.articles.name:
                                          value
                                    });
                                  },
                                ),

                                if (isCurrentUserLawyer(context))
                                  Column(
                                    children: [
                                      ///==> new tasks
                                      NotificationItemSwitcher(
                                        title: "مهام جديدة",
                                        currentValue: state.listeners[
                                                NotificationsListeners
                                                    .tasks.name] ??
                                            true,
                                        onChanged: (value) {
                                          _updateNotificationsListeners({
                                            NotificationsListeners.tasks.name:
                                                value
                                          });
                                        },
                                      ),

                                      ///==> sos
                                      NotificationItemSwitcher(
                                        currentValue: state.listeners[
                                                NotificationsListeners
                                                    .sos.name] ??
                                            true,
                                        title: "نداءات الاستغاثة",
                                        onChanged: (value) {
                                          _updateNotificationsListeners({
                                            NotificationsListeners.sos.name:
                                                value
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                ///==> chats
                                // NotificationItemSwitcher(
                                //   title: "المحادثات",
                                //   onChanged: (value) {},
                                // ),
                                SizedBox(
                                  height: Sizes.dimen_50.h,
                                )
                              ],
                            ),
                          ),
                        );
                      },
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

  void _updateNotificationsListeners(Map<String, bool> value) {
    context.read<NotificationsListenersCubit>().tryUpdateTasksListeners(
          valueToUpdate: value,
          lawyerUser: isCurrentUserLawyer(context),
        );
  }
}
