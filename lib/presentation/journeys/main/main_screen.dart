import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/user_type.dart';
import 'package:yamaiter/presentation/journeys/main/client/client_main_screen.dart';
import 'package:yamaiter/presentation/journeys/main/lawyer/lawyer_main_screen.dart';
import 'package:yamaiter/presentation/logic/common/notifications_listeners/notifications_listeners_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../../common/classes/notification_handler.dart';
import '../../../common/enum/notifications_listeners.dart';
import '../../../common/functions/get_authoried_user.dart';
import '../../../common/screen_utils/screen_util.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _initScreenUtil();

    _interactedMessageWhenAppIsOpenedInBackground();
    _interactedMessageWhenAppIsTerminated();
    _updateNotificationsListeners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizedUserCubit, AuthorizedUserState>(
      builder: (context, state) {
        if (state.currentUserType == UserType.client) {
          return const ClientMainScreen();
        }

        return const LawyerMainScreen();
      },
    );
  }

  /// to ensure init ScreenUtil
  void _initScreenUtil() {
    if (ScreenUtil.screenHeight == 0) {
      final h = MediaQuery.of(context).size.height;
      final w = MediaQuery.of(context).size.width;
      ScreenUtil.init(height: h, width: w);
    }
  }

  /// To interact with clicked notification when app is open in background
  Future<void> _interactedMessageWhenAppIsOpenedInBackground() async {
    ///==> Also handle any interaction when the app is in the background via a
    ///==> Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("MainScreen >> _interactedMessageWhenAppIsOpenedInBackground");

      NotificationHandler(context, remoteMessage: message).navigateToThePage();
    });
  }

  /// To interact with clicked notification when app is terminated
  void _interactedMessageWhenAppIsTerminated() async {
    ///==> Get any messages which caused the application to open from
    ///==> a terminated state.
    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    ///==> If the message also contains a data property with a "type" of "chat",
    ///==> navigate to a chat screen
    if (remoteMessage != null) {
      log("MainScreen >> _interactedMessageWhenAppIsTerminated");
      if (context.mounted) {
        NotificationHandler(context, remoteMessage: remoteMessage)
            .navigateToThePage();
      }
    }
  }

  void _updateNotificationsListeners() {
    if (isCurrentUserLawyer(context)) {
      context.read<NotificationsListenersCubit>().tryUpdateTasksListeners(
        valueToUpdate: {
          NotificationsListeners.tasks.name: true,
          NotificationsListeners.sos.name: true,
        },
        lawyerUser: isCurrentUserLawyer(context),
      );
    }
  }
}
