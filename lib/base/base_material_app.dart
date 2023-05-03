import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/journeys/login/login_screen.dart';
import 'package:yamaiter/presentation/journeys/main/main_screen.dart';
import 'package:yamaiter/presentation/logic/common/notifications_listeners/notifications_listeners_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/user_token/user_token_cubit.dart';
import '../common/functions/firebase.dart';
import '../main.dart';
import '../presentation/journeys/on_boarding/on_boarding_screen.dart';
import '../presentation/logic/common/store_fb_token/store_firebase_token_cubit.dart';
import '../presentation/logic/cubit/first_launch/first_launch_cubit.dart';
import '../presentation/themes/theme_color.dart';
import '../router/transition_page_route.dart';

import '../router/routes.dart';

class BaseMaterialApp extends StatefulWidget {
  const BaseMaterialApp({Key? key}) : super(key: key);

  @override
  State<BaseMaterialApp> createState() => _BaseMaterialAppState();
}

class _BaseMaterialAppState extends State<BaseMaterialApp> {
  late final UserTokenCubit userToken;
  late final AuthorizedUserCubit authorizedUserCubit;
  late final NotificationsListenersCubit notificationsListenersCubit;

  /// FirstLaunchStatusCubit
  late final FirstLaunchStatusCubit firstLaunchCubit;

  /// StoreFirebaseTokenCubit
  late final StoreFirebaseTokenCubit _firebaseTokenCubit;

  @override
  void initState() {
    //==> current user token
    userToken = getItInstance<UserTokenCubit>();
    userToken.loadCurrentAutoLoginStatus();

    //==> current authorized token
    authorizedUserCubit = getItInstance<AuthorizedUserCubit>();
    authorizedUserCubit.loadCurrentAuthorizedUserData();

    //==> current authorized token
    notificationsListenersCubit = getItInstance<NotificationsListenersCubit>();
    notificationsListenersCubit.loadListeners();

    //==> firstLaunchCubit
    firstLaunchCubit = getItInstance<FirstLaunchStatusCubit>();
    firstLaunchCubit.loadFirstLaunchStatus();

    _firebaseTokenCubit = getItInstance<StoreFirebaseTokenCubit>();

    _interactedMessageWhenAppIsOpenedInBackground();
    _interactedMessageWhenAppIsTerminated();
    _showReceivedNotification();
    _storeFirebaseToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => userToken),
        BlocProvider(create: (context) => authorizedUserCubit),
        BlocProvider(create: (context) => notificationsListenersCubit),
        BlocProvider(create: (context) => firstLaunchCubit),
        BlocProvider(create: (context) => _firebaseTokenCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<NotificationsListenersCubit,
              NotificationsListenersState>(
            listener: (context, state) {
              handleTopicsSubscription(state.listeners);
              log("BaseMaterialApp >> state >> ${state.listeners}");
            },
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'YaMaiter',
          //navigatorKey: navigatorKey,

          /// builder ==> build with ResponsiveWrapper and break points
          builder: (context, widget) => Directionality(
            textDirection: TextDirection.rtl,
            child: ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.autoScale(220, name: "S"),
                const ResponsiveBreakpoint.resize(350, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(600, name: TABLET),
                const ResponsiveBreakpoint.resize(800, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
              ],
            ),
          ),

          /// main theme
          theme: ThemeData(
              textTheme: GoogleFonts.cairoTextTheme(
                Theme.of(context).textTheme,
              ),
              primaryColor: AppColor.primaryDarkColor,
              primaryColorDark: AppColor.primaryDarkColor,
              splashColor: AppColor.accentColor.withOpacity(0.3),
              shadowColor: AppColor.accentColor,
              unselectedWidgetColor: AppColor.white,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: AppColor.accentColor, // Your accent color
              ),

              /// navigationBarTheme
              navigationBarTheme: NavigationBarThemeData(
                height: 65,
                indicatorColor: AppColor.accentColor,
                //indicatorColor: Colors.transparent,
                backgroundColor: AppColor.primaryDarkColor,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                indicatorShape: const CircleBorder(),
                labelTextStyle: MaterialStateProperty.all(
                  const TextStyle(
                    //fontSize: 13.0,
                    //fontWeight: FontWeight.w700,
                    color: AppColor.white,
                    //letterSpacing: 1.0,
                  ),
                ),
              ),

              /// appBar theme
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColor.primaryDarkColor,
                elevation: 0.0,
                centerTitle: true,
              ),

              /// scaffoldBackgroundColor
              scaffoldBackgroundColor: Colors.white,

              /// default card theme
              cardTheme: const CardTheme(
                elevation: 10.0,
                shadowColor: AppColor.black,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppUtils.cornerRadius)),
                ),
              )),

          /// home
          // home: BlocBuilder<AuthorizedUserCubit, AuthorizedUserState>(
          //   builder: (context, state) {
          //     log("Main: $state");
          //     return MainScreen();
          //   },
          // ),
          home: BlocBuilder<UserTokenCubit, UserTokenState>(
            builder: (context, state) {
              if (state.userToken.isNotEmpty) {
                return const MainScreen();
              }
              return BlocBuilder<FirstLaunchStatusCubit, bool>(
                builder: (context, state) {
                  return state ? const OnBoardingScreen() : const LoginScreen();
                },
              );
            },
          ),
          onGenerateRoute: (RouteSettings settings) {
            final routes = Routes.getRoutes(settings);
            final WidgetBuilder? builder = routes[settings.name];
            return TransitionPageRouteBuilder(
              builder: builder!,
              customSettings: settings,
            );
          },
        ),
      ),
    );
  }

  /// dispose
  @override
  void dispose() {
    userToken.close();
    super.dispose();
  }

  /// store the firebase token on change
  void _storeFirebaseToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      _firebaseTokenCubit.tryToStoreFirebaseToken(
        userToken: getUserToken(context),
        firebaseToken: fcmToken,
      );
    }).onError((err) {
      log("BaseMaterialApp  >> _storeFirebaseToken >> $err");
    });
  }

  /// To interact with clicked notification when app is open in background
  Future<void> _interactedMessageWhenAppIsOpenedInBackground() async {
    ///==> Also handle any interaction when the app is in the background via a
    ///==> Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("_interactedMessageWhenAppIsOpenedInBackground");
      // _handleMessage(message);
    });
  }

  /// To interact with clicked notification when app is terminated
  Future<void> _interactedMessageWhenAppIsTerminated() async {
    ///==> Get any messages which caused the application to open from
    ///==> a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    ///==> If the message also contains a data property with a "type" of "chat",
    ///==> navigate to a chat screen
    if (initialMessage != null) {
      log("_interactedMessageWhenAppIsTerminated");
      //_handleMessage(initialMessage);
    }
  }

  /// show received notification banner
  void _showReceivedNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        /// insert into local data base
        // _insertNotificationIntoLocalDB(message);

        /// show notification
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
                visibility: NotificationVisibility.public),
          ),
        );
      }
    });
  }
}
