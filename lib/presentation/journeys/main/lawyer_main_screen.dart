import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/all_sos/all_sos_screen.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/all_tasks/all_task_screen.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/choose_to_add/choose_to_add_screen.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/home/home_screen.dart';
import 'package:yamaiter/presentation/widgets/custom_app_bar.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/ads_widget.dart';
import '../../widgets/icon_with_badge.dart';
import '../drawer/drawer_screen/drawer_screen.dart';
import 'main_page_title.dart';

class LawyerMainScreen extends StatefulWidget {
  const LawyerMainScreen({Key? key}) : super(key: key);

  @override
  State<LawyerMainScreen> createState() => _LawyerMainScreenState();
}

class _LawyerMainScreenState extends State<LawyerMainScreen> {
  /// GlobalKey on current scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// current selected index
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
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
      drawer: const DrawerScreen(),

      /// body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Ads ListView
          const AdsWidget(),

          /// title with add new Tasks
          if (_selectedIndex != 2)
            Padding(
              padding: EdgeInsets.only(
                  //bottom: AppUtils.mainPagesVerticalPadding.h,
                  right: AppUtils.mainPagesHorizontalPadding.w,
                  left: AppUtils.mainPagesVerticalPadding.h),
              child: MainPageTitle(
                title: titles[_selectedIndex],
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
                  left: AppUtils.mainPagesVerticalPadding.h),
              child: IndexedStack(
                index: _selectedIndex,
                children: const [
                  /// Home >> allArticles
                  AllArticlesScreen(),

                  /// AllSosScreen
                  AllSosScreen(),

                  /// ChooseToAddScreen
                  ChooseToAddScreen(),

                  /// unKnown
                  Center(
                    child: Text("Unknown"),
                  ),

                  /// AllTasksScreen
                  AllTasksScreen(),
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
        destinations: _lawyerDestinations(),
      ),
    );
  }

  /// Pages titles
  final titles = [
    "احدث المنشورات",
    "نداءات الاستغاثة",
    "",
    "Unknown",
    "مهام مطلوبة التنفيذ",
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

  /// to navigate to search for lawyer
  void _navigateToSearchForLawyer() {
    RouteHelper().searchForLawyer(context);
  }

  /// to navigate to filter tasks
  void _navigateTFilterTask() {
    RouteHelper().filterTasks(context);
  }

  List<Widget> _lawyerDestinations() {
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

      /// tasks
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
}
