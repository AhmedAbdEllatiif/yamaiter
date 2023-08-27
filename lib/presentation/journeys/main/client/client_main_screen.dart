import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/presentation/journeys/all_lawyers/all_lawyers_widget.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/choose_to_add/choose_to_add_screen__client.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/home/client/home_page_client.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/home/all_articles_screen.dart';
import 'package:yamaiter/presentation/journeys/drawer/drawer_screen/drawer_screen_client.dart';
import 'package:yamaiter/presentation/widgets/custom_app_bar.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/assets_constants.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/ads_pages.dart';
import '../../../../common/screen_utils/screen_util.dart';
import '../../../../di/git_it_instance.dart';
import '../../../logic/cubit/get_all_articles/get_all_articles_cubit.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/ads_widget.dart';
import '../main_page_title.dart';

class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({Key? key}) : super(key: key);

  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final ScrollController allSosController = ScrollController();
  final ScrollController allArticlesController = ScrollController();
  final ScrollController allTasksController = ScrollController();

  late final GetAllArticlesCubit _getAllArticlesCubit;

  @override
  void initState() {
    super.initState();
    _getAllArticlesCubit = getItInstance<GetAllArticlesCubit>();
    _initScreenUtil();
    _fetchMyArticlesList();
  }

  @override
  void dispose() {
    _getAllArticlesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// _scaffoldKey
      key: _scaffoldKey,

      /// appBar
      appBar: CustomAppBar(
        context: context,
        onMenuPressed: () => _openDrawer(),
        onSearchPressed: () => _navigateToSearchForLawyer(),
      ),

      /// drawer
      drawer: const DrawerScreenClient(),

      /// body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Ads ListView
          const AdsWidget(adsPage: AdsPage.main),

          /// title with add new Tasks
          if (_selectedIndex != 2)
            Padding(
              padding: EdgeInsets.only(
                  //bottom: AppUtils.mainPagesVerticalPadding.h,
                  right: AppUtils.mainPagesHorizontalPadding.w,
                  left: AppUtils.mainPagesVerticalPadding.h),
              child: MainPageTitle(
                title: clientPageTitles[_selectedIndex],
                iconData:
                    _selectedIndex == 4 ? Icons.filter_list_outlined : null,
                onPressed:
                    _selectedIndex == 4 ? () => _navigateTFilterTask() : null,
              ),
            ),

          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                right: AppUtils.mainPagesHorizontalPadding.w,
                left: AppUtils.mainPagesVerticalPadding.h,
              ),
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  /*Center(
                    child: Text("Client Home"),
                  ),*/
                  const HomePageClient(),

                  /// AllArticles
                  AllArticlesScreen(
                    getAllArticlesCubit: _getAllArticlesCubit,
                  ),

                  /// ChooseToAddScreenClientUser
                  const ChooseToAddScreenClientUser(),

                  /// AllLawyers
                  const AllLawyerList(),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        // currentIndex
        selectedIndex: _selectedIndex,

        // onTap
        onDestinationSelected: _onItemTapped,

        // animation duration
        animationDuration: const Duration(milliseconds: 1000),

        // destinations
        destinations: _clientDestinations(),
      ),
    );
  }

  /// Pages titles
  final clientPageTitles = [
    "",
    // "محامين متمزين",
    "كل المنشورات",
    "",
    "كل المحامين",
  ];

  /// to open drawer
  void _openDrawer() {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  /// change selected index
  void _onItemTapped(int index) {
    if (index == 0) {}
    setState(() {
      _selectedIndex = index;
    });
  }

  /// to ensure init ScreenUtil
  void _initScreenUtil() {
    if (ScreenUtil.screenHeight == 0) {
      final h = MediaQuery.of(context).size.height;
      final w = MediaQuery.of(context).size.width;
      ScreenUtil.init(height: h, width: w);
    }
  }

  /// to fetch Articles list
  void _fetchMyArticlesList() {
    _getAllArticlesCubit.fetchAllArticlesList(
      userToken: getUserToken(context),
      currentListLength: 0,
      offset: 0,
    );
  }

  /// to navigate to search for lawyer
  void _navigateToSearchForLawyer() {
    RouteHelper().searchForLawyer(context);
  }

  /// to navigate to filter tasks
  void _navigateTFilterTask() {
    RouteHelper().filterTasks(context);
  }

  List<Widget> _clientDestinations() {
    return [
      /// home
       NavigationDestination(
        //==> icon
        // icon: IconWithBadge(
        //   iconData: Icons.home_outlined,
        //   onPressed: () {
        //     setState(() {
        //       _selectedIndex = 0;
        //     });
        //   },
        // ),
        icon: SvgPicture.asset(AssetsImages.homeSvg,
            height: Sizes.dimen_26.w,
            width: Sizes.dimen_26.w,
            color: AppColor.primaryColor,
            semanticsLabel: ''),

        selectedIcon: SvgPicture.asset(AssetsImages.homeSvg,
            height: Sizes.dimen_22.w,
            width: Sizes.dimen_22.w,
            color: AppColor.primaryDarkColor,
            semanticsLabel: ''),
        //==> label
        label: 'الرئيسية',
      ),

      /// articles
      NavigationDestination(
        // icon: Icon(
        //   Icons.book_online_outlined,
        //   color: AppColor.primaryColor,
        // ),
        icon: SvgPicture.asset(AssetsImages.documentsSvg,
            height: Sizes.dimen_30.w,
            width: Sizes.dimen_30.w,
            color: AppColor.primaryColor,
            semanticsLabel: ''),

        selectedIcon: SvgPicture.asset(AssetsImages.documentsSvg,
            height: Sizes.dimen_26.w,
            width: Sizes.dimen_26.w,
            color: AppColor.primaryDarkColor,
            semanticsLabel: ''),
        // selectedIcon: Icon(
        //   Icons.book_online,
        //   color: AppColor.primaryDarkColor,
        // ),
        label: 'المنشورات',
      ),

      /// add
      NavigationDestination(
        icon: Container(
          padding: EdgeInsets.all(Sizes.dimen_5.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.primaryColor),
            // borderRadius: BorderRadius.circular(10)
          ),
          child: const Icon(
            Icons.add,
            color: AppColor.primaryColor,
            size: 30,
          ),
        ),
        selectedIcon: Container(
          padding: EdgeInsets.all(Sizes.dimen_5.w),
          child: const Icon(
            Icons.add_outlined,
            color: AppColor.primaryDarkColor,
            size: 30,
          ),
        ),
        label: 'اضافة',
      ),

      /// AllLawyers
      NavigationDestination(
        // icon: Icon(
        //   Icons.book_online_outlined,
        //   color: AppColor.primaryColor,
        // ),
        icon: SvgPicture.asset(AssetsImages.personsSvg,
            height: Sizes.dimen_26.w,
            width: Sizes.dimen_26.w,
            color: AppColor.primaryColor,
            semanticsLabel: ''),

        selectedIcon: SvgPicture.asset(AssetsImages.personsSvg,
            height: Sizes.dimen_24.w,
            width: Sizes.dimen_24.w,
            color: AppColor.primaryDarkColor,
            semanticsLabel: ''),
        // selectedIcon: Icon(
        //   Icons.book_online,
        //   color: AppColor.primaryDarkColor,
        // ),
        label: 'المحامين',
      ),
    ];
  }
}
