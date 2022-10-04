import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/home_screen.dart';
import 'package:yamaiter/presentation/widgets/custom_app_bar.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../../domain/entities/data/ad_entity.dart';
import '../../themes/theme_color.dart';
import '../../widgets/ads_list/ads_list_view.dart';
import '../../widgets/icon_with_badge.dart';
import '../sos/create_sos_screen.dart';
import '../drawer/drawer_screen/drawer_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _initScreenUtil();
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
      ),

      /// drawer
      drawer: const DrawerScreen(),

      /// body
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppUtils.mainPagesHorizontalPadding.w,
            vertical: AppUtils.mainPagesVerticalPadding.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Ads ListView
            const AdsListViewWidget(
              adsList: [
                AdEntity(id: 0, url: AssetsImages.adSample),
                AdEntity(id: 1, url: AssetsImages.adSample),
                AdEntity(id: 1, url: AssetsImages.adSample),
              ],
            ),

            _currentSelectedPage(_selectedIndex),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        // currentIndex
        selectedIndex: _selectedIndex,

        // onTap
        onDestinationSelected: _onItemTapped,

        // animation duration
        animationDuration: const Duration(milliseconds: 1000),

        // destinations
        destinations: _currentDestinations(),
      ),
    );
  }

  void _openDrawer() {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

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

  List<Widget> _currentDestinations() {
    return [
      /// home
      NavigationDestination(
        //==> icon
        icon: IconWithBadge(
          iconData: Icons.home_outlined,
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),

        //==> selected icon
        selectedIcon: const Icon(
          Icons.home,
          color: AppColor.primaryDarkColor,
        ),

        //==> label
        label: 'الرئيسية',
      ),

      /// sos
      const NavigationDestination(
        //==> icon
        icon: Icon(
          Icons.sos,
          color: AppColor.primaryColor,
        ),
        //==>selectedIcon
        selectedIcon: Icon(
          Icons.sos_outlined,
          color: AppColor.primaryDarkColor,
        ),
        label: "الاستغاثات",
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
        label: 'اضافة منشور',
      ),

      /// articles
      const NavigationDestination(
        icon: Icon(
          Icons.book_online_outlined,
          color: AppColor.primaryColor,
        ),
        selectedIcon: Icon(
          Icons.book_online,
          color: AppColor.primaryDarkColor,
        ),
        label: 'المنشورات',
      ),

      ///
      const NavigationDestination(
        icon: Icon(
          Icons.shopping_bag_outlined,
          color: AppColor.primaryColor,
        ),
        selectedIcon: Icon(
          Icons.shopping_bag,
          color: AppColor.primaryDarkColor,
        ),
        label: 'المهمات',
      ),
    ];
  }

  Widget _currentSelectedPage(int index) {
    if (index == 0) {
      return HomeScreen();
    }


    return HomeScreen();
  }
}
