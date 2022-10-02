import 'package:flutter/material.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/home_screen.dart';
import 'package:yamaiter/presentation/widgets/custom_app_bar.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../themes/theme_color.dart';
import '../../widgets/icon_with_badge.dart';
import '../bottom_nav_screens/sos_screen.dart';
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
      drawer: DrawerScreen(),

      /// body
      body:_currentSelectedPage(_selectedIndex),

      bottomNavigationBar: NavigationBar(
        // currentIndex
        selectedIndex: _selectedIndex,

        // onTap
        onDestinationSelected: _onItemTapped,

        // destinations
        destinations: _currentDestinations(),
      ),

      floatingActionButton: _selectedIndex == 0
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  child: const Icon(
                    Icons.add,
                    color: AppColor.primaryDarkColor,
                  ),
                  onPressed: () {},
                ),
                /*const Text(
                  "Add Article",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )*/
              ],
            )
          : null,

      /* bottomNavigationBar: NavigationBar(
        backgroundColor: AppColor.primaryDarkColor,
        selectedItemColor: AppColor.white,
        unselectedItemColor: AppColor.white.withOpacity(0.3),
        type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sos_outlined),
            label: "الاستغاثات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            label: 'المنشورات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'اضافة منشور',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'المهمات',
          ),BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined),
            label: 'الاشعارات',
          ),
        ],

        // currentIndex
        currentIndex: _selectedIndex,

        // onTap
        onTap: _onItemTapped,
      ),*/
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

  List<Widget> _whiteDestinations() {
    return [
      /// home
      NavigationDestination(
        //==> icon with badge
        icon: IconWithBadge(
          iconData: Icons.home_outlined,
          iconColor: AppColor.white,
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),

        //==> selected icon
        selectedIcon: IconButton(
          icon: const Icon(
            Icons.home,
            color: AppColor.white,
            size: 40,
          ),
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),

        //==> label
        label: 'الرئيسية',
      ),

      /// sos
      NavigationDestination(
        //==> icon with badge
        icon: IconWithBadge(
          iconData: Icons.sos_outlined,
          iconColor: AppColor.white,
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),

        //==> selected icon
        selectedIcon: const Icon(
          Icons.sos,
          color: AppColor.white,
          size: 40,
        ),
        label: "الاستغاثات",
      ),

      /// book
      const NavigationDestination(
        icon: Icon(
          Icons.book_online_outlined,
          color: AppColor.primaryColor,
        ),
        selectedIcon: Icon(
          Icons.book_online,
          color: AppColor.white,
          size: 40,
        ),
        label: 'المنشورات',
      ),
      // NavigationDestination(
      //   icon: Icon(
      //     Icons.add,
      //     color: AppColor.primaryColor,
      //   ),
      //   selectedIcon: Icon(
      //     Icons.add_outlined,
      //     color: AppColor.primaryDarkColor,
      //   ),
      //   label: 'اضافة منشور',
      // ),
      const NavigationDestination(
        icon: Icon(
          Icons.shopping_bag_outlined,
          color: AppColor.white,
        ),
        selectedIcon: Icon(
          Icons.shopping_bag,
          color: AppColor.white,
          size: 40,
        ),
        label: 'المهمات',
      ),
      // NavigationDestination(
      //   icon: Icon(
      //     Icons.notifications_active_outlined,
      //     color: AppColor.white,
      //   ),
      //   selectedIcon: Icon(
      //     Icons.notifications_active,
      //     color: AppColor.white,
      //  size: 40,
      //   ),
      //   label: 'الاشعارات',
      // ),
    ];
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
      const NavigationDestination(
        icon: Icon(
          Icons.sos,
          color: AppColor.primaryColor,
        ),
        selectedIcon: Icon(
          Icons.sos_outlined,
          color: AppColor.primaryDarkColor,
        ),
        label: "الاستغاثات",
      ),
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
      // NavigationDestination(
      //   icon: Icon(
      //     Icons.add,
      //     color: AppColor.primaryColor,
      //   ),
      //   selectedIcon: Icon(
      //     Icons.add_outlined,
      //     color: AppColor.primaryDarkColor,
      //   ),
      //   label: 'اضافة منشور',
      // ),
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
      // NavigationDestination(
      //   icon: Icon(
      //     Icons.notifications_active,
      //     color: AppColor.primaryColor,
      //   ),
      //   selectedIcon: Icon(
      //     Icons.notifications_active_outlined,
      //     color: AppColor.primaryDarkColor,
      //   ),
      //   label: 'الاشعارات',
      // ),
    ];
  }


  Widget _currentSelectedPage(int index){
    if(index == 0){
      return HomeScreen();
    }
    if(index == 1){
      return SosScreen();
    }

    return HomeScreen();
  }
}
