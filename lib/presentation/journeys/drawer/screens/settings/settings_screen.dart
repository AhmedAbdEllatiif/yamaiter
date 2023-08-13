import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/common/functions/navigate_to_login.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/logic/common/notifications_listeners/notifications_listeners_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/item_with_arrow_next.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/presentation/widgets/title_with_divider.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../common/enum/app_error_type.dart';
import '../../../../../common/enum/notifications_listeners.dart';
import '../../../../../common/functions/get_authoried_user.dart';
import '../../../../../router/route_helper.dart';
import '../../../../logic/common/delete_remote_user/delete_remote_user_cubit.dart';
import '../../../../logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../widgets/app_bottom_sheet.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_content_title_widget.dart';
import '../../../../widgets/app_error_widget.dart';
import 'notifiaction_item_switcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final DeleteRemoteUserCubit _deleteUserCubit;

  @override
  void initState() {
    super.initState();
    _deleteUserCubit = getItInstance<DeleteRemoteUserCubit>();
  }

  @override
  void dispose() {
    _deleteUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _deleteUserCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text("الاعدادات")),

        /// body
        body: BlocListener<DeleteRemoteUserCubit, DeleteRemoteUserState>(
          listener: (context, state) {
            // clear data onSuccess
            if (state is UserDeletedSuccessfully) {
              _clearUserLocalData();
            }
          },
          child: Padding(
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

                        /// delete user
                        ItemWithArrowNext(
                          title: "حذف الحساب الشخصى",
                          onPressed: () => _openDeleteUserSheet(),
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
                                                NotificationsListeners
                                                    .tasks.name: value
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

  /// to open the bottom sheet to enter the service name
  void _openDeleteUserSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocBuilder<DeleteRemoteUserCubit, DeleteRemoteUserState>(
          bloc: _deleteUserCubit,
          builder: (context, state) {
            //
            // UnAuthorizedToDeleteUser
            //
            //
            if (state is UnAuthorizedToDeleteUser) {
              Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.unauthorizedUser,
                  buttonText: "تسجيل الدخول",
                  onPressedRetry: () {
                    navigateToLogin(context);
                  },
                ),
              );
            }

            return AppBottomSheet(
              title: "حذف الحساب الشخصى",
              child: state is LoadingDeleteUser
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: LoadingWidget(),
                      ),
                    )
                  : Column(
                      children: [
                        Text(
                          "بحذف الحساب ، سيتم حذف جميع البيانات الحالية",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),

                        /// space
                        const SizedBox(height: 50),

                        Center(
                          child: AppButton(
                            text: "الغاء",
                            width: double.infinity,
                            color: AppColor.primaryDarkColor,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        /// space
                        const SizedBox(height: 20),

                        Center(
                          child: AppButton(
                            color: Colors.red,
                            text: "تأكيد الحذف",
                            textColor: AppColor.red,
                            isTextButton: true,
                            onPressed: () => _tryToDeleteUser(),
                          ),
                        ),
                      ],
                    ),
            );
          },
        );
      },
    );
  }

  ///
  /// to delete user
  ///
  ///
  void _tryToDeleteUser() {
    final userToken = getUserToken(context);
    final userId = getAuthorizedUserEntity(context).id.toString();
    _deleteUserCubit.tryToDeleteUser(userToken: userToken, userId: userId);
  }

  ///
  /// to delete all local user data
  ///
  ///
  void _clearUserLocalData() {
    context.read<UserTokenCubit>().delete();
    context.read<AuthorizedUserCubit>().delete();
    RouteHelper().loginScreen(context, isClearStack: true);
  }
}
